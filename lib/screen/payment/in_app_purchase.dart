import 'dart:convert';
import 'dart:developer';

import 'package:cashfree/components/appBar.dart';
import 'package:cashfree/main.dart';
import 'package:cashfree/utils/putPurchase.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final InAppPurchase _inAppPurchase = InAppPurchase.instance;

class InAppPurchasePage extends StatefulWidget {
  const InAppPurchasePage({super.key});

  @override
  State<InAppPurchasePage> createState() => _InAppPurchasePageState();
}

class _InAppPurchasePageState extends State<InAppPurchasePage> {
  List<dynamic>? productDetails;

  load() async {
    Set<String> kIds = List<String>.from(userController.productId).toSet();
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      log("Error :  ${response.error}");
    }
    setState(() {
      productDetails = response.productDetails;
    });
  }

  @override
  void initState() {
    super.initState();

    load();
    _inAppPurchase.purchaseStream.listen((event) async {
      Set<PurchaseDetails> eventData = event.toSet();
      for (var element in eventData) {
        if (element.error == null) {
          try {
            log('Payment successful', name: 'Purchase');
            _inAppPurchase.completePurchase(element);

            Map json =
                jsonDecode(element.verificationData.localVerificationData);

            if (element.status.name == 'purchased' ||
                element.status.name == 'pending') {
              await putRequest(
                  status: element.status.name,
                  productId: element.productID,
                  purchaseId: element.purchaseID,
                  time: element.transactionDate,
                  quantity: json['quantity'].toString());
            }
          } catch (e) {
            log('Catch Error : ${e.toString()} ', name: 'Purchase');
          }
        } else {
          log('Error : ${element.error!.message} ', name: 'Purchase');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(appTitle: 'Payment'),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 10),
            if (productDetails != null)
              productDetails!.isEmpty
                  ? const Center(child: Text('No Redeem Pack Available'))
                  : Column(
                      children: productDetails!
                          .map((product) => PaymentTile(product: product))
                          .toList())
            else
              const Center(child: CircularProgressIndicator(strokeWidth: 3))
          ]),
        )));
  }
}

class PaymentTile extends StatelessWidget {
  final ProductDetails product;
  const PaymentTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Redeem Pack ${product.price}',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            ),
            Text(
              'You get in ${product.currencySymbol} ${product.rawPrice * .6} your bank',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(80),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              purchase(productDetails: product);
            },
            child: const Text('BUY'))
      ]),
    );
  }
}

purchase({required ProductDetails productDetails}) {
  final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails);
  _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
}
