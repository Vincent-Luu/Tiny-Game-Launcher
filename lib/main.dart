import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'MainPage/cards.dart';

// 动态颜色默认颜色
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _seletedIndex = 0;
  final List<Widget> _pages = [MainPage(), SizedBox()];

  void _onItemTapped(int index) {
    //切换页面赋值函数
    setState(() {
      _seletedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _seletedIndex,
        onDestinationSelected: _onItemTapped,

        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.amp_stories),
            label: 'Mihoyo\'s Game',
          ),

          NavigationDestination(
            icon: Icon(Icons.add_ic_call_outlined),
            label: '还不知道做什么',
          ),
        ],
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.auto_awesome_rounded),
            Text(' 游戏启动器', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: _pages[_seletedIndex],
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          EachCard(
            '原神',
            '开放世界冒险，探索七国，集结角色，对抗强敌，解开提瓦特大陆之谜。',
            'assets/images/YuanshenIcon.jpg',
            'com.miHoYo.Yuanshen',
            'com.miHoYo.GenshinImpact',
            true,
            'https://ys.mihoyo.com/cloud',
          ),
          EachCard(
            '崩坏：星穹铁道',
            '米哈游科幻冒险RPG，穿梭银河列车，邂逅星神与命途，开启星际奇幻之旅！',
            'assets/images/BengtieIcon.jpg',
            'com.miHoYo.hkrpg',
            'com.HoYoverse.hkrpgoversea',
            true,
            'https://sr.mihoyo.com/cloud',
          ),
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
    );
  }
}
