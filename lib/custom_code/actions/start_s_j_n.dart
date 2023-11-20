// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Sort Proccess for SJN
List<ProcessStruct> sortProcesses(List<ProcessStruct> processes, time) {
  processes.sort((a, b) {
    if (a.arrivalTime <= time && b.arrivalTime <= time) {
      // If both processes have arrived, sort processes by burst time
      if (a.burstTime == b.burstTime) {
        // If burst time is equal, sort processes by arrival time
        if (a.arrivalTime == b.arrivalTime) {
          // If arrival time is equal, sort processes by process id
          return a.processId.compareTo(b.processId);
        } else {
          // If arrival time is not equal, sort processes by arrival time
          return a.arrivalTime.compareTo(b.arrivalTime);
        }
      } else {
        // If remaining time is not equal, sort processes by burst time
        return a.remainingTime.compareTo(b.burstTime);
      }
    } else {
      // If either process has not arrived, sort processes by arrival time
      return a.arrivalTime.compareTo(b.arrivalTime);
    }
  });

  // Animate? Moving the running process to the front of the queue
  return processes;
}

// GitHub Copilot assisted
// Non-Preemptive Shortest Job Next
Future startSJN(List<int> arrivalTimeList, List<int> burstTimeList) async {
  int n = 0;
  int time = 0;
  int sumt = 0;
  int sumw = 0;
  int completed = 0;
  int sumBurstTime = 0;
  List<ProcessStruct> temp = [];

  n = burstTimeList.length;
  List<ProcessStruct> processes = [];

  for (int i = 0; i < n; i++) {
    int arrivalTime = arrivalTimeList[i];
    int burstTime = burstTimeList[i];

    sumBurstTime += burstTime;
    processes.add(ProcessStruct(
        processId: i + 1,
        arrivalTime: arrivalTime,
        burstTime: burstTime,
        remainingTime: burstTime));
  }

  // Initially sort processes by arrival time then burst time
  processes = sortProcesses(processes, time);

  while (time <= sumBurstTime && completed < n) {
    // If no process has arrived yet, set time by arrival time of the next process
    if (time < processes[0].arrivalTime) {
      sumBurstTime += processes[0].arrivalTime - time;
      time = processes[0].arrivalTime;
    }
    // Animate? Moving the running process to the front of the queue
    // Time is incremented by burst time of the process
    time += processes[0].burstTime;

    // Animate? Completion of the running process
    completed++;
    processes[0].completionTime = time;

    // Calculation of turnaround time and waiting time
    processes[0].turnAroundTime =
        processes[0].completionTime - processes[0].arrivalTime;
    processes[0].waitingTime =
        processes[0].turnAroundTime - processes[0].burstTime;

    // Sum of turnaround time and waiting time
    sumt += processes[0].turnAroundTime;
    sumw += processes[0].waitingTime;

    // Completed process is added to temp
    temp.add(processes[0]);

    // Remove completed process from queue
    processes.removeAt(0);

    // Animate? Sort processes by arrival time then burst time
    processes = sortProcesses(processes, time);
  }
  // Add completed processes to processes
  processes = temp;

  // Sort processes by process id for table
  processes.sort((a, b) => a.processId.compareTo(b.processId));

  // Display table (Debugging)
  print("P\tAT\tBT\tCT\tTAT\tWT");
  for (int i = 0; i < processes.length; i++) {
    print(
        "P${processes[i].processId}\t${processes[i].arrivalTime}\t${processes[i].burstTime}\t${processes[i].completionTime}\t${processes[i].turnAroundTime}\t${processes[i].waitingTime}");
  }
  print("Average Turnaround Time= ${sumt / n}");
  print("Average Waiting Time= ${sumw / n}");
  FFAppState().oldProcessList = processes;
  FFAppState().update(() {
    FFAppState().averageTurnaroundTime =
        double.parse((sumt / n).toStringAsFixed(2));
    FFAppState().averageWaitingTime =
        double.parse((sumw / n).toStringAsFixed(2));
    ;
  });
}
