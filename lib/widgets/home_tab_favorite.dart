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
      child: ListView(
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
