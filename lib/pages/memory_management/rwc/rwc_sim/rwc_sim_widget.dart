import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/custom_code/widgets/memory_animated_list_rwc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'rwc_sim_model.dart';
export 'rwc_sim_model.dart';

class RwcSimWidget extends StatefulWidget {
  const RwcSimWidget({Key? key}) : super(key: key);

  @override
  _RwcSimWidgetState createState() => _RwcSimWidgetState();
}

class _RwcSimWidgetState extends State<RwcSimWidget> {
  late RwcSimModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<MemoryAnimatedListRWCState> memoryListKey =
      GlobalKey<MemoryAnimatedListRWCState>();
  MemoryAnimatedListRWC memoryRWCAnimatedList = MemoryAnimatedListRWC();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RwcSimModel());
    memoryRWCAnimatedList = MemoryAnimatedListRWC(
      key: memoryListKey,
      width: 280.0,
      height: 250.0,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  width: 500.0,
                  height: 120.0,
                  decoration: BoxDecoration(),
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.00, -0.70),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              'Relocation with\nCompaction',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF313131),
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.50),
                child: SingleChildScrollView(
                  child: memoryRWCAnimatedList,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.00, 1.00),
                  child: Container(
                    width: 742.0,
                    height: 333.0,
                    margin: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.40),
                          child: custom_widgets.RWCTable(
                            width: 400.0,
                            height: 200.0,
                          ),
                        ),
                        // Text with padding of 16,0,16,0 and font size 16
                        Text(
                          'External Fragmentation: ${FFAppState().externalFragmentation}',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 16.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            print('Button pressed ...');
                                            FFAppState().update(() {
                                              FFAppState().isSimulating = true;
                                            });
                                            await memoryListKey.currentState!
                                                .startRWC(
                                                    memoryListKey,
                                                    FFAppState().memorySize,
                                                    FFAppState().jobSizes);
                                            print('${FFAppState().jobSizes}');
                                            print('${FFAppState().memorySize}');
                                          },
                                          text: 'Start',
                                          options: FFButtonOptions(
                                            width: 171.0,
                                            height: 55.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF313131),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            hoverColor: Colors.white,
                                            hoverBorderSide: BorderSide(
                                              color: Color(0xFF878787),
                                            ),
                                            hoverTextColor: Color(0xFF313131),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 8.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            memoryListKey.currentState!
                                                .generateRandomBlocks(
                                                    memoryListKey);
                                          },
                                          text: 'Generate',
                                          options: FFButtonOptions(
                                            width: 171.0,
                                            height: 55.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF313131),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            hoverColor: Colors.white,
                                            hoverBorderSide: BorderSide(
                                              color: Color(0xFF878787),
                                            ),
                                            hoverTextColor: Color(0xFF313131),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            // Stop Simulation
                                            FFAppState().update(() {
                                              FFAppState().isSimulating = false;
                                            });
                                            context.pushNamed('optselectPage');
                                          },
                                          text: 'Exit',
                                          options: FFButtonOptions(
                                            width: 171.0,
                                            height: 55.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF313131),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            hoverColor: Colors.white,
                                            hoverBorderSide: BorderSide(
                                              color: Color(0xFF878787),
                                            ),
                                            hoverTextColor: Color(0xFF313131),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
