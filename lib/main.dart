import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'components/color.dart';
import 'components/route.dart';
import 'data/info.dart';
import 'screen/splashScreen/splashScreen.dart';

final UserDataController userController = Get.put(UserDataController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final bool available = await InAppPurchase.instance.isAvailable();
  if (available) {
    log('true', name: 'available');
  } else {
    log('false', name: 'available');
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FastCash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: MyColor.primary,
          cardColor: MyColor.green,
          cardTheme: CardTheme(color: MyColor.container),
          primaryColorDark: MyColor.container,
          primaryColorLight: MyColor.white,
          dividerColor: MyColor.grey,
          disabledColor: MyColor.disabled,
          canvasColor: MyColor.disabled,
          scaffoldBackgroundColor: MyColor.pBackground,
          backgroundColor: MyColor.pBackground,
          splashColor: MyColor.transparent,
          highlightColor: MyColor.transparent,
          hintColor: MyColor.white,
          focusColor: MyColor.primary,
          tabBarTheme: TabBarTheme(
              overlayColor:
                  MaterialStateProperty.all(MyColor.grey.withOpacity(0.15)),
              indicator: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: MyColor.primary, width: 2))),
              labelColor: lighten(MyColor.grey, .08),
              unselectedLabelColor: MyColor.disabled,
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'AndadaPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.0),
              labelStyle: const TextStyle(
                  fontFamily: 'AndadaPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.0)),
          tooltipTheme: TooltipThemeData(
            // triggerMode: TooltipTriggerMode.tap,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            showDuration: const Duration(seconds: 5),
            decoration: BoxDecoration(
                color: MyColor.primary,
                boxShadow: [
                  BoxShadow(
                      color: darken(Theme.of(context).primaryColor, .4),
                      blurRadius: 20,
                      spreadRadius: 0.5),
                ],
                borderRadius: BorderRadius.circular(5)),
            textStyle: TextStyle(
                fontFamily: 'AndadaPro',
                fontWeight: FontWeight.bold,
                color: MyColor.white,
                fontSize: 12,
                wordSpacing: 1.5,
                letterSpacing: 1.0),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: MyColor.container,
            titleTextStyle: TextStyle(
                fontFamily: 'AndadaPro',
                fontWeight: FontWeight.bold,
                color: MyColor.white,
                fontSize: 22,
                letterSpacing: 1.0),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
            primaryColorDark: MyColor.container,
            accentColor: MyColor.white,
            cardColor: MyColor.green,
            backgroundColor: MyColor.pBackground,
            errorColor: MyColor.red,
            brightness: Brightness.dark,
          ),
          primarySwatch: Colors.green,
          iconTheme: IconThemeData(color: MyColor.white),
          expansionTileTheme: ExpansionTileThemeData(iconColor: MyColor.white),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  // onSurface: MyColor.pBackground.withOpacity(0.3),
                  backgroundColor: MyColor.primary,
                  side: BorderSide(color: MyColor.primary, width: 2),
                  fixedSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(MyColor.white),
                  overlayColor: MaterialStateProperty.all<Color>(
                      MyColor.pBackground.withOpacity(0.3)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      MyColor.primary.withGreen(190)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(45)))),
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 34,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 28,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 24,
            ),
            titleLarge: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 22,
            ),
            titleMedium: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 18,
            ),
            titleSmall: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 14,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'AndadaPro',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'AndadaPro',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 14,
            ),
            bodySmall: TextStyle(
              fontFamily: 'AndadaPro',
              fontWeight: FontWeight.bold,
              color: MyColor.white,
              fontSize: 12,
            ),
            labelLarge: TextStyle(
              fontFamily: 'AndadaPro',
              fontWeight: FontWeight.bold,
              color: MyColor.grey,
              fontSize: 16,
            ),
            labelMedium: TextStyle(
              fontFamily: 'AndadaPro',
              color: MyColor.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            labelSmall: TextStyle(
              fontFamily: 'AndadaPro',
              color: MyColor.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all(MyColor.primary)),
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(MyColor.primary)),
          dialogBackgroundColor: MyColor.pBackground,
          dialogTheme: DialogTheme(
            backgroundColor: MyColor.pBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          brightness: Brightness.dark),
      home: const SplashScreen(),
      getPages: pages,
      defaultTransition: Transition.rightToLeft,
      unknownRoute: pages[0],
    );
  }
}
