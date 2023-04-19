import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/game.dart';
import 'package:flutter/material.dart';

class Constants {
  static final Constants instance = Constants._init();
  Girl randomizedGirl = Girl(name: "", isInCollection: true);
  Killer randomizedKiller = Killer(name: "", isInCollection: true);
  Location randomizedLocation = Location(name: "", isInCollection: true);
  Game trackedGame = Game(girlID: 0, killerID: 0, locationID: 0, win: false, victimsSaved: 0, victimsKilled: 0, gameName: "", description: "");

  Constants._init();
  List<String> randomizerMessages = [
    "You wanna try again?",
    "Too scared for this one!?",
    "That setup looks great!",
    "Ouch! Good luck!",
    "What's going on? You seem scared?",
    "What's the matter? Are you frightened?",
    "Ouch! Fingers crossed for your success!",
    "Is this one too intimidating for you?",
    "Are you too frightened to handle this challenge?",
    "Is this one too overwhelming for you?",
    "Are you feeling too afraid to take on this one?",
    "Is this task too daunting for you to tackle?",
    "Are you too scared to give this one a try?",
    "Is this one too much for you to handle?",
    "Are you too intimidated by this one?",
    "Is this task too scary for you to attempt?",
    "This one's going to be tough, no doubt about it.",
    "This won't be a walk in the park, that's for sure.",
    "Expect this one to be challenging, brace yourself.",
    "Don't underestimate the difficulty of this task.",
    "This one's not going to be easy, be prepared.",
    "Anticipate a tough time with this one.",
    "This won't be a piece of cake, be ready for a challenge.",
    "Prepare yourself, this one's going to be hard.",
    "I have my doubts about your ability to succeed.",
    "I'm not confident you'll be able to pull it off.",
    "I'm not sure you'll make it through.",
    "I have concerns about your chances of success.",
    "I'm skeptical about your ability to achieve it.",
    "I'm not convinced you'll be able to make it."
  ];

  List<String> randomizerGirlDeathMessages = [
    "You're pushing up daisies now!",
    "RIP, you're done for!",
    "Your pulse is MIA, you're officially D.O.A.",
    "Game over, you're six feet under!",
    "No more extra lives, you're ghosted!",
    "Your heart's on vacation, you're deceased!",
    "Checking out permanently, you're dead as a doornail!",
    "No more respawns, you're in the afterlife!",
    "Lights out, you're a goner!",
    "Time of death: now! You're toast!",
    "You've met your demise, you're pushing daisies!",
    "You've bitten the dust, you're no more!",
    "You're sleeping with the fishes, you're dead in the water!",
    "You're six feet under, taking a dirt nap!",
    "You're pushing up dandelions, you're out of the game!",
    "You're a goner, resting in pieces!",
    "You've kicked the bucket, you're no longer kicking!",
    "You're in the great beyond, game over for you!",
    "You're in the land of the dearly departed, RIP!",
    "You're in the eternal slumber, no more respawn for you!"
  ];

  List<String> randomizerKillerDeathMessages = [
    "You won, evil is gone, for now...",
    "You're victorious, evil is vanquished, for now...",
    "You've triumphed, evil is banished, for now...",
    "You're the conqueror, evil is defeated, for now...",
    "You're the hero, evil is subdued, for now...",
    "You've overcome, evil is quelled, for now...",
    "You're the champion, evil is eliminated, for now...",
    "You've succeeded, evil is thwarted, for now...",
    "You're the winner, evil is repelled, for now...",
    "You've prevailed, evil is driven away, for now...",
    "You're the slayer, the killer is D.O.A!",
    "You've nailed it, the killer is pushing daisies!",
    "You've triumphed, the killer is six feet under!",
    "You're the victor, the killer is out of the picture!",
    "You've outwitted, the killer is a goner!",
    "You've checkmated, the killer is terminated!",
    "You're the hero, the killer is toast!",
    "You've prevailed, the killer is resting in peace!",
    "You've conquered, the killer is a memory!",
    "You're the winner, the killer is silenced forever!",
    "You're the conqueror, the enemy is six feet under!",
    "You've emerged victorious, the enemy is pushing up daisies!",
    "You've triumphed, the enemy is vanquished and done for!",
    "You're the champ, the enemy is defeated and in the past!",
    "You're the kingpin, the enemy is terminated and out of the game!",
    "You've prevailed, the enemy is neutralized and gone for good!",
    "You're the top dog, the enemy is wiped out and no more!",
    "You're the ruler, the enemy is erased and history!",
    "You've won the battle, the enemy is silenced and done!",
    "You're the mastermind, the enemy is eliminated and out of sight!"
  ];

  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

// showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Important!'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(returnedStat.id.toString()),
//               Text(returnedStat.girlID.toString()),
//               Text(returnedStat.killerID.toString()),
//               Text(returnedStat.locationID.toString()),
//               Text(returnedStat.gameName.toString()),
//               Text(returnedStat.description.toString()),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );