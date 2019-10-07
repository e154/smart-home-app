import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/action_favorite.dart';
import 'package:smart_home_app/widgets/scenes_favorite.dart';

class HomeTabFavorite extends StatefulWidget {
  final UserSettings userSettings;
  final Workflow workflow;
  final List<MapElement> deviceList;
  final Function doAction;

  HomeTabFavorite(
      {Key key,
      this.userSettings,
      this.workflow,
      this.deviceList,
      this.doAction});

  @override
  State<HomeTabFavorite> createState() => _HomeTabFavorite();
}

class _HomeTabFavorite extends State<HomeTabFavorite> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
//    homeBloc.dispatch(HomeFetchSettings());
    if (widget.userSettings == null) {
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
            favorite: widget.userSettings.scenarios,
            workflow: widget.workflow,
          ),
          ActionsFavorite(
            favorite: widget.userSettings.actions,
            actionList: widget.deviceList,
            doAction: widget.doAction,
          ),
        ],
      ),
    );
  }
}
