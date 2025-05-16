import 'package:flutter/material.dart';
import 'Action/android_app_launcher.dart';

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
    return Column(
      children: [
        Card(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
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
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: TextButton(
                              onPressed: () => _launchGame(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('国  服 '),
                                  Icon(Icons.play_arrow_rounded),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: TextButton(
                              onPressed: () => _launchGame2(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('国际服 '),
                                  Icon(Icons.play_arrow_rounded),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 5,
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
                            Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 7),
      ],
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
