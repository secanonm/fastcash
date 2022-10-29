import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_requests/http_requests.dart';
import 'package:lottie/lottie.dart';

import '../../components/color.dart';
import '../../components/dialogBox.dart';
import '../../components/route.dart';
import '../../data/info.dart';
import '../../utils/google_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  userState() async {
    await getUserLocalData();
    if (userId != null && userMail != null && userKey != null) {
      if (auth.currentUser != null) {
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
            userController.updateData(dataJson['wallet_balance']);
            userController.updateProduct(dataJson['product_list']);

            MyRoute.offAllNamed('/dashboardMain');
          } else {
            MyDialogBox(
                title: 'Oh no!',
                asset: 'assets/animations/payment/error.json',
                subtitle: 'Something went wrong. Please try again later.',
                type: MyDialogBoxType.alert,
                context: context);
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
      } else {
        MyRoute.offAllNamed('/welcome');
      }
    } else {
      MyRoute.offAllNamed('/welcome');
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: MyColor.pBackground));
    Future.delayed(Duration.zero, () async {
      await userState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          const Spacer(flex: 3),
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/icons/logo/icon.png', height: 70)),
          const SizedBox(height: 30),
          Text("FastCash",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 28)),
          const Spacer(),
          Lottie.asset('assets/animations/splash/splash_loading.json',
              height: 50),
          const Spacer(),
          Text("Simple ∙ Fast ∙ Reliable",
              style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 10),
          Text("Made By Secanonm",
              style: Theme.of(context).textTheme.headlineSmall),
          // const Spacer(),
        ]),
      ),
    );
  }
}
