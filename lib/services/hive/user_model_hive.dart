import 'package:hive/hive.dart';

part 'user_model_hive.g.dart';

@HiveType(typeId: 1)
class UserModelHive {
  @HiveField(0)
  final String userID;
  @HiveField(1)
  final String givenName;
  @HiveField(2)
  final String otherNames;
  @HiveField(3)
  final String email;

  UserModelHive({
    required this.userID,
    required this.givenName,
    required this.otherNames,
    required this.email,
  });
}
