// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future psFormatInputs(
  String arrivalTime,
  String burstTime,
) async {
  //  remove all whitespaces from arrivalTime and burstTime and split by "," as integer
  String formattedArrivalTime = arrivalTime.replaceAll(' ', '');
  String formattedBurstTime = burstTime.replaceAll(' ', '');

  List<int> arrivalTimeList =
      formattedArrivalTime.split(',').map(int.parse).toList();
  List<int> burstTimeList =
      formattedBurstTime.split(',').map(int.parse).toList();

  if (arrivalTimeList.length == burstTimeList.length &&
      !burstTimeList.contains(0)) {
    FFAppState().validInput = true;
    FFAppState().arrivalTimeList = arrivalTimeList;
    FFAppState().burstTimeList = burstTimeList;
  } else {
    FFAppState().validInput = false;
  }
}
