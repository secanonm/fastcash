import 'package:url_launcher/url_launcher.dart';

void launchURL(url, {LaunchMode mode = LaunchMode.externalApplication}) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: mode,
  )) throw 'Could not launch $url';
}
