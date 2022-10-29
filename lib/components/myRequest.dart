// import 'dart:convert';

// import 'package:http_requests/http_requests.dart';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;

// import '../data/info.dart';
// import 'dialogBox.dart';

// Future<Map<String, dynamic>> myRequest(
//     {required context,
//     required url,
//     Map<String, String>? data,
//     headers,
//     timeout}) async {
//   Map<String, dynamic> dataJson = {'status': 'failed'};

//   Map<String, String> userData = {
//     'user_id': userId!,
//     'user_mail': userMail!,
//     'user_key': userKey!,
//   };

//   try {
//     data ??= {'': ''};
//     data.addAll(userData);

//     Response response = await HttpRequests.post(url,
//         data: data, headers: headers, timeout: timeout = 20);
//     dataJson = response.json;
//     if (dataJson['status'] == 'failed' && response.statusCode == 200) {
//       if (dataJson['message'] == 'expired') {
//         MyDialogBox(
//             type: MyDialogBoxType.subscriptionExpired, context: context);
//       } else if (dataJson['message'] == 'fully used') {
//         MyDialogBox(type: MyDialogBoxType.fullyUsed, context: context);
//       } else if (dataJson['message'] == 'subscription already exist') {
//         MyDialogBox(type: MyDialogBoxType.subscriptionExist, context: context);
//       } else if (dataJson['message'] == 'insufficient balance') {
//         MyDialogBox(
//             type: MyDialogBoxType.insufficientBalance, context: context);
//       } else if (dataJson['message'] == 'number required') {
//         MyDialogBox(type: MyDialogBoxType.numberRequired, context: context);
//       } else if (dataJson['message'] == 'user not found' ||
//           dataJson['message'] == 'device id not found' ||
//           dataJson['message'] == 'technical issue' ||
//           dataJson['message'] == 'invalid request' ||
//           dataJson['message'] == 'successful' ||
//           dataJson['message'] == 'pass necessary data') {
//         MyDialogBox(type: MyDialogBoxType.somethingWrong, context: context);
//       }
//     }
//   } on HttpRequestException catch (e) {
//     if (e.code == 'unreachable') {
//       MyDialogBox(type: MyDialogBoxType.internetConnection, context: context);
//     } else if (e.code == 'timeout') {
//       MyDialogBox(type: MyDialogBoxType.internetTimeout, context: context);
//     } else {
//       MyDialogBox(type: MyDialogBoxType.somethingWrong, context: context);
//     }
//   }
//   return dataJson;
// }
