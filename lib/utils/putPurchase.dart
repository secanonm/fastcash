import 'package:http_requests/http_requests.dart';

import '../data/info.dart';

putRequest(
    {required status,
    required productId,
    required purchaseId,
    required time,
    required quantity}) async {
  var data = {
    'user_id': userId,
    'user_mail': userMail,
    'user_key': userKey,
    'status': status,
    'productId': productId,
    'purchaseId': purchaseId,
    'transactionTime': time,
    'quantity': quantity,
  };
  await HttpRequests.post('https://www.secanonm.in/fastcash/api/payment/',
      data: data);
}
