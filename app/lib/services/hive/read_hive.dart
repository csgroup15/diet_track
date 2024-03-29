import 'package:diet_track/services/hive/user_model_hive.dart';

import '../../config/constants.dart';
import 'result_model_hive.dart';

UserModelHive readUserModelFromHive() {
  final UserModelHive user = userDataBox.getAt(0);

  return user;
}

List<ResultModelHive> readUserResultsFromHive() {
  final results = userResultsBox.values.toList();
  results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return results.cast<ResultModelHive>();
}

ResultModelHive? readLatestUserResultFromHive() {
  final results = userResultsBox.values.toList();
  if (userResultsBox.isNotEmpty) {
    results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    ResultModelHive latestResult = results.isNotEmpty ? results.first : null;
    return latestResult;
  }
  return null;
}
