/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/action_favorite_editor.dart';
import 'package:smart_home_app/widgets/action_vertical_menu.dart';

import 'button_actions.dart';

class ActionsFavorite extends StatefulWidget {
  final List<int> favorite;
  final List<MapElement> actionList;
  final Function doAction;

  const ActionsFavorite(
      {Key key, this.favorite, this.actionList, this.doAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActionsFavorite();
}

class _ActionsFavorite extends State<ActionsFavorite> {
  ActionVerticalMenu _actionVerticalMenu;

  @override
  void initState() {
    super.initState();
    _actionVerticalMenu = ActionVerticalMenu(widget.doAction);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _buttonBuilder() {
    List<Widget> items = new List<Widget>();
    if (widget.favorite == null || widget.favorite.length == 0) {
      items.add(Container(
        child: Center(
          child: Text('Long press to add item'),
        ),
      ));
    } else {
      if (widget.actionList != null) {
        widget.actionList.forEach((element) {
          if (widget.favorite.contains(element.id)) {
            final newItem = ButtonActions(
                key: Key('button_action_id' + element.id.toString()),
                onPressed:
                    (BuildContext context, List<MapDeviceAction> actions) {
                  if (actions.length > 0) {
                    _actionVerticalMenu.show(
                        context: context, actions: actions);
                  }
                },
                element: element,
                active: element.id == 1);
            items.add(newItem);
          }
        });
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final streamBloc = BlocProvider.of<StreamBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    streamBloc.dispatch(StreamGetDevicesStates());
    streamBloc.dispatch(StreamGetWorkflowStates());

    return Container(
//        color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: <Widget>[
          Container(
//              color: Colors.blue,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 20,
            child: Text(
              'Actions',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          new ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200, // Set as you want or you can remove it also.
              maxHeight: double.infinity,
            ),
            child: new GestureDetector(
              onLongPressEnd: (LongPressEndDetails details) {
                print("long press end");
                () async {
                  final actions = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActionFavoriteEditor(
                        favorite: widget.favorite,
                        actionList: widget.actionList,
                      ),
                    ),
                  );
                  if (actions != null) {
//                    print('selected actions');
                    homeBloc.dispatch(HomeUpdateFavoriteActionList(actions));
                  } else {
//                    print('scenarios not selected');
                  }
                }();
              },
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                children: _buttonBuilder(),
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
