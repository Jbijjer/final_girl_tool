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
      selectedGirl = girls[0];
    });
  }

  Future<void> _loadKillers() async {
    List<Killer> lines = await FinalGirlDatabase.instance.getAllKillers();
    setState(() {
      killers = lines;
      selectedKiller = killers[0];
    });
  }

  Future<void> _loadLocations() async {
    List<Location> lines = await FinalGirlDatabase.instance.getAllLocations();
    setState(() {
      locations = lines;
      selectedLocation = locations[0];
    });
  }

  Future<void> _saveGame() async {
    Game game = Game(
        girlID: selectedGirl.id!,
        killerID: selectedKiller.id!,
        locationID: selectedLocation.id!,
        win: win,
        victimsSaved: victimsSaved,
        victimsKilled: victimsKilled,
        gameName: gameName,
        description: notes);

    await FinalGirlDatabase.instance.createGame(game);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Recorded game!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text("Your game is recorded!")],
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              width: 379,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Game name:"),
                onChanged: (value) => gameName = value,
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
            value: win,
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
            children: [
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
                elevation: 16,
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
                  value: victimsSaved,
                  minValue: 0,
                  maxValue: 20,
                  haptics: true,
                  onChanged: (value) => setState(() => victimsSaved = value),
                ),
              ]),
              Column(
                children: [
                  Text('Victims Killed',
                      style: Theme.of(context).textTheme.titleSmall),
                  NumberPicker(
                    value: victimsKilled,
                    minValue: 0,
                    maxValue: 20,
                    haptics: true,
                    onChanged: (value) => setState(() => victimsKilled = value),
                  ),
                ],
              )
            ]),
        FloatingActionButton(
            onPressed: () {
              _saveGame();
            },
            child: const Icon(Icons.save)),
      ],
    );
  }
}
