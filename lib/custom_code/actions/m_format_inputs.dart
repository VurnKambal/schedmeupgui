// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future mRWCFormatInputs(
  String memorySize,
  String jobSizes,
) async {
  int formattedMemorySize = int.parse(memorySize);
  //  remove all whitespaces from arrivalTime and burstTime and split by "," as integer
  String formattedJobSizes = jobSizes.replaceAll(' ', '');
  List<int> jobSizesList = formattedJobSizes.split(',').map(int.parse).toList();

  int totalJobSize = jobSizesList.reduce((a, b) => a + b);
  FFAppState().update(() {
    FFAppState().allocatedMemorySize = (formattedMemorySize * 0.8).toInt();
  });
  if (formattedMemorySize >= 10 &&
      formattedMemorySize <= 1000 &&
      !jobSizesList.contains(0)) {
    FFAppState().validInput = true;
    FFAppState().memorySize = formattedMemorySize;
    FFAppState().jobSizes = jobSizesList;
  } else {
    FFAppState().validInput = false;
  }
}

Future mLRUFormatInputs(
  String frames,
  String pageRequests,
) async {
  int formattedFrames = int.parse(frames);

  //  remove all whitespaces from arrivalTime and burstTime and split by ","
  String formattedPageRequests = pageRequests.replaceAll(' ', '');

  List<String> pageRequestsList = formattedPageRequests.split(',');
  if (formattedFrames >= 2 &&
      formattedFrames <= 5 &&
      !pageRequestsList.contains('')) {
    FFAppState().validInput = true;
    FFAppState().frames = formattedFrames;
    FFAppState().pageRequests = pageRequestsList;
  } else {
    FFAppState().validInput = false;
  }
}
