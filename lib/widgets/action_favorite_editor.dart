import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class ActionFavoriteEditor extends StatefulWidget {
  final List<int> favorite;
  final List<MapElement> actionList;

  const ActionFavoriteEditor({Key key, this.favorite, this.actionList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActionFavoriteEditor();
}

class _ActionFavoriteEditor extends State<ActionFavoriteEditor> {
  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text('Actions'),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, widget.favorite),
      ),
    );
    List<Widget> _child() {
      if (widget.actionList == null) {
        return List<Widget>();
      }

      return widget.actionList.map((device) {
        final title = device.description != '' ? device.description : device.name;
        return CheckboxListTile(
          key: Key(device.name),
          value: widget.favorite == null ? false : widget.favorite.contains(device.id),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          onChanged: (bool newVal) {
            if (newVal) {
              widget.favorite.add(device.id);
            } else {
              widget.favorite.remove(device.id);
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
