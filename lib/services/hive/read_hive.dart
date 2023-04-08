import 'package:diet_track/services/hive/user_model_hive.dart';
import 'package:hive/hive.dart';

import 'result_model_hive.dart';

final localUserDataBox = Hive.box('user_info');
final localUserResultsBox = Hive.box('results');

UserModelHive readUserModelFromHive() {
  final UserModelHive user = localUserDataBox.getAt(0);

  return user;
}

List<ResultModelHive> readUserResultsFromHive() {
  final results = localUserResultsBox.values.toList();
  results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return results.cast<ResultModelHive>();
}

ResultModelHive? readLatestUserResultFromHive() {
  final results = localUserResultsBox.values.toList();
  if (localUserResultsBox.isNotEmpty) {
    results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    ResultModelHive latestResult = results.isNotEmpty ? results.first : null;
    return latestResult;
  }
  return null;
}
