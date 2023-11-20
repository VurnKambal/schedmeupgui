import 'package:flutter/material.dart';
import 'package:schedmeupgui/custom_code/widgets/memory_animated_list_rwc.dart';

import '/backend/schema/structs/index.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _validInput = false;
  bool get validInput => _validInput;
  set validInput(bool _value) {
    _validInput = _value;
  }

  bool _isSimulating = false;
  bool get isSimulating => _isSimulating;
  set isSimulating(bool _value) {
    _isSimulating = _value;
  }

  List<int> _arrivalTimeList = [];
  List<int> get arrivalTimeList => _arrivalTimeList;
  set arrivalTimeList(List<int> _value) {
    _arrivalTimeList = _value;
  }

  void addToArrivalTimeList(int _value) {
    _arrivalTimeList.add(_value);
  }

  void removeFromArrivalTimeList(int _value) {
    _arrivalTimeList.remove(_value);
  }

  void removeAtIndexFromArrivalTimeList(int _index) {
    _arrivalTimeList.removeAt(_index);
  }

  void updateArrivalTimeListAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _arrivalTimeList[_index] = updateFn(_arrivalTimeList[_index]);
  }

  void insertAtIndexInArrivalTimeList(int _index, int _value) {
    _arrivalTimeList.insert(_index, _value);
  }

  List<int> _burstTimeList = [];
  List<int> get burstTimeList => _burstTimeList;
  set burstTimeList(List<int> _value) {
    _burstTimeList = _value;
  }

  void addToBurstTimeList(int _value) {
    _burstTimeList.add(_value);
  }

  void removeFromBurstTimeList(int _value) {
    _burstTimeList.remove(_value);
  }

  void removeAtIndexFromBurstTimeList(int _index) {
    _burstTimeList.removeAt(_index);
  }

  void updateBurstTimeListAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _burstTimeList[_index] = updateFn(_burstTimeList[_index]);
  }

  void insertAtIndexInBurstTimeList(int _index, int _value) {
    _burstTimeList.insert(_index, _value);
  }

  List<ProcessStruct> _processList = [];
  List<ProcessStruct> get processList => _processList;
  set processList(List<ProcessStruct> _value) {
    _processList = _value;
  }

  void addToProcessList(ProcessStruct _value) {
    _processList.add(_value);
  }

  void removeFromProcessList(ProcessStruct _value) {
    _processList.remove(_value);
  }

  void removeAtIndexFromProcessList(int _index) {
    _processList.removeAt(_index);
  }

  void updateProcessListAtIndex(
    int _index,
    ProcessStruct Function(ProcessStruct) updateFn,
  ) {
    _processList[_index] = updateFn(_processList[_index]);
  }

  void insertAtIndexInProcessList(int _index, ProcessStruct _value) {
    _processList.insert(_index, _value);
  }

  List<ProcessStruct> _oldProcessList = [];
  List<ProcessStruct> get oldProcessList => _oldProcessList;
  set oldProcessList(List<ProcessStruct> _value) {
    _oldProcessList = _value;
  }

  void addTOldProcessList(ProcessStruct _value) {
    _oldProcessList.add(_value);
  }

  void removeFromOldProcessList(ProcessStruct _value) {
    _oldProcessList.remove(_value);
  }

  void removeAtIndexFromOldProcessList(int _index) {
    _oldProcessList.removeAt(_index);
  }

  void updateOldProcessListAtIndex(
    int _index,
    ProcessStruct Function(ProcessStruct) updateFn,
  ) {
    _oldProcessList[_index] = updateFn(_oldProcessList[_index]);
  }

  void insertAtIndexInOldProcessList(int _index, ProcessStruct _value) {
    _oldProcessList.insert(_index, _value);
  }

  List<ProcessStruct> _newProcessList = [];
  List<ProcessStruct> get newProcessList => _newProcessList;
  set newProcessList(List<ProcessStruct> _value) {
    _newProcessList = _value;
  }

  void addToNewProcessList(ProcessStruct _value) {
    _oldProcessList.add(_value);
  }

  void removeFromNewProcessList(ProcessStruct _value) {
    _oldProcessList.remove(_value);
  }

  void removeAtIndexFromNewProcessList(int _index) {
    _oldProcessList.removeAt(_index);
  }

  void updateNewProcessListAtIndex(
    int _index,
    ProcessStruct Function(ProcessStruct) updateFn,
  ) {
    _oldProcessList[_index] = updateFn(_oldProcessList[_index]);
  }

  void insertAtIndexInNewProcessList(int _index, ProcessStruct _value) {
    _oldProcessList.insert(_index, _value);
  }

  int _pageInterrupts = 0;
  int get pageInterrupts => _pageInterrupts;
  set pageInterrupts(int _value) {
    _pageInterrupts = _value;
  }

  int _allocatedMemorySize = 0;
  int get allocatedMemorySize => _allocatedMemorySize;
  set allocatedMemorySize(int _value) {
    _allocatedMemorySize = _value;
  }

  int _memorySize = 0;
  int get memorySize => _memorySize;
  set memorySize(int _value) {
    _memorySize = _value;
  }

  int _externalFragmentation = 0;
  int get externalFragmentation => _externalFragmentation;
  set externalFragmentation(int _value) {
    _externalFragmentation = _value;
  }

  double _failRate = 0;
  double get failRate => _failRate;
  set failRate(double _value) {
    _failRate = _value;
  }

  double _successRate = 0;
  double get successRate => _successRate;
  set successRate(double _value) {
    _successRate = _value;
  }

  double _averageTurnaroundTime = 0;
  double get averageTurnaroundTime => _averageTurnaroundTime;
  set averageTurnaroundTime(double _value) {
    _averageTurnaroundTime = _value;
  }

  double _averageWaitingTime = 0;
  double get averageWaitingTime => _averageWaitingTime;
  set averageWaitingTime(double _value) {
    _averageWaitingTime = _value;
  }

  List<int> _jobSizes = [];
  List<int> get jobSizes => _jobSizes;
  set jobSizes(List<int> _value) {
    _jobSizes = _value;
  }

  void addToJobSizes(int _value) {
    _jobSizes.add(_value);
  }

  void removeFromJobSizes(int _value) {
    _jobSizes.remove(_value);
  }

  void removeAtIndexFromJobSizes(int _index) {
    _jobSizes.removeAt(_index);
  }

  void updateJobSizesAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _jobSizes[_index] = updateFn(_jobSizes[_index]);
  }

  void insertAtIndexInJobSizes(int _index, int _value) {
    _jobSizes.insert(_index, _value);
  }

  int _frames = 0;
  int get frames => _frames;
  set frames(int _value) {
    _frames = _value;
  }

  List<String> _newQueue = [];
  List<String> get newQueue => _newQueue;
  set newQueue(List<String> _value) {
    _newQueue = _value;
  }

  void addToNewQueue(String _value) {
    _newQueue.add(_value);
  }

  void removeFromNewQueue(String _value) {
    _newQueue.remove(_value);
  }

  void removeAtIndexFromNewQueue(int _index) {
    _newQueue.removeAt(_index);
  }

  void updateNewQueueAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _newQueue[_index] = updateFn(_newQueue[_index]);
  }

  void insertAtIndexInNewQueue(int _index, String _value) {
    _newQueue.insert(_index, _value);
  }

  List<MemoryBlock> _newMemoryBlocks = [];
  List<MemoryBlock> get newMemoryBlocks => _newMemoryBlocks;
  set newMemoryBlocks(List<MemoryBlock> _value) {
    _newMemoryBlocks = _value;
  }

  void addToNewMemoryBlocks(MemoryBlock _value) {
    _newMemoryBlocks.add(_value);
  }

  void removeFromNewMemoryBlocks(MemoryBlock _value) {
    _newMemoryBlocks.remove(_value);
  }

  void removeAtIndexFromNewMemoryBlocks(int _index) {
    _newMemoryBlocks.removeAt(_index);
  }

  void updateNewMemoryBlocksAtIndex(
    int _index,
    MemoryBlock Function(MemoryBlock) updateFn,
  ) {
    _newMemoryBlocks[_index] = updateFn(_newMemoryBlocks[_index]);
  }

  void insertAtIndexInNewMemoryBlocks(int _index, MemoryBlock _value) {
    _newMemoryBlocks.insert(_index, _value);
  }

  List<String> _pageQueue = [];
  List<String> get pageQueue => _pageQueue;
  set pageQueue(List<String> _value) {
    _pageQueue = _value;
  }

  void addToPageQueue(String _value) {
    _pageQueue.add(_value);
  }

  void removeFromPageQueue(String _value) {
    _pageQueue.remove(_value);
  }

  void removeAtIndexFromPageQueue(int _index) {
    _pageQueue.removeAt(_index);
  }

  void updatePageQueueAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _pageQueue[_index] = updateFn(_pageQueue[_index]);
  }

  void insertAtIndexInPageQueue(int _index, String _value) {
    _pageQueue.insert(_index, _value);
  }

  List<List<String>> _queueHistory = [];
  List<List<String>> get queueHistory => _queueHistory;
  set queueHistory(List<List<String>> _value) {
    _queueHistory = _value;
  }

  void addToQueueHistory(List<String> _value) {
    _queueHistory.add(_value);
  }

  void removeFromQueueHistory(List<String> _value) {
    _queueHistory.remove(_value);
  }

  void removeAtIndexFromQueueHistory(int _index) {
    _queueHistory.removeAt(_index);
  }

  void updateQueueHistoryAtIndex(
    int _index,
    List<String> Function(List<String>) updateFn,
  ) {
    _queueHistory[_index] = updateFn(_queueHistory[_index]);
  }

  void insertAtIndexInQueueHistory(int _index, List<String> _value) {
    _queueHistory.insert(_index, _value);
  }

  List<String> _pageRequests = [];
  List<String> get pageRequests => _pageRequests;
  set pageRequests(List<String> _value) {
    _pageRequests = _value;
  }

  void addToPageRequests(String _value) {
    _pageRequests.add(_value);
  }

  void removeFromPageRequests(String _value) {
    _pageRequests.remove(_value);
  }

  void removeAtIndexFromPageRequests(int _index) {
    _pageRequests.removeAt(_index);
  }

  void updatePageRequestsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _pageRequests[_index] = updateFn(_pageRequests[_index]);
  }

  void insertAtIndexInPageRequests(int _index, String _value) {
    _pageRequests.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
