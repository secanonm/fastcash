import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:http_requests/http_requests.dart';

import '../../components/color.dart';
import '../../components/bottomNavBar.dart';
import '../../components/dialogBox.dart';
import '../../components/route.dart';
import '../../data/info.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: MyColor.container,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MyBottomNavBar(index: 1),
        body: SafeArea(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            backgroundColor: Theme.of(context).primaryColorLight,
            onRefresh: () async {
              var data = {
                'user_id': userId,
                'user_mail': userMail,
                'user_key': userKey,
              };
              try {
                Response response = await HttpRequests.post(
                    'https://www.secanonm.in/fastcash/api/account/data.php',
                    data: data);
                var dataJson = response.json;
                if (dataJson['status'] == 'success') {
                  UserDataController userController =
                      Get.put(UserDataController());
                  userController.updateData(dataJson['wallet_balance']);
                  userController.updateProduct(dataJson['product_list']);
                }
              } on HttpRequestException catch (e) {
                if (e.code == 'unreachable') {
                  MyDialogBox(
                      title: 'No Connection!',
                      subtitle:
                          'Please check your internet connection and try again.',
                      asset: 'assets/animations/payment/no-connection.json',
                      type: MyDialogBoxType.alert,
                      context: context);
                }
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const _DashboardHeader(),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: lighten(Theme.of(context).cardColor, .2)),
                        boxShadow: [
                          BoxShadow(
                              color: darken(Theme.of(context).cardColor, .6),
                              blurRadius: 20,
                              spreadRadius: 1),
                          BoxShadow(
                              color: darken(Theme.of(context).cardColor, .5),
                              blurRadius: 10,
                              spreadRadius: -4)
                        ],
                        gradient: LinearGradient(
                            begin: const Alignment(-1, -3),
                            colors: [
                              darken(Theme.of(context).cardColor, .2),
                              Theme.of(context).cardColor,
                              lighten(Theme.of(context).cardColor, 0.2),
                            ],
                            stops: const [
                              .23,
                              .6,
                              1
                            ]),
                        borderRadius: BorderRadius.circular(10)),
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(flex: 2),
                              Text('Your Balance ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(shadows: [
                                    Shadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 20,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    Shadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 10,
                                        color:
                                            Theme.of(context).primaryColorDark)
                                  ])),
                              const Spacer(),
                              Obx(
                                () => Text(
                                    '₹ ${userController.walletBalance.value}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 28,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            shadows: [
                                          Shadow(
                                              offset: const Offset(2, 2),
                                              blurRadius: 20,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                          Shadow(
                                              offset: const Offset(2, 2),
                                              blurRadius: 10,
                                              color: Theme.of(context)
                                                  .primaryColorDark)
                                        ])),
                              ),
                              const Spacer(),
                            ]),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      darken(Theme.of(context).cardColor, .6),
                                  blurRadius: 20,
                                  spreadRadius: 0),
                            ],
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).cardColor,
                                  fixedSize: const Size(60, 60),
                                  shape: const CircleBorder()),
                              onPressed: () {
                                MyRoute.toNamed('/inAppPurchase');
                              },
                              child: const Icon(
                                Icons.add_rounded,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromHeight(55),
                                backgroundColor: Theme.of(context).cardColor,
                              ),
                              onPressed: () {
                                MyRoute.toNamed('/withdrawalPage');
                              },
                              child: const Text('Withdraw Money')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromHeight(55),
                                backgroundColor: Theme.of(context).cardColor,
                              ),
                              onPressed: () {
                                MyRoute.toNamed('/transactionHistory');
                              },
                              child: const Text('Transaction History')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "• If you request for refund on play store, you will get no withdrawal at all.\n\n• After the deduction of platform charges and other taxes, you'll receive the 60% of the payment amount.\n\n• The withdrawal request may take 7 to 15 working days to process.\n\n• If the payment status is pending, it too may take upto 7 working days to process.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        'Made By Secanonm',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 5),
                      Tooltip(
                        message:
                            '80% of amount : ${(int.parse(userController.walletBalance.value) * 1.34).round()}',
                        triggerMode: TooltipTriggerMode.longPress,
                        child: Text(
                          '( Safe & Secure )',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class WrapDashboard extends StatelessWidget {
  const WrapDashboard(
      {Key? key,
      required this.title,
      required this.image,
      this.imageSize = 20.0,
      required this.desc,
      required this.nextScreen})
      : super(key: key);
  final String title;
  final String desc;
  final String image;
  final String nextScreen;
  final double imageSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (nextScreen == '/bank') {
          MyDialogBox(
              title: 'Feature Coming Soon!',
              subtitle:
                  'This feature is currently in development and will be available soon.',
              type: 'success',
              context: context);
        } else {
          MyRoute.toNamed(nextScreen);
        }
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: lighten(Theme.of(context).primaryColorDark, .2)),
            boxShadow: [
              BoxShadow(
                  color: darken(Theme.of(context).primaryColorDark, .6),
                  blurRadius: 20,
                  spreadRadius: 1),
              BoxShadow(
                  color: darken(Theme.of(context).primaryColorDark, .5),
                  blurRadius: 10,
                  spreadRadius: -4)
            ],
            gradient: LinearGradient(begin: const Alignment(-1, -3), colors: [
              darken(Theme.of(context).primaryColorDark, .1),
              Theme.of(context).primaryColorDark,
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Image.asset(
              image,
              height: imageSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(letterSpacing: 1.5)),
          // const ProfilePicture(
          //   size: 50,
          //   blurRadius: 0,
          //   iconSize: 12,
          //   offset: Offset(2.8, 2.5),
          //   padding: 6,
          // )
        ],
      ),
    );
  }
}
