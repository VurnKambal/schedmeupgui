// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';

// Begin custom widget code
class ProcessAnimatedListSJN extends StatefulWidget {
  const ProcessAnimatedListSJN({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  ProcessAnimatedListSJNState createState() =>
      ProcessAnimatedListSJNState(width: width, height: height);
}

class ProcessAnimatedListSJNState extends State<ProcessAnimatedListSJN> {
  ProcessAnimatedListSJNState({this.width, this.height});
  double? width;
  double? height;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<ProcessStruct> _processList = []; // Initialize with your process list
  List<int> processIdList = [];

  int delaySeconds = 1;
  int delayMiliseconds = 500;
  int time = 0;

  @override
  void initState() {
    super.initState();
  }

  List<ProcessStruct> get processes => _processList;
  set processes(List<ProcessStruct> _value) {
    _processList = _value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width!,
        height: height,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _processList.length,
          itemBuilder: (context, index, animation) =>
              _buildItem(_processList[index], animation),
        ));
  }

  Widget _buildItem(ProcessStruct item, Animation<double> animation) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: SizedBox(
          // Actual widget to display
          height: 50.0,
          child: Card(
            color: Colors.primaries[item.processId % Colors.primaries.length],
            child: Center(
              child: Text(
                  'P${item.processId} [AT:${item.arrivalTime}|BT:${item.burstTime}]',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ));
  }

  Future<void> addItem(ProcessStruct item) async {
    // If the process is not already in the list, add it
    print(item);
    print(_processList);
    print("---");
    if (!_processList.contains(item)) {
      _processList.add(item);
      _listKey.currentState!.insertItem(_processList.length - 1);
      processIdList.add(item.processId);
      await Future.delayed(Duration(seconds: delaySeconds));
    }
  }

  Future<void> insertItem(int index, ProcessStruct item) async {
    _processList.insert(index, item);
    _listKey.currentState!.insertItem(index);
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  Future<void> removeItem(int index) async {
    ProcessStruct removedItem = _processList.removeAt(index);

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
    await Future.delayed(Duration(milliseconds: delayMiliseconds));
  }

  Future<void> clear() async {
    while (_processList.isNotEmpty) {
      ProcessStruct removedItem = _processList.removeAt(0);
      _listKey.currentState!.removeItem(
        0,
        (context, animation) => _buildItem(removedItem, animation),
      );
    }
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  Future<void> sortItems() async {
    // List<ProcessStruct> oldList = FFAppState().oldProcessList;
    List<ProcessStruct> newList = FFAppState().newProcessList;
    bool isSame = true;

    // Check if the old list contains the same items as the new list
    if (_processList.length != newList.length) {
      Exception("Lists are not the same length [Backend Error]");
    }
    for (int i = 0; i < _processList.length; i++) {
      if (_processList[i].processId != newList[i].processId) {
        isSame = false;
        break;
      }
    }
    // if (_processList.isEmpty) {
    //   print("empty");
    //   insertItem(0, newList[0]);
    //   await Future.delayed(Duration(seconds: delaySeconds));
    //   print("Not anymore");
    //   return;
    // }
    // If the lists are the same, do nothing (Not sorted)
    if (isSame) {
      return;
    }

    // If the lists are not the same, List has been sorted
    else {
      // Remove all items except for the running process

      if (_processList[0] != newList[0]) {
        await removeItem(0);
        while (_processList.isNotEmpty) {
          await removeItem(0);
        }
        // Add items back in sorted order
        for (int i = 0; i < newList.length; i++) {
          await insertItem(i, newList[i]);
        }
      } else {
        while (_processList.length > 1) {
          await removeItem(1);
        }
        // Add items back in sorted order
        for (int i = 1; i < newList.length; i++) {
          if (newList[i].arrivalTime <= time) {
            await insertItem(i, newList[i]);
          }
        }
      }
    }
  }

// Animate? Processes are sorted, then the running process is moved to the front [0]
// Sort Proccess for SJN
  List<ProcessStruct> _sortProcessesSJN(List<ProcessStruct> processes, time) {
    processes.sort((a, b) {
      if (a.arrivalTime <= time && b.arrivalTime <= time) {
        // If both processes have arrived, sort processes by burst time
        if (a.burstTime == b.burstTime) {
          // If remaining time is equal, sort processes by arrival time
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
// Preemptive Shortest Job Next
  Future startSJN(GlobalKey<ProcessAnimatedListSJNState>? listKey,
      List<int> arrivalTimeList, List<int> burstTimeList) async {
    await listKey!.currentState!.clear();
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
    processes = _sortProcessesSJN(processes, time);
    FFAppState().update(() {
      FFAppState().newProcessList = List.from(processes);
    });
    FFAppState().update(() {
      FFAppState().oldProcessList = List.from(processes);
    });
    while (
        FFAppState().isSimulating && (time <= sumBurstTime && completed < n)) {
      // If no process has arrived yet, set time by arrival time of the next process
      if (time < processes[0].arrivalTime) {
        sumBurstTime += processes[0].arrivalTime - time;
        time = processes[0].arrivalTime;
      }
      for (ProcessStruct process in processes) {
        // If arrived, add to list
        if (process.arrivalTime == time) {
          await listKey.currentState!.addItem(process);
        }
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

      FFAppState().update(() {
        FFAppState().oldProcessList = List.from(processes);
      });

      // Animate? Sort processes by arrival time then burst time
      processes = _sortProcessesSJN(processes, time);
      FFAppState().update(() {
        FFAppState().newProcessList = List.from(processes);
      });
      await listKey.currentState!.sortItems();
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
    FFAppState().update(() {
      FFAppState().processList = List.from(processes);
    });
  }
}
