import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/action_favorite.dart';
import 'package:smart_home_app/widgets/scenes_favorite.dart';

class HomeTabFavorite extends StatefulWidget {
  UserSettings _userSettings;
  Workflow _workflow;
  List<MapElement> _deviceList;

  HomeTabFavorite(this._userSettings, this._workflow, this._deviceList);

  @override
  State<HomeTabFavorite> createState() =>
      _HomeTabFavorite(_userSettings, _workflow, _deviceList);
}

class _HomeTabFavorite extends State<HomeTabFavorite> {
  UserSettings _userSettings;
  Workflow _workflow;
  List<MapElement> _deviceList;

  _HomeTabFavorite(this._userSettings, this._workflow, this._deviceList);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
//    homeBloc.dispatch(HomeFetchSettings());
    if (_userSettings == null) {
      return Container(
        child: Center(
          child: Text('please select workflow'),
        ),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          ScenesFavorite(
            favorite: _userSettings.scenarios,
            workflow: _workflow,
          ),
          ActionsFavorite(
            favorite: _userSettings.actions,
            actionList: _deviceList,
          ),
        ],
      ),
    );
  }
}
