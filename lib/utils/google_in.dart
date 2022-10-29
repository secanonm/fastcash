import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_requests/http_requests.dart';

import '../components/dialogBox.dart';
import '../components/route.dart';
import '../data/info.dart';

class GoogleSingInController extends GetxController {
  var isClick = false.obs;
  updateData(value) => isClick.value = value;
}

FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile'
  ],
);

Future<User?> signInWithGoogle({required BuildContext context}) async {
  GoogleSingInController controller = Get.put(GoogleSingInController());

  User? user;

  GoogleSignInAccount? googleUser;

  try {
    googleUser = await googleSignIn.signIn();
  } on PlatformException catch (e) {
    if (e.code == 'network_error') {
      MyDialogBox(
          title: 'No Connection!',
          subtitle: 'Please check your internet connection and try again.',
          asset: 'assets/animations/payment/no-connection.json',
          type: MyDialogBoxType.alert,
          context: context);
    } else {
      log(e.toString(), name: 'GoogleSignIn');
    }

    googleUser = null;
  } catch (e) {
    log(e.toString(), name: 'GoogleSignIn');
    googleUser = null;
  }

  if (googleUser != null) {
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      if (user != null) {
        var data = {
          'uid': user.uid,
          'name': user.displayName,
          'mail': user.email,
          'profile': user.photoURL,
        };
        try {
          Response response = await HttpRequests.post(
              'https://www.secanonm.in/fastcash/api/account/',
              data: data);

          var dataJson = response.json;

          log(dataJson.toString());
          if (dataJson['status'] == 'success') {
            userController.updateData(dataJson['wallet_balance']);
            userLocalData.write('userId', dataJson['user_id']);
            userLocalData.write('userMail', dataJson['user_mail']);
            userLocalData.write('userKey', dataJson['user_key']);
            await getUserLocalData();
            var data = {
              'user_id': userId,
              'user_mail': userMail,
              'user_key': userKey,
            };
            Response response = await HttpRequests.post(
                'https://www.secanonm.in/fastcash/api/account/data.php',
                data: data);
            var fetchData = response.json;
            if (fetchData['status'] == 'success') {
              userController.updateData(fetchData['wallet_balance']);
              userController.updateProduct(fetchData['product_list']);
              MyRoute.offAllNamed('/dashboardMain');
            }

            controller.updateData(false);
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
                title: 'No Connection Exception !',
                subtitle:
                    'Please check your internet connection and try again.',
                asset: 'assets/animations/payment/no-connection.json',
                type: MyDialogBoxType.alert,
                context: context);
          }
        }
      } else {
        log('Login Failed (No data found )', name: 'FirebaseAuth');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        MyDialogBox(
            title: 'No Connection!',
            subtitle: 'Please check your internet connection and try again.',
            asset: 'assets/animations/payment/no-connection.json',
            type: MyDialogBoxType.alert,
            context: context);
      } else {
        log('Login Failed ${e.toString()}', name: 'FirebaseAuth');
      }
    } catch (e) {
      log('Login Failed ${e.toString()}', name: 'FirebaseAuth');
    }
  } else {
    log('User Not Select Google Account', name: 'Google');
  }
  return user;
}

logout() async {
  try {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    // ignore: empty_catches
  } catch (e) {}

  log('Logout Successfully', name: 'Google');
}
