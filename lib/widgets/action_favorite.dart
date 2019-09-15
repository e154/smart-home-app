import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/action_favorite_editor.dart';

import 'button_actions.dart';

class DevicesFavorite extends StatelessWidget {
  final List<int> favorite;
  final List<MapElement> actionList;

  const DevicesFavorite({Key key, this.favorite, this.actionList})
      : super(key: key);

  List<Widget> _buttonBuilder() {
    List<Widget> items = new List<Widget>();
    if (favorite == null || favorite.length == 0) {
      items.add(Container(
        child: Center(
          child: Text('Long press to add item'),
        ),
      ));
    } else {
      if (actionList != null) {
        actionList.forEach((action) {
          if (favorite.contains(action.id)) {
            final newItem = ButtonActions(
                function: () {
                  print("Container clicked: " + action.id.toString());
                },
                name: action.description,
                active: action.id == 1);
            items.add(newItem);
          }
        });
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
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
            new Expanded(
              child: new GestureDetector(
                onLongPressEnd: (LongPressEndDetails details) {
                  print("long press end");
                  () async {
                    final actions = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActionFavoriteEditor(
                          favorite: favorite,
                          actionList: actionList,
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
                  primary: false,
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
      ),
    );
  }
}
