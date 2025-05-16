import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class AndroidAppLauncher {
  static Future<void> launchByPackageName(String packageName) async {
    final trimmedPackageName = packageName.trim();
    try {
      await LaunchApp.openApp(
        androidPackageName: trimmedPackageName,
        openStore: true,
      );
    } catch (e) {
      throw '无法使用 launch_app 启动应用或打开商店 ($trimmedPackageName): ${e.toString()}';
    }
  }

  static Future<void> launchByUrl(String url) async {
    try {
      final intent = AndroidIntent(
        action: 'action_view',
        data: url,
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    } catch (e) {
      throw '无法打开链接: $url';
    }
  }
}
