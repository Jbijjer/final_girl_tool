import 'package:flutter/material.dart';
import 'dart:math';
import 'package:final_girl_tool/db/final_girl_database.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/constants/constants.dart';

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({super.key});

  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  List<Location> locationNames = [];
  List<Killer> killerNames = [];
  List<Girl> girlNames = [];
  Color girlSelectedColor = Colors.black;
  Color killerSelectedColor = Colors.black;
  Color locationSelectedColor = Colors.black;
  bool randomized = false;

  @override
  void initState() {
    super.initState();
    _loadNamesFromFiles();
  }

  Future<void> _loadNamesFromFiles() async {
    List<Girl> girlLines =
        await FinalGirlDatabase.instance.getGirlsInCollection();
    setState(() {
      girlNames = girlLines;
    });
    List<Killer> killerLines =
        await FinalGirlDatabase.instance.getKillersInCollection();
    setState(() {
      killerNames = killerLines;
    });
    List<Location> locationLines =
        await FinalGirlDatabase.instance.getLocationsInCollection();
    setState(() {
      locationNames = locationLines;
    });
  }

  String girlName = 'The Final Girl';
  String killerName = 'The Killer';
  String locationName = 'The Location';
  String message = 'Press dice to generate a new game.';

  void _generateRandomGame() {
    randomized = true;
    _loadNamesFromFiles();
    Random random = Random();
    int index = 0;
    if (killerNames.isNotEmpty &&
        locationNames.isNotEmpty &&
        girlNames.isNotEmpty) {
      randomized = true;
      if (killerSelectedColor != Colors.red) {
        index = random.nextInt(killerNames.length);
        setState(() {
          killerName = killerNames[index].name;
        });
      }
      if (locationSelectedColor != Colors.red) {
        index = random.nextInt(locationNames.length);
        setState(() {
          locationName = locationNames[index].name;
        });
      }
      if (girlSelectedColor != Colors.red) {
        index = random.nextInt(girlNames.length);
        setState(() {
          girlName = girlNames[index].name;
        });
      }
      setState(() {});
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Important!'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Your collection is not set correctly.'),
                  Text(
                      'Please go to your collection to choose your extensions.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    index = random.nextInt(Constants.instance.randomizerMessages.length);
    setState(() {
      message = Constants.instance.randomizerMessages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: Image(
            image: AssetImage('assets/FinalGirl-Logo-Horizontal.png'),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Divider(
                height: 5,
                color: Colors.black,
              ), // icon
              GestureDetector(
                  onTap: () {
                    if (randomized) {
                      if (girlSelectedColor == Colors.black) {
                        setState(() {
                          girlSelectedColor = Colors.red;
                        });
                      } else {
                        setState(() {
                          girlSelectedColor = Colors.black;
                        });
                      }
                    }
                  },
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 8.0, 30.0, 8.0),
                      child: ImageIcon(
                        const AssetImage("assets/girl.png"),
                        size: 50.0,
                        color: girlSelectedColor,
                      ),
                    ),
                    Text(
                      girlName,
                      style: TextStyle(fontSize: 20, color: girlSelectedColor),
                    ),
                  ])),
              GestureDetector(
                onTap: () {
                  if (randomized) {
                    if (killerSelectedColor == Colors.black && randomized) {
                      setState(() {
                        killerSelectedColor = Colors.red;
                      });
                    } else {
                      setState(() {
                        killerSelectedColor = Colors.black;
                      });
                    }
                  }
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 8.0, 30.0, 8.0),
                    child: ImageIcon(
                      const AssetImage("assets/knife.png"),
                      size: 50.0,
                      color: killerSelectedColor,
                    ),
                  ),
                  Text(
                    killerName,
                    style: TextStyle(fontSize: 20, color: killerSelectedColor),
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () {
                  if (randomized) {
                    if (locationSelectedColor == Colors.black) {
                      setState(() {
                        locationSelectedColor = Colors.red;
                      });
                    } else {
                      setState(() {
                        locationSelectedColor = Colors.black;
                      });
                    }
                  }
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 8.0, 30.0, 8.0),
                    child: ImageIcon(
                      const AssetImage("assets/boot.png"),
                      size: 50.0,
                      color: locationSelectedColor,
                    ),
                  ),
                  Text(
                    locationName,
                    style:
                        TextStyle(fontSize: 20, color: locationSelectedColor),
                  ),
                ]),
              ),
              const Divider(
                height: 5,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
          child: Text(message),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: FloatingActionButton(
              onPressed: _generateRandomGame,
              backgroundColor: Colors.red,
              child: const Icon(Icons.casino)),
        ),
      ],
    );
  }
}
