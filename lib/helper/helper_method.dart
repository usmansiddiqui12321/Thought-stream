//return formatted data as String

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  //timestamp is object we retrieve from Firebase
  //so display it , lets convert it to Text string

  DateTime dateTime = timestamp.toDate();
  //get year
  String year = dateTime.year.toString();
  //get month
  String month = dateTime.month.toString();
  //get day
  String day = dateTime.day.toString();
  //final formatted Date
  String formattedDate = '$day/$month/$year';
  return formattedDate;
}
