import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';

import '../../components/color.dart';
import '../../components/urlLauncher.dart';
import '../../utils/google_in.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  final GoogleSingInController _controller = Get.put(GoogleSingInController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: height > 540
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: height > 540 ? height : 540,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                LottieBuilder.asset(
                  'assets/animations/welcome/table-meeting.json',
                  height: 280,
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Validator is designed to verify UPI IDs and Bank account in real time.',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        wordSpacing: 2.0,
                        fontFamily: 'AndadaPro',
                        letterSpacing: 1.0,
                        height: 1.5,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => _controller.isClick.value
                      ? const SizedBox(
                          height: 45,
                          width: 45,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                          ))
                      : OutlinedButton(
                          onPressed: () {
                            _controller.updateData(true);
                            signInWithGoogle(context: context);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              side: BorderSide(
                                  color: lighten(
                                      Theme.of(context).primaryColor, .35),
                                  width: 2),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width / 1.2, 50)),
                          child: Center(
                              child: Text(
                            "Continue With Google",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    wordSpacing: 2.0,
                                    letterSpacing: 1.0,
                                    color: lighten(
                                        Theme.of(context).primaryColorLight,
                                        .08)),
                          ))),
                ),

                const SizedBox(height: 40),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'By creating or using a Validator account,\n you agree that you read and accept our ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          height: 1.2,
                          color: Theme.of(context).primaryColor),
                      children: [
                        TextSpan(
                            text: '\nT&C',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchURL(
                                    'https://www.secanonm.in/terms-and-conditions/');
                              },
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500)),
                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                            text: 'Privacy Policy',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchURL(
                                    'https://www.secanonm.in/privacy-policy/');
                              },
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500)),
                        const TextSpan(
                          text: '. ',
                        ),
                      ],
                    )),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
