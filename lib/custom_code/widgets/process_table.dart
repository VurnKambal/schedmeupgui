// Automatic FlutterFlow imports
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code

class ProcessTable extends StatefulWidget {
  const ProcessTable({Key? key, this.width, this.height}) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ProcessTableState createState() =>
      _ProcessTableState(width: width!, height: height!);
}

class _ProcessTableState extends State<ProcessTable> {
  _ProcessTableState({this.width = 300, this.height = 200}) : super() {
    processListNotifier = ValueNotifier<List<ProcessStruct>>(processList);

    processListNotifier.addListener(() {
      setState(() {
        processList = processListNotifier.value;
      });
    });
  }

  ValueNotifier<List<ProcessStruct>> processListNotifier = ValueNotifier([]);
  final double width;
  final double height;
  final ScrollController scrollController = ScrollController();
  List<ProcessStruct> processList = FFAppState().oldProcessList;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: (SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: 8,
              columns: const [
                DataColumn(
                  label: Text(
                    'Process\nID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Arrival\nTime',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Burst\nTime',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Turnaround\nTime',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Waiting\nTime',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              rows: processList
                  .map(
                    (process) => DataRow(
                      cells: [
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            process.processId.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            process.arrivalTime.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            process.burstTime.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            process.turnAroundTime.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            process.waitingTime.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        )));
  }
}
