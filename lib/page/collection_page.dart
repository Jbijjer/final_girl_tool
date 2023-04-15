import 'package:flutter/material.dart';
import 'package:final_girl_tool/db/final_girl_database.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/killer.dart';

class CollectionSelectPage extends StatefulWidget {
  const CollectionSelectPage({super.key});

  @override
  State<CollectionSelectPage> createState() => _CollectionSelectPageState();
}

class _CollectionSelectPageState extends State<CollectionSelectPage> {
  List<String> collection = []; // List of data for checkboxes

  List<Girl> girls = [];
  List<Killer> killers = [];
  List<Location> locations = [];
  List<bool> checkedItems = []; // List to keep track of checked items
  int selectedIndex = 1;
  List<String> checkedData = [];

  Future<void> _loadLocations() async {
    List<Location> lines = await FinalGirlDatabase.instance.getAllLocations();

    setState(() {
      locations = lines;
    });
  }

  Future<void> _loadKillers() async {
    List<Killer> lines = await FinalGirlDatabase.instance.getAllKillers();
    setState(() {
      killers = lines;
    });
  }

  Future<void> _loadGirls() async {
    List<Girl> lines = await FinalGirlDatabase.instance.getAllGirls();

    setState(() {
      girls = lines;
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
    if (selectedIndex == 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Collection"),
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
                  if (value == 1) {
                    //ABOUT
                  }
                })
          ],
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                              _loadGirls();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/girl.png"),
                                    size: 50.0), // icon
                                Text("Girls",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                              _loadKillers();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/knife.png"),
                                    size: 50.0),
                                Text("Killers",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                              });
                              _loadLocations();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/boot.png"),
                                    size: 50.0), // icon
                                Text("Locations",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: girls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(girls[index].name),
                      value: girls[index].isInCollection,
                      onChanged: (bool? value) {
                        setState(() {
                          girls[index].isInCollection = value ?? false;
                          FinalGirlDatabase.instance.updateGirl(girls[index]);
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    } else if (selectedIndex == 2) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Collection"),
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
                  if (value == 1) {
                    //ABOUT
                  }
                })
          ],
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                              _loadGirls();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/girl.png"),
                                    size: 50.0), // icon
                                Text("Girls",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                              _loadKillers();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/knife.png"),
                                    size: 50.0), // icon
                                Text("Killers",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                              });
                              _loadLocations();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const ImageIcon(AssetImage("assets/boot.png"),
                                    size: 50.0), // icon
                                const Text("Locations",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: killers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(killers[index].name),
                      value: killers[index].isInCollection,
                      onChanged: (bool? value) {
                        setState(() {
                          killers[index].isInCollection = value ?? false;
                          FinalGirlDatabase.instance
                              .updateKiller(killers[index]);
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Collection"),
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
                  if (value == 1) {
                    showAboutDialog(
                        context: context,
                        applicationLegalese:
                            "Final Girl and the Final Girl logo are a trademark of Van Ryder Games and are used with permission.\n\nThis application is not affiliated with or endorsed by Van Ryder Games in any way. ",
                        applicationName: "Final Girl Tool",
                        applicationVersion: "1.0");
                  }
                })
          ],
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                              _loadGirls();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/girl.png"),
                                    size: 50.0), // icon
                                Text("Girls",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                              _loadKillers();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/knife.png"),
                                    size: 50.0), // icon// icon
                                Text("Killers",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox.fromSize(
                      size: const Size(90, 90), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.redAccent, // splash color
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                              });
                              _loadLocations();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(AssetImage("assets/boot.png"),
                                    size: 50.0), // icon
                                Text("Locations",
                                    style: TextStyle(fontSize: 12)), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: locations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(locations[index].name),
                      value: locations[index].isInCollection,
                      onChanged: (bool? value) {
                        setState(() {
                          locations[index].isInCollection = value ?? false;
                          FinalGirlDatabase.instance
                              .updateLocation(locations[index]);
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(),
  ));
}
