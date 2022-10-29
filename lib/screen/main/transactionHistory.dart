import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http_requests/http_requests.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../../components/appBar.dart';
import '../../components/color.dart';
import '../../data/info.dart';
import '../../utils/transaction.dart';

class TransactionController extends GetxController {
  var isFinished = false.obs;
  var data = [].obs;
  var isLoading = true.obs;
  var isFetching = false.obs;

  updateFinished(value) => isFinished.value = value;
  updateData(value) => data.addAll(value);
  updateLoading(value) => isLoading.value = value;
  updateFetching(value) => isFetching.value = value;
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final transactionController = Get.put(TransactionController());

  fetchHistory() async {
    var data = {
      'user_id': userId,
      'user_mail': userMail,
      'user_key': userKey,
    };
    Response response = await HttpRequests.post(
        'https://www.secanonm.in/fastcash/api/payment/history.php',
        data: data,
        timeout: 120);
    var dataJson = response.json;
    if (dataJson['status'] == 'successful') {
      transactionController
          .updateData(List<Map<String, Object?>>.from(dataJson['data']));
    }

    transactionController.updateLoading(false);
  }

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(appTitle: 'Transaction History'),
        body: SingleChildScrollView(
          child: Obx(
            () => transactionController.isLoading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 160,
                    child: const Center(child: CircularProgressIndicator()))
                : Column(children: [
                    const SizedBox(height: 7),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 3)),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            'NOTICE',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "• If the payment status is pending, it may take upto 7 working days to process.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    ...transactionController.data.map(
                      (element) => TransactionTile(
                        type: element['payment_type'].toString(),
                        amount: element['amount'].toString(),
                        time: (element['payment_time']).toString(),
                        method: element['purchase_id'].toString(),
                        txnid: element['purchase_id'].toString(),
                        status: element['payment_status'].toString(),
                      ),
                    ),
                  ]),
          ),
        ));
  }
}

class TransactionTile extends StatefulWidget {
  final String amount;
  final String type;
  final String time;
  final String method;
  final String txnid;
  final String status;
  const TransactionTile(
      {super.key,
      required this.amount,
      required this.time,
      required this.txnid,
      required this.status,
      required this.method,
      required this.type});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          InkWell(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.type == "Deposit"
                          ? Icons.keyboard_double_arrow_right_rounded
                          : Icons.keyboard_double_arrow_left_rounded,
                      size: 32,
                      color: MyColor.green,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.type,
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(
                          widget.status,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('₹${widget.amount}',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(
                          DateFormat('MMM dd, yyyy  hh:mm a')
                              .format(DateTime.parse(widget.time)),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    widget.status == 'pending' ||
                            widget.status == 'under review'
                        ? Icon(
                            Icons.watch_later_rounded,
                            color: MyColor.white,
                            size: 30,
                          )
                        : widget.status == 'purchased' ||
                                widget.status == 'paid'
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: MyColor.green,
                                size: 30,
                              )
                            : Icon(
                                Icons.cancel_rounded,
                                color: MyColor.red,
                                size: 30,
                              ),
                    const SizedBox(width: 10),
                  ]),
            ),
          ),
          if (isOpen)
            Column(children: [
              Divider(
                color: Theme.of(context).backgroundColor,
                thickness: 2,
                height: 0,
              ),
              SizedBox(
                  height: 45,
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: widget.txnid));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              content: Text(
                                'Transaction ID copied successfully',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )));
                        },
                        child: const Text(
                          'Copy Transaction Id',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (widget.status != 'purchased')
                      Container(
                        width: 2,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor),
                      ),
                    if (widget.status != 'purchased')
                      Expanded(
                          child: InkWell(
                              onTap: () async {
                                await transactionReport(
                                    status: widget.status, id: widget.txnid);
                              },
                              child: const Text(
                                'Contact Us',
                                textAlign: TextAlign.center,
                              )))
                  ]))
            ])
        ]));
  }
}
