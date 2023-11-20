// Automatic FlutterFlow imports
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code

class RWCTable extends StatefulWidget {
  const RWCTable({Key? key, this.width, this.height}) : super(key: key);

  final double? width;
  final double? height;

  @override
  _RWCTableState createState() =>
      _RWCTableState(width: width!, height: height!);
}

class _RWCTableState extends State<RWCTable> {
  _RWCTableState({this.width = 300, this.height = 200}) : super() {
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
    List<DataColumn> pageRequestColumns = const [
      DataColumn(
        label: Text(
          'Jobs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      DataColumn(
        label: Text(
          'Memory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ];
    List<DataRow> pageRequestRows = List<DataRow>.generate(
      FFAppState().jobSizes.length,
      (index) => DataRow(cells: [
        DataCell(Text('Job ${index + 1}')),
        DataCell(Text("${FFAppState().jobSizes[index]}"))
      ]),
    );
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: (SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                // Data Table for RWC Page Requests
                child: DataTable(
                    columnSpacing: 8,
                    columns: pageRequestColumns,
                    // Data Rows for RWC Page Requests
                    rows: pageRequestRows)))));
  }
}
