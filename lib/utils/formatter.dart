import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime formatTimestampToDatetime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime;
}

String formatResultTimeFromDateTimeToString(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    // Message was sent today, show time only
    return DateFormat('HH:mm').format(dateTime).toString();
  } else if (dateTime.isAfter(yesterday)) {
    // Message was sent yesterday, show 'Yesterday'
    return 'Yesterday';
  } else {
    // Message was sent earlier, show date only
    return DateFormat('M/d/yyyy').format(dateTime).toString();
  }
}
