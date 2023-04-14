import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/model/location.dart';

// class StatisticsFields {
//   static final List<String> values = [
//     /// Add all fields

//     gamesCount, wonCount, lossCount, mostPlayedGirl, mostPlayedKiller,
//     mostPlayedLocation, mostWonGirl,
//     mostWonKiller, mostWonLocation, mostLostGirl, mostLostKiller,
//     mostLostLocation,
//   ];

//   static String gamesCount = '_gamesCount';
//   static String wonCount = 'wonCount';
//   static String lossCount = 'lossCount';
//   static String mostPlayedGirl = 'mostPlayedGirl';
//   static String mostPlayedKiller = 'mostPlayedKiller';
//   static String mostPlayedLocation = 'mostPlayedLocation';
//   static String mostWonGirl = 'mostWonGirl';
//   static String mostWonKiller = 'mostWonKiller';
//   static String mostWonLocation = 'mostWonLocation';
//   static String mostLostGirl = 'mostLostGirl';
//   static String mostLostKiller = 'mostLostKiller';
//   static String mostLostLocation = 'mostLostLocation';
// }

class Statistic {
  int gamesCount;
  int wonCount;
  int lossCount;
  Girl mostPlayedGirl;
  Killer mostPlayedKiller;
  Location mostPlayedLocation;
  Girl mostWonGirl;
  Killer mostWonKiller;
  Location mostWonLocation;
  Girl mostLostGirl;
  Killer mostLostKiller;
  Location mostLostLocation;

  Statistic({
    required this.gamesCount,
    required this.wonCount,
    required this.lossCount,
    required this.mostPlayedGirl,
    required this.mostPlayedKiller,
    required this.mostPlayedLocation,
    required this.mostWonGirl,
    required this.mostWonKiller,
    required this.mostWonLocation,
    required this.mostLostGirl,
    required this.mostLostKiller,
    required this.mostLostLocation,
  });
}
