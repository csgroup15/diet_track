import 'package:hive/hive.dart';
part 'result_model_hive.g.dart';

@HiveType(typeId: 2)
class ResultModelHive {
  @HiveField(0)
  String resultID;
  @HiveField(1)
  DateTime timestamp;
  @HiveField(2)
  String userID;
  @HiveField(3)
  String foodPicURL;
  @HiveField(4)
  final List<String>? identifiedFoodIDs;

  ResultModelHive(
      {required this.resultID,
      required this.timestamp,
      required this.userID,
      required this.foodPicURL,
      this.identifiedFoodIDs});
}
