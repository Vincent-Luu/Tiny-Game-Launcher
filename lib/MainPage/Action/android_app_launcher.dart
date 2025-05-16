import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class AndroidAppLauncher {
  static Future<void> launchByPackageName(String packageName) async {
    final trimmedPackageName = packageName.trim();
    if (Platform.isAndroid) {
      try {
        await LaunchApp.openApp(
          androidPackageName: trimmedPackageName,
          openStore: true,
        );
      } catch (e) {
        throw '无法使用启动应用或打开商店 ($trimmedPackageName): ${e.toString()}';
      }
    } else {
      throw '对不起,应用调用目前仅支持Android平台';
    }
  }

  static Future<void> launchByUrl(String url) async {
    try {
      final Uri openUrl = Uri.parse(url);
      await launchUrl(openUrl);
    } catch (e) {
      throw '无法打开链接: $url,$e';
    }
  }
}
