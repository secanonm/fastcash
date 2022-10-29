import 'package:flutter_email_sender/flutter_email_sender.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../data/info.dart';

transactionReport({required status, required id}) async {
  String date =
      DateFormat('E MMM dd hh:mm:ss a  yyyy').format(DateTime.now()).toString();

  final Email email = Email(
    subject: 'FastCash Transaction Report',
    recipients: ['support@secanonm.in'],
    body: """

---TRANSACTION---

Transaction ID: $id
Transaction Time: $date
Transaction Status: $status

---USER DATA---

User ID: $userId
Registered Email: $userMail

Write your feedback here....
(if any...)""",
  );

  await FlutterEmailSender.send(email);
}
