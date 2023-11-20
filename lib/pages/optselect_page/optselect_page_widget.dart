import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'optselect_page_model.dart';
export 'optselect_page_model.dart';

class OptselectPageWidget extends StatefulWidget {
  const OptselectPageWidget({Key? key}) : super(key: key);

  @override
  _OptselectPageWidgetState createState() => _OptselectPageWidgetState();
}

class _OptselectPageWidgetState extends State<OptselectPageWidget> {
  late OptselectPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptselectPageModel());
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
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, -0.54),
                child: Text(
                  'Choose scheduling method',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF313131),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.3),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('rwcPage');
                  },
                  text: 'Relocation With Compaction',
                  options: FFButtonOptions(
                    width: 312.0,
                    height: 74.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF313131),
                    textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: Colors.white,
                    hoverBorderSide: BorderSide(
                      color: Color(0xFF878787),
                      width: 1.0,
                    ),
                    hoverTextColor: Color(0xFF313131),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.01),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('lruPage');
                  },
                  text: 'PRP: Least Recently Used',
                  options: FFButtonOptions(
                    width: 312.0,
                    height: 74.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF313131),
                    textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: Colors.white,
                    hoverBorderSide: BorderSide(
                      color: Color(0xFF878787),
                      width: 1.0,
                    ),
                    hoverTextColor: Color(0xFF313131),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.28),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('sjnPage');
                  },
                  text: 'Non-Preemptive: Shortest Job Next',
                  options: FFButtonOptions(
                    width: 312.0,
                    height: 74.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF313131),
                    textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: Colors.white,
                    hoverBorderSide: BorderSide(
                      color: Color(0xFF878787),
                      width: 1.0,
                    ),
                    hoverTextColor: Color(0xFF313131),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.57),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('srtfPage');
                  },
                  text: 'Preemptive: Shortest Remaining Time First',
                  options: FFButtonOptions(
                    width: 312.0,
                    height: 74.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF313131),
                    textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: Colors.white,
                    hoverBorderSide: BorderSide(
                      color: Color(0xFF878787),
                      width: 1.0,
                    ),
                    hoverTextColor: Color(0xFF313131),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.91, -0.97),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('mainPage');
                  },
                  text: 'Back',
                  icon: FaIcon(
                    FontAwesomeIcons.angleLeft,
                  ),
                  options: FFButtonOptions(
                    width: 85.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF313131),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: Colors.white,
                    hoverBorderSide: BorderSide(
                      color: Color(0xFF878787),
                      width: 1.0,
                    ),
                    hoverTextColor: Color(0xFF313131),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
