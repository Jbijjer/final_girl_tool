import 'package:final_girl_tool/page/collection_page.dart';
import 'package:flutter/material.dart';
import 'package:final_girl_tool/page/statistic_page.dart';
import 'package:final_girl_tool/page/record_game.dart';
import 'package:final_girl_tool/page/game_tracker.dart';
import 'package:final_girl_tool/page/randomizer_page.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  String titleAppBar = "";

  final _page1 = GlobalKey<NavigatorState>();
  final _page2 = GlobalKey<NavigatorState>();
  final _page3 = GlobalKey<NavigatorState>();
  final _page4 = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(titleAppBar),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CollectionSelectPage(),
                    ),
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
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _page1,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => RandomizerPage(),
            ),
          ),
          Navigator(
            key: _page2,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => GameTrackerPage(),
            ),
          ),
          Navigator(
            key: _page3,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => RecordGamePage(),
            ),
          ),
          Navigator(
            key: _page4,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => StatisticPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: 'Statistics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet_giftcard), label: 'Wallet'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
