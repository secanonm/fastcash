import 'package:cashfree/screen/main/withdrawal.dart';
import 'package:cashfree/screen/payment/in_app_purchase.dart';
import 'package:get/route_manager.dart';

import '../screen/main/transactionHistory.dart';
import '../screen/main/about.dart';
import '../screen/main/dashboard.dart';
import '../screen/splashScreen/splashScreen.dart';
import '../screen/welcome/welcome.dart';

var pages = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/welcome',
    page: () => const WelcomePage(),
    transition: Transition.circularReveal,
  ),
  GetPage(
    name: '/dashboardMain',
    page: () => const Dashboard(),
    transition: Transition.upToDown,
  ),
  GetPage(
    name: '/about',
    page: () => const AboutPage(),
    transition: Transition.size,
  ),
  GetPage(
    name: '/dashboard',
    page: () => const Dashboard(),
    transition: Transition.size,
  ),
  GetPage(
    name: '/inAppPurchase',
    page: () => const InAppPurchasePage(),
  ),
  GetPage(
    name: '/transactionHistory',
    page: () => const TransactionPage(),
  ),
  GetPage(
    name: '/withdrawalPage',
    page: () => const WithdrawalPage(),
  ),
];

class MyRoute {
  static toNamed(String page,
      {dynamic arguments, Map<String, String>? parameters}) {
    Get.toNamed(page, arguments: arguments, parameters: parameters);
  }

  static offNamed(page, {dynamic arguments, Map<String, String>? parameters}) {
    Get.offNamed(page, arguments: arguments, parameters: parameters);
  }

  static offAllNamed(page,
      {dynamic arguments, Map<String, String>? parameters}) {
    Get.offAllNamed(page, arguments: arguments, parameters: parameters);
  }

  static back() {
    Get.back();
  }
}
