import 'package:flutter/material.dart';

enum CheckStatus { ok, error, inProcess }

class CheckIconWidget extends StatelessWidget {
  final CheckStatus status;

  CheckIconWidget(this.status);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CheckStatus.ok:
        return Icon(
          Icons.check,
          color: Colors.green,
        );
        break;
      case CheckStatus.error:
        return Icon(
          Icons.close,
          color: Colors.red,
        );
      default:
        return Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                height: 20.0,
                width: 20.0,
              )
            ],
          ),
        );
    }
  }
}
