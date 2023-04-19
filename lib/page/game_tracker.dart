import 'dart:math';

import 'package:flutter/material.dart';
import 'package:final_girl_tool/db/final_girl_database.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/killer.dart';

import '../constants/constants.dart';

class GameTrackerPage extends StatefulWidget {
  const GameTrackerPage({super.key});

  @override
  State<GameTrackerPage> createState() => __GameTrackerPageState();
}

class __GameTrackerPageState extends State<GameTrackerPage> {
  int victimsSaved = 0;
  int victimsKilled = 0;
  int finalGirlHP = 0;
  int killerHP = 0;
  int horrorTrack = 0;
  int bloodlust = 0;
  int i = 0;
  int j = 0;
  bool finalGirlDied = false;
  bool killerDied = false;
  String gameName = "";
  String girlDeathMessage = "";
  String killerDeathMessage = "";
  String notes = "";
  bool win = false;
  List<Girl> girls = [];
  List<Killer> killers = [];
  List<Location> locations = [];
  Girl selectedGirl = Girl(name: "", isInCollection: false);
  Killer selectedKiller = Killer(name: "", isInCollection: false);
  Location selectedLocation = Location(name: "", isInCollection: false);
  Random random = Random();
  int index = 0;

  Future<void> _loadGirls() async {
    List<Girl> lines = await FinalGirlDatabase.instance.getAllGirls();
    setState(() {
      girls = lines;
      Iterable<Girl> g = girls
          .where((girl) => Constants.instance.randomizedGirl.id == girl.id);
      if (g.isNotEmpty) {
        selectedGirl = g.first;
      } else {
        selectedGirl = girls.first;
      }
    });
  }

  Future<void> _loadKillers() async {
    List<Killer> lines = await FinalGirlDatabase.instance.getAllKillers();
    setState(() {
      killers = lines;
      Iterable<Killer> k = killers.where(
          (killer) => Constants.instance.randomizedKiller.id == killer.id);
      if (k.isNotEmpty) {
        selectedKiller = k.first;
      } else {
        selectedKiller = killers.first;
      }
    });
  }

  Future<void> _loadLocations() async {
    List<Location> lines = await FinalGirlDatabase.instance.getAllLocations();
    setState(() {
      locations = lines;
      Iterable<Location> l = locations.where((location) =>
          Constants.instance.randomizedLocation.id == location.id);
      if (l.isNotEmpty) {
        selectedLocation = l.first;
      } else {
        selectedLocation = locations.first;
      }
    });
  }

  _showGirlDiedFirstTime() async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Oh no!!'),
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              if (i > 0) {
                                i--;
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.remove)),
                    Text(i.toString()),
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              i++;
                            },
                          );
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context, finalGirlHP);
                  },
                ),
              ],
            );
          });
        });
    setState(() {
      finalGirlHP = i;
    });
  }

  _showKillerFirstTime() async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Oh yeah!!'),
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              if (j > 0) {
                                j--;
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.remove)),
                    Text(j.toString()),
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              j++;
                            },
                          );
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context, killerHP);
                  },
                ),
              ],
            );
          });
        });
    setState(() {
      killerHP = j;
    });
  }

  _generateGirlDeathMessage() {
    index =
        random.nextInt(Constants.instance.randomizerGirlDeathMessages.length);
    setState(() {
      girlDeathMessage = Constants.instance.randomizerGirlDeathMessages[index];
    });
  }

  Future<void> _showGirlDied() async {
    _generateGirlDeathMessage();
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('You died!'),
            content: SingleChildScrollView(child: Text(girlDeathMessage)),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
            ],
          );
        });
  }

  _generateKillerDeathMessage() {
    index =
        random.nextInt(Constants.instance.randomizerKillerDeathMessages.length);
    setState(() {
      killerDeathMessage =
          Constants.instance.randomizerKillerDeathMessages[index];
    });
  }

  _showKillerDied() async {
    _generateKillerDeathMessage();
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('You win!'),
            content: SingleChildScrollView(child: Text(killerDeathMessage)),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _loadGirls();
    _loadKillers();
    _loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: 379,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Game name:"),
                onChanged: (value) => Constants.instance.trackedGame.gameName = value,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            child: Row(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Final Girl:"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Killer:"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Location:"),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<Girl>(
                    value: selectedGirl,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 8,
                    style: const TextStyle(color: Colors.red),
                    underline: Container(
                      height: 2,
                      color: Colors.redAccent,
                    ),
                    onChanged: (Girl? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedGirl = value!;
                      });
                    },
                    items: girls.map((Girl girl) {
                      return DropdownMenuItem<Girl>(
                          value: girl, child: Text(girl.name));
                    }).toList(),
                  ),
                  DropdownButton<Killer>(
                    value: selectedKiller,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 8,
                    style: const TextStyle(color: Colors.red),
                    underline: Container(
                      height: 2,
                      color: Colors.redAccent,
                    ),
                    onChanged: (Killer? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedKiller = value!;
                      });
                    },
                    items: killers.map((Killer killer) {
                      return DropdownMenuItem<Killer>(
                          value: killer, child: Text(killer.name));
                    }).toList(),
                  ),
                  DropdownButton<Location>(
                    value: selectedLocation,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 8,
                    style: const TextStyle(color: Colors.red),
                    underline: Container(
                      height: 2,
                      color: Colors.redAccent,
                    ),
                    onChanged: (Location? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedLocation = value!;
                      });
                    },
                    items: locations.map((Location location) {
                      return DropdownMenuItem<Location>(
                          value: location, child: Text(location.name));
                    }).toList(),
                  ),
                ],
              )
            ]),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 14),
                      child: Text(
                        "Final Girl HP",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 14, 8, 12),
                      child: Text(
                        "Killer HP",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                          child: Text(
                            finalGirlHP.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.purple,
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                          child: Text(
                            killerHP.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (finalGirlHP > 0) {
                                  finalGirlHP--;
                                  if (finalGirlHP == 0 && finalGirlDied) {
                                    _showGirlDied();
                                  } else if (finalGirlHP == 0) {
                                    finalGirlDied = true;
                                    _showGirlDiedFirstTime();
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                finalGirlHP++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (killerHP > 0) {
                                  killerHP--;
                                  if (killerHP == 0 && killerDied) {
                                    _showKillerDied();
                                  } else if (killerHP == 0) {
                                    killerDied = true;
                                    _showKillerFirstTime();
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                killerHP++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        8,
                        8,
                        12,
                      ),
                      child: Text(
                        "Victims Saved",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        16,
                        8,
                        12,
                      ),
                      child: Text(
                        "Victims Killed",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/meeple.png"),
                          color: Colors.yellow,
                          size: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                          child: Text(
                            Constants.instance.trackedGame.victimsSaved.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/meeple.png"),
                          color: Colors.red,
                          size: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                          child: Text(
                            Constants.instance.trackedGame.victimsKilled.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (Constants.instance.trackedGame.victimsSaved > 0) {
                                  Constants.instance.trackedGame.victimsSaved--;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                Constants.instance.trackedGame.victimsSaved++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (Constants.instance.trackedGame.victimsKilled > 0) {
                                  Constants.instance.trackedGame.victimsKilled--;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                Constants.instance.trackedGame.victimsKilled++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        8,
                        8,
                        12,
                      ),
                      child: Text(
                        "Horror Track",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        30,
                        8,
                        8,
                      ),
                      child: Text(
                        "Bloodlust",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/ghost.png"),
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 34, 20, 14),
                          child: Text(
                            horrorTrack.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/splatter.png"),
                          color: Colors.red,
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                          child: Text(
                            bloodlust.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (horrorTrack > 0) {
                                    horrorTrack--;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  horrorTrack++;
                                });
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (bloodlust > 0) {
                                    bloodlust--;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  bloodlust++;
                                });
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Record Game")),
          )
        ],
      ),
    );
  }
}