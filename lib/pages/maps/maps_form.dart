import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/models/models.dart';

import 'maps_bloc.dart';
import 'maps_event.dart';
import 'maps_state.dart';

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
          return ListView.builder(
            itemCount: mapList.length,
            padding: const EdgeInsets.all(6),
            itemBuilder: (BuildContext context, int i) {
              if (i.isOdd) return Divider();
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
