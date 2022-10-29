// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import 'color.dart';
import 'route.dart';

class MyDialogBox {
  final BuildContext context;
  String asset;
  String route;
  String title;
  String subtitle;
  String plan;
  final String type;
  bool isBig = false;
  MyDialogBox({
    this.title = '',
    this.route = '',
    this.subtitle = '',
    this.asset = 'assets/animations/welcome/table-meeting.json',
    this.plan = '',
    required this.type,
    required this.context,
  }) {
    Widget rowButton = Row(
      children: [
        _MyButton(
          title: 'OK',
          context: context,
        ),
      ],
    );

    switch (type) {
      case 'success':
        break;

      case 'alert':
        rowButton = Row(
          children: [
            _MyButton(
              color: MyColor.redDark,
              context: context,
            )
          ],
        );
        break;

      case 'warning':
        rowButton = Row(children: [
          _MyButton(
            color: MyColor.orange,
            context: context,
          )
        ]);
        break;

      case 'subscriptionExpired':
        title = 'Subscription Expired!';
        subtitle =
            "Sorry, you currently can't subscribe to subscriptions as there is already an active subscription in your account and it's not expired yet. If you want to increase the usage limits, please continue with the Add-on which matches your needs.";
        asset = 'assets/animations/old/smartphone.json';
        isBig = true;
        rowButton = Row(
          children: [
            _MyButton(
              title: 'OK',
              color: MyColor.redDark,
              context: context,
            ),
          ],
        );
        break;

      case 'subscriptionPurchased':
        title = 'Subscription Purchased!';
        subtitle =
            'Congrats! Your payment was made and you have now successfully subscribed to Scupper\'s $plan Plan. You can find more details about your subscription and detailed stats at your scupper account dashboard.';
        asset = 'assets/animations/old/computer.json';
        break;

      case 'addonsPurchased':
        title = 'Addons Purchased!';
        subtitle =
            "Congrats! Your payment was made and you have now successfully increased your scupper tools' usage limits as per the add-on. You can find more details about it at your scupper account dashboard.";
        asset = 'assets/animations/old/cong.json';
        break;

      case 'insufficientBalance':
        title = 'Insufficient Balance!';
        subtitle =
            'Oops! Your scupper wallet balance is insufficient for payment of the subscription. Please add sufficient funds in your scupper wall to continue. Alternatively, choose different subscription plan from within the balance of your scupper wallet.';
        asset = 'assets/animations/old/insufficient.json';
        rowButton = Row(
          children: [
            _MyButton(
              color: MyColor.redDark,
              context: context,
            ),
          ],
        );
        break;

      case 'advanceMail':
        title = 'Advance Feature!';
        subtitle =
            "Oops! This feature is a part of advance mail spoofing. Therefore, to use this feature with many more others as well, please use 'Advance Mail Spoofing' of Scupper.";
        rowButton = Row(
          children: [
            _MyButton(
              title: 'Cancel',
              color: Theme.of(context).disabledColor,
              context: context,
            ),
            const SizedBox(width: 10),
            _MyButton(
              title: 'Use',
              color: Theme.of(context).primaryColor,
              nextScreen: '/advMailSpoofing',
              context: context,
            ),
          ],
        );
        break;

      default:
        rowButton = Row(
          children: [
            _MyButton(
              context: context,
            )
          ],
        );
        break;
    }

    Get.dialog(
        AlertDialog(
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isBig) const SizedBox(height: 20),
              LottieBuilder.asset(
                asset,
                height: isBig ? 200 : 250,
              ),
              if (isBig) const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      // fontSize: 13,
                      ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(height: 35, child: rowButton),
              // const SizedBox(height: 3),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        routeSettings:
            RouteSettings(name: "/dailogBox-${title.split(' ').join()}"));
  }
}

// ignore: must_be_immutable
class _MyButton extends StatelessWidget {
  final String title;
  Color? color;
  BuildContext context;
  String nextScreen;
  _MyButton(
      {Key? key,
      this.title = 'OK',
      this.color,
      this.nextScreen = 'back',
      required this.context})
      : super(key: key) {
    color ??= Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              if (nextScreen == 'back') {
                MyRoute.back();
              } else {
                MyRoute.back();
                MyRoute.toNamed(nextScreen);
              }
            },
            child: Text(title)));
  }
}

class MyDialogBoxType {
  static get success {
    return 'success';
  }

  static get alert {
    return 'alert';
  }

  static get warning {
    return 'warning';
  }

  static get subscriptionExpired {
    return 'subscriptionExpired';
  }

  static get subscriptionPurchased {
    return 'subscriptionPurchased';
  }

  static get addonsPurchased {
    return 'addonsPurchased';
  }

  static get insufficientBalance {
    return 'insufficientBalance';
  }

  static get advanceMail {
    return 'advanceMail';
  }
}
