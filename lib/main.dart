// ignore_for_file: library_private_types_in_public_api

import 'package:final_girl_tool/page/collection_page.dart';
import 'package:final_girl_tool/page/statistic_page.dart';
import 'package:final_girl_tool/page/record_game.dart';
import 'package:final_girl_tool/page/game_tracker.dart';
import 'package:flutter/material.dart';
import 'page/randomizer_page.dart';

void main() => runApp(const RandomNameApp());

class RandomNameApp extends StatelessWidget {
  const RandomNameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Girl Tool',
      home: const FinalGirlTool(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

class FinalGirlTool extends StatefulWidget {
  const FinalGirlTool({super.key});

  @override
  _FinalGirlToolState createState() => _FinalGirlToolState();
}

class _FinalGirlToolState extends State<FinalGirlTool> {
  int currentIndex = 0;
  List<Widget> pages = const [
    RandomizerPage(),
    GameTrackerPage(),
    RecordGamePage(),
    StatisticPage(),
  ];
  String titleAppBar = "Randomizer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.casino),
            label: "Randomizer",
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note),
            label: "Tracker",
          ),
          NavigationDestination(
              icon: Icon(Icons.radio_button_checked), label: "Recorder"),
          NavigationDestination(
              icon: Icon(Icons.bar_chart), label: "Statistics"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
            switch (index) {
              case 0:
                titleAppBar = "Randomizer";
                break;
              case 1:
                titleAppBar = "Track Game";
                break;
              case 2:
                titleAppBar = "Record Game";
                break;
              case 3:
                titleAppBar = "Statistics";
                break;
            }
          });
        },
        selectedIndex: currentIndex,
      ),
    );
  }
}
