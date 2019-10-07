import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class SceneFavoriteEditor extends StatefulWidget {
  final List<int> favorite;
  final Workflow workflow;

  const SceneFavoriteEditor({Key key, this.favorite, this.workflow}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SceneFavoriteEditor();
}

class _SceneFavoriteEditor extends State<SceneFavoriteEditor> {
  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text('Scenarios'),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, widget.favorite),
      ),
    );
    List<Widget> _child() {
      return widget.workflow.scenarios.map((scenario) {
        return CheckboxListTile(
          key: Key(scenario.name),
          value: widget.favorite == null ? false : widget.favorite.contains(scenario.id),
          title: Text(scenario.name, style: TextStyle(fontWeight: FontWeight.bold),),
          onChanged: (bool newVal) {
            if (newVal) {
              widget.favorite.add(scenario.id);
            } else {
              widget.favorite.remove(scenario.id);
            }
            setState(() {

            });
          },
        );
      }).toList();
    }

    return Scaffold(
        appBar: _appbar,
        body: ListView(
          children: _child(),
        ));
  }
}
