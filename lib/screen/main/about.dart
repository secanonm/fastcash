import 'package:flutter/material.dart';

import '../../components/accordion.dart';
import '../../components/appBar.dart';
import '../../components/bottomNavBar.dart';
import '../../components/color.dart';
import '../../components/urlLauncher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(index: 2),
      appBar: MyAppBar(
        appTitle: 'ABOUT ',
        isBack: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              MyAccordion(
                  isOpen: true,
                  heading: 'About FastCash',
                  subtitle:
                      '''FastCash is an app that lets you to redeem google play balance, coupons, or the unused discount offers, and allows you to exchange them for real cash that you can withdraw directly to your bank account via any UPI/VBA. 

You just need to make a purchase in the app from the available coupons by selecting the amount & thereafter you can easily request to withdraw that money by providing your UPI address. 

We will pay 60% of the total amount of you redeem or convert in our app within 7 to 15 working days (if the amount is big then it may take maximum upto 45 days).'''),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  launchURL('https://twitter.com/secanonm');
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: lighten(
                                Theme.of(context).primaryColorDark, .2)),
                        boxShadow: [
                          BoxShadow(
                              color: darken(
                                  Theme.of(context).primaryColorDark, .5),
                              blurRadius: 10,
                              spreadRadius: -4)
                        ],
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: Text('Follow Us On Twitter',
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.secanonm.in/privacy-policy/');
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: lighten(
                                Theme.of(context).primaryColorDark, .2)),
                        boxShadow: [
                          BoxShadow(
                              color: darken(
                                  Theme.of(context).primaryColorDark, .5),
                              blurRadius: 10,
                              spreadRadius: -4)
                        ],
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: Text('Privacy Policy',
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.secanonm.in/terms-and-conditions/');
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: lighten(
                                Theme.of(context).primaryColorDark, .2)),
                        boxShadow: [
                          BoxShadow(
                              color: darken(
                                  Theme.of(context).primaryColorDark, .5),
                              blurRadius: 10,
                              spreadRadius: -4)
                        ],
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: Text('Terms & Conditions',
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.secanonm.in/');
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: lighten(
                                Theme.of(context).primaryColorDark, .2)),
                        boxShadow: [
                          BoxShadow(
                              color: darken(
                                  Theme.of(context).primaryColorDark, .5),
                              blurRadius: 10,
                              spreadRadius: -4)
                        ],
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: Text('More About Us',
                        style: Theme.of(context).textTheme.titleMedium)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
