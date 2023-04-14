import 'package:flutter/material.dart';

class Constants {
  static final Constants instance = Constants._init();

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