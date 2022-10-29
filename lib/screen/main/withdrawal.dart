import 'dart:developer';

import 'package:cashfree/components/appBar.dart';
import 'package:cashfree/components/dialogBox.dart';
import 'package:cashfree/components/inputField.dart';
import 'package:flutter/material.dart';
import 'package:http_requests/http_requests.dart';

import '../../data/info.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final formkey = GlobalKey<FormState>();
  var amountController = TextEditingController();
  var nameController = TextEditingController();
  var upiController = TextEditingController();

  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(appTitle: 'Withdraw Money'),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(children: [
              const SizedBox(height: 20),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).primaryColorDark, width: 3)),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'NOTICE',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "• The withdrawal request may take 7 to 15 working days to process.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              MyInputField(
                  textController: amountController,
                  label: 'Amount',
                  hintText: 'Please enter amount',
                  errorText: 'Please enter amount (i.e. 100)'),
              MyInputField(
                  textController: nameController,
                  label: 'Name',
                  hintText: 'Please your name',
                  errorText: 'Please enter name link with upi'),
              MyInputField(
                  textController: upiController,
                  label: 'UPI Address',
                  hintText: 'Please your upi address',
                  errorText: 'Please enter upi address (i.e. secanonm@paytm)'),
              isClick
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(strokeWidth: 3),
                    )
                  : Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                setState(() {
                                  isClick = true;
                                });
                                bool valid = formkey.currentState!.validate();
                                if (valid) {
                                  String amount = amountController.text;
                                  String name = nameController.text;
                                  String upi = upiController.text;

                                  if (amount.isNotEmpty &&
                                      name.isNotEmpty &&
                                      upi.isNotEmpty) {
                                    var data = {
                                      'user_id': userId,
                                      'user_mail': userMail,
                                      'user_key': userKey,
                                      'amount': amount,
                                      'name': name,
                                      'upi': upi,
                                    };
                                    Response res = await HttpRequests.post(
                                        'https://www.secanonm.in/fastcash/api/withdrawal/',
                                        data: data);
                                    Map dataJson = res.json;
                                    log(dataJson.toString());
                                    if (dataJson['status'] == 'successful') {
                                      userController.updateData((double.parse(
                                                  userController
                                                      .walletBalance.value) -
                                              double.parse(amount))
                                          .toString());

                                      amountController.text = '';
                                      nameController.text = '';
                                      upiController.text = '';

                                      MyDialogBox(
                                          title: 'Request Successful',
                                          subtitle:
                                              "You withdrawal request has been successfully sent. You'll soon receive your payout within 7 to 15 working days. Please wait patiently and leave the rest everything on us.",
                                          asset:
                                              'assets/animations/payment/successful.json',
                                          type: MyDialogBoxType.success,
                                          context: context);
                                    } else {
                                      if (dataJson['message'] ==
                                          'insufficient balance') {
                                        MyDialogBox(
                                            title: 'insufficient balance',
                                            subtitle:
                                                "Oops! You withdrawal request couldn't be processed as you currently don't have the sufficient balance to process this request. Please add some google play balance in the app to continue.",
                                            asset:
                                                'assets/animations/payment/insufficient.json',
                                            type: MyDialogBoxType.alert,
                                            context: context);
                                      } else {
                                        MyDialogBox(
                                            title: 'Oh no!',
                                            subtitle:
                                                'Something went wrong. Please try again later.',
                                            asset:
                                                'assets/animations/payment/something_wrong.json',
                                            type: MyDialogBoxType.alert,
                                            context: context);
                                      }
                                    }
                                  }
                                }

                                setState(() {
                                  isClick = false;
                                });
                              },
                              child: const Text('REQUEST')),
                        ))
                      ],
                    )
            ]),
          ),
        )));
  }
}
