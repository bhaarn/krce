import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:url_launcher/url_launcher.dart';

launchCaller(String tel) async {
  if (await canLaunch(tel)) {
    await launch(tel);
  } else {
    throw Strings.DET_VIEW_MMM_PRF_COULD_NOT_LAUNCH +  tel;
  }
}

launchWhatsApp(String wa) async {
  if (await canLaunch(wa)) {
    await launch(wa);
  } else {
    throw Strings.DET_VIEW_MMM_PRF_COULD_NOT_LAUNCH + wa;
  }
}