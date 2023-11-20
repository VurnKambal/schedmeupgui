// Automatic FlutterFlow imports
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code

class LRUTable extends StatefulWidget {
  const LRUTable({Key? key, this.width, this.height}) : super(key: key);

  final double? width;
  final double? height;

  @override
  _LRUTableState createState() =>
      _LRUTableState(width: width!, height: height!);
}

class _LRUTableState extends State<LRUTable> {
  _LRUTableState({this.width = 300, this.height = 200}) : super() {
    pageRequestsNotifier = ValueNotifier<List<String>>(pageRequests);

    pageRequestsNotifier.addListener(() {
      setState(() {
        pageRequests = pageRequestsNotifier.value;
      });
    });
  }

  ValueNotifier<List<String>> pageRequestsNotifier = ValueNotifier([]);
  final double width;
  final double height;
  final ScrollController scrollController = ScrollController();
  List<String> pageRequests = FFAppState().pageRequests;

  @override
  Widget build(BuildContext context) {
    List<DataColumn> pageRequestColumns = List<DataColumn>.generate(
      FFAppState().queueHistory[0].length + 1,
      (index) => index == 0
          ? DataColumn(
              label: Text(
                'Page\nRequests',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : DataColumn(
              label: Text(
                'P${FFAppState().pageRequests[index - 1]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );

    List<DataRow> pageRequestRows = List<DataRow>.generate(
      FFAppState().frames,
      (index) => DataRow(cells: [
        DataCell(Text('Frame ${index + 1}')),
        ...FFAppState()
            .queueHistory[index]
            .map((item) => DataCell(Text(item, textAlign: TextAlign.center)))
            .toList(),
      ]),
    );
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: (SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                // Data Table for LRU Page Requests
                child: DataTable(
                    columnSpacing: 8,
                    columns: pageRequestColumns,
                    // Data Rows for LRU Page Requests
                    rows: pageRequestRows)))));
  }
}
