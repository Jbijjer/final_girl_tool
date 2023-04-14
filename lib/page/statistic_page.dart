import 'package:flutter/material.dart';
import 'package:final_girl_tool/db/final_girl_database.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/model/game.dart';
import 'package:final_girl_tool/model/statistic.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => __StatisticPageState();
}

class __StatisticPageState extends State<StatisticPage> {
  List<Game> games = [];
  int currentIndex = 0;
  Game currentStatistic = Game(
      girlID: 1,
      killerID: 1,
      locationID: 1,
      win: false,
      victimsSaved: 0,
      victimsKilled: 0,
      gameName: "",
      description: "");
  Girl currentGirl = Girl(name: "", isInCollection: true);
  Killer currentKiller = Killer(name: "", isInCollection: true);
  Location currentLocation = Location(name: "", isInCollection: true);
  Statistic detailedStatistic = Statistic(
    gamesCount: 0,
    wonCount: 0,
    lossCount: 0,
    mostPlayedGirl: Girl(name: "", isInCollection: false),
    mostPlayedKiller: Killer(name: "", isInCollection: false),
    mostPlayedLocation: Location(name: "", isInCollection: false),
    mostWonGirl: Girl(name: "", isInCollection: false),
    mostWonKiller: Killer(name: "", isInCollection: false),
    mostWonLocation: Location(name: "", isInCollection: false),
    mostLostGirl: Girl(name: "", isInCollection: false),
    mostLostKiller: Killer(name: "", isInCollection: false),
    mostLostLocation: Location(name: "", isInCollection: false),
  );

  Future<void> _loadStatistics() async {
    games = await FinalGirlDatabase.instance.getAllGames();
    List<Girl> girls = await FinalGirlDatabase.instance.getAllGirls();
    List<Killer> killers = await FinalGirlDatabase.instance.getAllKillers();
    List<Location> locations =
        await FinalGirlDatabase.instance.getAllLocations();

    setState(() {
      if (games.isNotEmpty) {
        currentStatistic = games[currentIndex];
        currentGirl = girls.where((g) => g.id == currentStatistic.girlID).first;
        currentKiller =
            killers.where((k) => k.id == currentStatistic.killerID).first;
        currentLocation =
            locations.where((l) => l.id == currentStatistic.locationID).first;
      }
    });
  }

  Future<void> _loadDetailedStatistics() async {
    detailedStatistic.gamesCount =
        await FinalGirlDatabase.instance.getGamesCount();
    detailedStatistic.wonCount =
        await FinalGirlDatabase.instance.getGamesWonCount();
    detailedStatistic.lossCount =
        await FinalGirlDatabase.instance.getGamesLostCount();

    final String mostPlayedGirlID =
        await FinalGirlDatabase.instance.getMostPlayedGirl();
    final Girl mostPlayedGirl =
        await FinalGirlDatabase.instance.readGirl(mostPlayedGirlID);

    final String mostPlayedKillerID =
        await FinalGirlDatabase.instance.getMostPlayedKiller();
    final Killer mostPlayedKiller =
        await FinalGirlDatabase.instance.readKiller(mostPlayedKillerID);

    final String mostPlayedLocationID =
        await FinalGirlDatabase.instance.getMostPlayedLocation();
    final Location mostPlayedLocation =
        await FinalGirlDatabase.instance.readLocation(mostPlayedLocationID);

    final String mostWinGirlID =
        await FinalGirlDatabase.instance.getMostWinGirl();
    final Girl mostWinGirl =
        await FinalGirlDatabase.instance.readGirl(mostWinGirlID);

    final String mostWinKillerID =
        await FinalGirlDatabase.instance.getMostWinKiller();
    final Killer mostWinKiller =
        await FinalGirlDatabase.instance.readKiller(mostWinKillerID);

    final String mostWinLocationID =
        await FinalGirlDatabase.instance.getMostWinLocation();
    final Location mostWinLocation =
        await FinalGirlDatabase.instance.readLocation(mostWinLocationID);

    final String mostLostGirlID =
        await FinalGirlDatabase.instance.getMostLostGirl();
    final Girl mostLostGirl =
        await FinalGirlDatabase.instance.readGirl(mostLostGirlID);

    final String mostLostKillerID =
        await FinalGirlDatabase.instance.getMostLostKiller();
    final Killer mostLostKiller =
        await FinalGirlDatabase.instance.readKiller(mostLostKillerID);

    final String mostLostLocationID =
        await FinalGirlDatabase.instance.getMostLostLocation();
    final Location mostLostLocation =
        await FinalGirlDatabase.instance.readLocation(mostLostLocationID);
    setState(() {
      detailedStatistic.mostPlayedGirl = mostPlayedGirl;
      detailedStatistic.mostPlayedKiller = mostPlayedKiller;
      detailedStatistic.mostPlayedLocation = mostPlayedLocation;
      detailedStatistic.mostWonGirl = mostWinGirl;
      detailedStatistic.mostWonKiller = mostWinKiller;
      detailedStatistic.mostWonLocation = mostWinLocation;
      detailedStatistic.mostLostGirl = mostLostGirl;
      detailedStatistic.mostLostKiller = mostLostKiller;
      detailedStatistic.mostLostLocation = mostLostLocation;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStatistics();
    _loadDetailedStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Games played:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Games won:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Games loss:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Most played Final Girl:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Most played Killer:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Most played Location:",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      detailedStatistic.gamesCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      detailedStatistic.wonCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      detailedStatistic.lossCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      detailedStatistic.mostPlayedGirl.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      detailedStatistic.mostPlayedKiller.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      detailedStatistic.mostPlayedLocation.name,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 12,
            thickness: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Most Win with"),
                    Text(
                      detailedStatistic.mostWonGirl.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: ImageIcon(
                      AssetImage("assets/girl.png"),
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Most Losses with"),
                    Text(
                      detailedStatistic.mostLostGirl.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 12,
            thickness: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Most Win against"),
                    Text(
                      detailedStatistic.mostWonKiller.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: ImageIcon(
                      AssetImage("assets/knife.png"),
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Most Losses against"),
                    Text(
                      detailedStatistic.mostLostKiller.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 12,
            thickness: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Most Win at"),
                    Text(
                      detailedStatistic.mostWonLocation.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: ImageIcon(
                      AssetImage("assets/boot.png"),
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Most Losses at"),
                    Text(
                      detailedStatistic.mostLostLocation.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 12,
            thickness: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Game #${currentIndex + 1}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Game name:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Final Girl:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Killer:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Location:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Victims saved:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Victims killed:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Note:",
                        style: TextStyle(fontSize: 20),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (currentIndex > 0) {
                                    currentIndex--;
                                    _loadStatistics();
                                  } else {
                                    currentIndex = games.length - 1;
                                    _loadStatistics();
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (currentIndex < games.length - 1) {
                                    currentIndex++;
                                    _loadStatistics();
                                  } else {
                                    currentIndex = 0;
                                    _loadStatistics();
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      Text(
                        currentStatistic.gameName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        currentGirl.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        currentKiller.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        currentLocation.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${currentStatistic.victimsSaved}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${currentStatistic.victimsKilled}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        currentStatistic.description,
                        style: const TextStyle(fontSize: 20),
                      )
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
