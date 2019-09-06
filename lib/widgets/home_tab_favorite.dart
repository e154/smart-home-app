import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/scenes_favorite.dart';

class HomeTabFavorite extends StatefulWidget {
  UserSettings _userSettings;
  Workflow _workflow;

  HomeTabFavorite(this._userSettings, this._workflow);

  @override
  State<HomeTabFavorite> createState() => _HomeTabFavorite(_userSettings, _workflow);
}

class _HomeTabFavorite extends State<HomeTabFavorite> {
  UserSettings _userSettings;
  Workflow _workflow;

  _HomeTabFavorite(this._userSettings, this._workflow);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
//    homeBloc.dispatch(HomeFetchSettings());
    print(_userSettings);
    return Container (
      child: ScenesFavorite(favorite: _userSettings.scenarios, workflow: _workflow,),
    );
  }
}
