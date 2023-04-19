import 'package:final_girl_tool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:final_girl_tool/db/final_girl_database.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/model/game.dart';

class RecordGamePage extends StatefulWidget {
  const RecordGamePage({super.key});

  @override
  State<RecordGamePage> createState() => __RecordGamePageState();
}

class __RecordGamePageState extends State<RecordGamePage> {
  int victimsSaved = 0;
  int victimsKilled = 0;
  String gameName = "";
  String notes = "";
  bool win = false;
  List<Girl> girls = [];
  List<Killer> killers = [];
  List<Location> locations = [];
  Girl selectedGirl = Girl(name: "", isInCollection: false);
  Killer selectedKiller = Killer(name: "", isInCollection: false);
  Location selectedLocation = Location(name: "", isInCollection: false);

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

  Future<void> _saveGame() async {
    Game game = Game(
        girlID: selectedGirl.id!,
        killerID: selectedKiller.id!,
        locationID: selectedLocation.id!,
        win: win,
        victimsSaved: Constants.instance.trackedGame.victimsSaved,
        victimsKilled: Constants.instance.trackedGame.victimsKilled,
        gameName: Constants.instance.trackedGame.gameName,
        description: notes);

    await FinalGirlDatabase.instance.createGame(game);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Recorded game!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[Text("Your game is recorded!")],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              width: 379,
              child: TextFormField(
                initialValue: Constants.instance.trackedGame.gameName,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Game name:"),
                onChanged: (value) =>
                    Constants.instance.trackedGame.gameName = value,
              ),
            ),
          ),
        ]),
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              width: 379,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Notes:"),
                onChanged: (value) => notes = value,
              ),
            ),
          )
        ]),
        Row(children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("You won?"),
          ),
          Switch(
            // This bool value toggles the switch.
            value: Constants.instance.trackedGame.win,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                win = value;
              });
            },
          ),
        ]),
        Row(children: <Widget>[
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
                elevation: 16,
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
                elevation: 16,
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
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: [
                Text('Victims Saved',
                    style: Theme.of(context).textTheme.titleSmall),
                NumberPicker(
                  value: Constants.instance.trackedGame.victimsSaved,
                  minValue: 0,
                  maxValue: 20,
                  haptics: true,
                  onChanged: (value) => setState(() =>
                      Constants.instance.trackedGame.victimsSaved = value),
                ),
              ]),
              Column(
                children: [
                  Text('Victims Killed',
                      style: Theme.of(context).textTheme.titleSmall),
                  NumberPicker(
                    value: Constants.instance.trackedGame.victimsKilled,
                    minValue: 0,
                    maxValue: 20,
                    haptics: true,
                    onChanged: (value) => setState(() =>
                        Constants.instance.trackedGame.victimsKilled = value),
                  ),
                ],
              )
            ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: FloatingActionButton(
              onPressed: () {
                _saveGame();
              },
              child: const Icon(Icons.save)),
        ),
      ],
    );
  }
}
