// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProcessStruct extends BaseStruct {
  ProcessStruct({
    int? processId,
    int? arrivalTime,
    int? burstTime,
    int? completionTime,
    int? turnAroundTime,
    int? waitingTime,
    int? remainingTime,
  })  : _processId = processId,
        _arrivalTime = arrivalTime,
        _burstTime = burstTime,
        _completionTime = completionTime,
        _turnAroundTime = turnAroundTime,
        _waitingTime = waitingTime,
        _remainingTime = remainingTime;

  // "processId" field.
  int? _processId;
  int get processId => _processId ?? 0;
  set processId(int? val) => _processId = val;
  void incrementProcessId(int amount) => _processId = processId + amount;
  bool hasProcessId() => _processId != null;

  // "arrivalTime" field.
  int? _arrivalTime;
  int get arrivalTime => _arrivalTime ?? 0;
  set arrivalTime(int? val) => _arrivalTime = val;
  void incrementArrivalTime(int amount) => _arrivalTime = arrivalTime + amount;
  bool hasArrivalTime() => _arrivalTime != null;

  // "burstTime" field.
  int? _burstTime;
  int get burstTime => _burstTime ?? 0;
  set burstTime(int? val) => _burstTime = val;
  void incrementBurstTime(int amount) => _burstTime = burstTime + amount;
  bool hasBurstTime() => _burstTime != null;

  // "completionTime" field.
  int? _completionTime;
  int get completionTime => _completionTime ?? 0;
  set completionTime(int? val) => _completionTime = val;
  void incrementCompletionTime(int amount) =>
      _completionTime = completionTime + amount;
  bool hasCompletionTime() => _completionTime != null;

  // "turnAroundTime" field.
  int? _turnAroundTime;
  int get turnAroundTime => _turnAroundTime ?? 0;
  set turnAroundTime(int? val) => _turnAroundTime = val;
  void incrementTurnAroundTime(int amount) =>
      _turnAroundTime = turnAroundTime + amount;
  bool hasTurnAroundTime() => _turnAroundTime != null;

  // "waitingTime" field.
  int? _waitingTime;
  int get waitingTime => _waitingTime ?? 0;
  set waitingTime(int? val) => _waitingTime = val;
  void incrementWaitingTime(int amount) => _waitingTime = waitingTime + amount;
  bool hasWaitingTime() => _waitingTime != null;

  // "remainingTime" field.
  int? _remainingTime;
  int get remainingTime => _remainingTime ?? 0;
  set remainingTime(int? val) => _remainingTime = val;
  void incrementRemainingTime(int amount) =>
      _remainingTime = remainingTime + amount;
  bool hasRemainingTime() => _remainingTime != null;

  static ProcessStruct fromMap(Map<String, dynamic> data) => ProcessStruct(
        processId: castToType<int>(data['processId']),
        arrivalTime: castToType<int>(data['arrivalTime']),
        burstTime: castToType<int>(data['burstTime']),
        completionTime: castToType<int>(data['completionTime']),
        turnAroundTime: castToType<int>(data['turnAroundTime']),
        waitingTime: castToType<int>(data['waitingTime']),
        remainingTime: castToType<int>(data['remainingTime']),
      );

  static ProcessStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? ProcessStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'processId': _processId,
        'arrivalTime': _arrivalTime,
        'burstTime': _burstTime,
        'completionTime': _completionTime,
        'turnAroundTime': _turnAroundTime,
        'waitingTime': _waitingTime,
        'remainingTime': _remainingTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'processId': serializeParam(
          _processId,
          ParamType.int,
        ),
        'arrivalTime': serializeParam(
          _arrivalTime,
          ParamType.int,
        ),
        'burstTime': serializeParam(
          _burstTime,
          ParamType.int,
        ),
        'completionTime': serializeParam(
          _completionTime,
          ParamType.int,
        ),
        'turnAroundTime': serializeParam(
          _turnAroundTime,
          ParamType.int,
        ),
        'waitingTime': serializeParam(
          _waitingTime,
          ParamType.int,
        ),
        'remainingTime': serializeParam(
          _remainingTime,
          ParamType.int,
        ),
      }.withoutNulls;

  static ProcessStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProcessStruct(
        processId: deserializeParam(
          data['processId'],
          ParamType.int,
          false,
        ),
        arrivalTime: deserializeParam(
          data['arrivalTime'],
          ParamType.int,
          false,
        ),
        burstTime: deserializeParam(
          data['burstTime'],
          ParamType.int,
          false,
        ),
        completionTime: deserializeParam(
          data['completionTime'],
          ParamType.int,
          false,
        ),
        turnAroundTime: deserializeParam(
          data['turnAroundTime'],
          ParamType.int,
          false,
        ),
        waitingTime: deserializeParam(
          data['waitingTime'],
          ParamType.int,
          false,
        ),
        remainingTime: deserializeParam(
          data['remainingTime'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ProcessStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProcessStruct &&
        processId == other.processId &&
        arrivalTime == other.arrivalTime &&
        burstTime == other.burstTime &&
        completionTime == other.completionTime &&
        turnAroundTime == other.turnAroundTime &&
        waitingTime == other.waitingTime &&
        remainingTime == other.remainingTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        processId,
        arrivalTime,
        burstTime,
        completionTime,
        turnAroundTime,
        waitingTime,
        remainingTime
      ]);
}

ProcessStruct createProcessStruct({
  int? processId,
  int? arrivalTime,
  int? burstTime,
  int? completionTime,
  int? turnAroundTime,
  int? waitingTime,
  int? remainingTime,
}) =>
    ProcessStruct(
      processId: processId,
      arrivalTime: arrivalTime,
      burstTime: burstTime,
      completionTime: completionTime,
      turnAroundTime: turnAroundTime,
      waitingTime: waitingTime,
      remainingTime: remainingTime,
    );
