import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:final_girl_tool/page/randomizer_page.dart';
import 'package:final_girl_tool/page/game_tracker.dart';
import 'package:final_girl_tool/page/record_game.dart';
import 'package:final_girl_tool/page/statistic_page.dart';
import 'package:final_girl_tool/page/collection_page.dart';
import 'package:final_girl_tool/constants/constants.dart';

void main() {
  runApp(const MyApp());
  Constants.instance.randomizedLocation;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNavBar(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const RandomizerP(),
        const TrackerP(),
        const RecorderP(),
        const StatsP(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.casino),
          title: ("Randomizer"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.edit_note),
          title: ("Tracker"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.radio_button_checked),
          title: ("Recorder"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.bar_chart),
          title: ("Stats"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      screens: buildScreens(),
      items: navBarsItems(),
      controller: controller,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style14,
    );
  }
}

class RandomizerP extends StatelessWidget {
  const RandomizerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _returnAppBar(context, "Randomizer"),
      body: const RandomizerPage(),
    );
  }
}

class TrackerP extends StatelessWidget {
  const TrackerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _returnAppBar(context, "Tracker"),
      body: const GameTrackerPage(),
    );
  }
}

class RecorderP extends StatelessWidget {
  const RecorderP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _returnAppBar(context, "Recorder"),
      body: const RecordGamePage(),
    );
  }
}

class StatsP extends StatefulWidget {
  const StatsP({Key? key}) : super(key: key);
  @override
  State<StatsP> createState() => __StatsPState();
}

class __StatsPState extends State<StatsP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _returnAppBar(context, "Statistics"),
      body: const StatisticPage(),
    );
  }
}

AppBar _returnAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: [
      PopupMenuButton(
          icon: const Icon(Icons.menu),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Collection"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("About"),
              ),
            ];
          },
          onSelected: (value) {
            if (value == 0) {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const CollectionSelectPage(),
                withNavBar: false,
              );
            } else if (value == 1) {
              showAboutDialog(
                context: context,
                applicationLegalese:
                    "Final Girl and the Final Girl logo are a trademark of Van Ryder Games and are used with permission.\n\nThis application is not affiliated with or endorsed by Van Ryder Games in any way. ",
                applicationName: "Final Girl Tool",
                applicationVersion: "1.0",
              );
            }
          })
    ],
  );
}
