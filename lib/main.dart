import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'android_app_launcher.dart';

// 默认颜色（如果设备不支持动态颜色）
final _defaultLightScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 255, 255),
  brightness: Brightness.light,
);

final _defaultDarkScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 0, 0),
  brightness: Brightness.dark,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightDynamic ?? _defaultLightScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ?? _defaultDarkScheme,
            useMaterial3: true,
          ),
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.auto_awesome_rounded),
            Text(' 游戏启动器', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 13, right: 13),
        child: ListView(
          children: [
            EachCard(
              '崩坏3',
              '3D动作手游，女武神集结，燃爆战斗，对抗崩坏，守护世界最后的希望。',
              'assets/images/Honkai3Icon.jpg',
              'com.miHoYo.enterprise.NGHSoD',
              'com.miHoYo.bh3global',
              false,
              'null',
            ),
            SizedBox(height: 7),
            EachCard(
              '原神',
              '开放世界冒险，探索七国，集结角色，对抗强敌，解开提瓦特大陆之谜。',
              'assets/images/YuanshenIcon.jpg',
              'com.miHoYo.Yuanshen',
              'com.miHoYo.GenshinImpact',
              true,
              'https://ys.mihoyo.com/cloud/',
            ),
            SizedBox(height: 7),
            EachCard(
              '崩坏：星穹铁道',
              '米哈游科幻冒险RPG，穿梭银河列车，邂逅星神与命途，开启星际奇幻之旅！',
              'assets/images/BengtieIcon.jpg',
              'com.miHoYo.hkrpg',
              'com.HoYoverse.hkrpgoversea',
              true,
              'https://sr.mihoyo.com/cloud',
            ),
            SizedBox(height: 7),
            EachCard(
              '绝区零',
              '米哈游全新都市奇幻ARPG，潮酷战斗与赛博朋克风交织，探索未知「空洞」危机！',
              'assets/images/ZZZIcon.jpg',
              'com.miHoYo.Nap',
              'com.HoYoverse.Nap',
              true,
              'https://zzz.mihoyo.com/cloud-feat/',
            ),
          ],
        ),
      ),
    );
  }
}

class EachCard extends StatelessWidget {
  const EachCard(
    this.gameName,
    this.gameDescribe,
    this.imageUrl,
    this.packageName,
    this.packageName2,
    this.isVisible,
    this.gameUrl, {
    super.key,
  });

  final String gameName;
  final String imageUrl;
  final String gameDescribe;
  final String packageName;
  final String packageName2;
  final bool isVisible;
  final String gameUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(13),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          gameDescribe,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => _launchGame(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('国  服 '), Icon(Icons.play_arrow_rounded)],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => _launchGame2(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('国际服 '), Icon(Icons.play_arrow_rounded)],
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () => _launchGameByUrl(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('云游戏 '),
                          Icon(Icons.play_arrow_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchGame(BuildContext context) async {
    try {
      await AndroidAppLauncher.launchByPackageName(packageName);
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('启动失败: $e')));
    }
  }

  Future<void> _launchGame2(BuildContext context) async {
    try {
      await AndroidAppLauncher.launchByPackageName(packageName2);
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('启动失败: $e')));
    }
  }

  Future<void> _launchGameByUrl(BuildContext context) async {
    try {
      await AndroidAppLauncher.launchByUrl(gameUrl);
    } catch (e) {
      {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('启动失败: $e')));
      }
    }
  }
}
