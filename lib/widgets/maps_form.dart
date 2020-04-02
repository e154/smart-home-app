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

class MapsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapsFormState();
}

class _MapsFormState extends State<MapsForm> {
  List<MapShort> mapList;

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<MapsBloc>(context);
    settingsBloc.dispatch(FetchMapList());

    return BlocListener<MapsBloc, MapsState>(
      listener: (context, state) {
        if (state is MapListLoaded) {
          mapList = state.mapList;
        }
        if (state is MapsFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<MapsBloc, MapsState>(builder: (context, state) {
        if (state is MapListLoaded) {
          if (ListView == null) {
            return Container(
              child: Center(
                child: Text("No maps"),
              ),
            );
          }
          return ListView.builder(
            itemCount: mapList.length,
            padding: const EdgeInsets.all(6),
            itemBuilder: (BuildContext context, int i) {
              //if (i.isOdd) return Divider();
              final index = i ~/ 2 + 1;
              return _buildRow(index, mapList[i]);
            },
          );
        }

        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  Widget _buildRow(int index, MapShort mapElement) {
    return ListTile(
      title: Text(mapElement.name),
      subtitle: Text(mapElement.description),
      onTap: () => print(mapElement.toString()),
    );
  }
}
