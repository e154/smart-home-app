import 'package:flutter/material.dart';

class CheckIconWidget extends StatelessWidget {
  final bool _valid;

  CheckIconWidget(this._valid);

  @override
  Widget build(BuildContext context) {

    if (_valid) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.close,
        color: Colors.red,
      );
    }
  }
}
