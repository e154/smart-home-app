import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/stream/stream_bloc.dart';
import 'package:smart_home_app/models/dashboard_telemetry.dart';
import 'package:smart_home_app/models/workflow_scenario.dart';

class ButtonScenarios extends StatefulWidget {
  Function function;
  bool active;
  WorkflowScenario scenario;
  int workflowId;

  ButtonScenarios(
      {Key key, this.function, this.active, this.scenario, this.workflowId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonScenarios();
}

class _ButtonScenarios extends State<ButtonScenarios> {
  _ButtonScenarios();

//  double _width = 120;
//  double _height = 120;
  double _padding = 5;
  double _squareScale = 1;
  StreamSubscription streamBlocListener;

  _onTapDown(TapDownDetails details) {
    setState(() {
//      _width = 110;
//      _height = 110;
//      _padding = 10;
      _squareScale = 0.95;
    });
  }

  _onTapCancel() {
    setState(() {
//      _width = 120;
//      _height = 120;
//      _padding = 5;
      _squareScale = 1;
    });
  }

  _onTapUp(TapUpDetails details) {
    _onTapCancel();
    widget.function();
  }

  @override
  void dispose() {
    super.dispose();
    streamBlocListener.cancel();
  }

  _streamListener(dynamic data) {
    if (data is DashboardTelemetry) {
      if (data.workflow == null) {
        return;
      }
      data.workflow.status.forEach((k, v) {
        if (widget.workflowId != k) {
          return;
        }
//        print("wf ${widget.workflowId}, scenario ${widget.scenario.id}, ok ${widget.active}");
        setState(() {
          widget.active = v.scenarioId == widget.scenario.id;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final streamBloc = BlocProvider.of<StreamBloc>(context);
    if (streamBlocListener == null) {
      streamBlocListener =
          streamBloc.streamController.stream.listen(_streamListener);
    }

    return new GestureDetector(
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        onTapUp: _onTapUp,
        child: Container(
//          constraints: BoxConstraints.expand(width: 130, height: 130),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(_padding),
            child: Transform.scale(
              scale: _squareScale,
              child: Container(
                  decoration: new BoxDecoration(
                    color: widget.active
                        ? Color.fromRGBO(43, 152, 240, 1)
                        : Color.fromRGBO(234, 235, 235, 1),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(12.0)),
//                boxShadow: [
//                  new BoxShadow(
//                    blurRadius: 3,
//                    color: active ? Colors.green : Colors.grey,
//                    spreadRadius: 0,
//                    offset: new Offset(3, 3),
//                  )
//                ],
                  ),
//                  constraints: BoxConstraints.expand(width: _width, height: _height),
                  child: Container(
                    padding: EdgeInsets.all(_padding),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.scenario.name,
                          style: TextStyle(
                              color: widget.active
                                  ? Colors.white
                                  : Color.fromRGBO(97, 97, 97, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  )),
            ),
          ),
        ));
    ;
  }
}
