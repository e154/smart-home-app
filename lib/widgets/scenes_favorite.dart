import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/scenes_favorite_editor.dart';

import 'button_scenarios.dart';

class ScenesFavorite extends StatelessWidget {
  final List<int> favorite;
  final Workflow workflow;

  const ScenesFavorite({Key key, this.favorite, this.workflow})
      : super(key: key);

  List<Widget> _buttonBuilder(HomeBloc homeBloc, List<WorkflowScenario> _scenarioList) {
    List<Widget> items = new List<Widget>();
    if (favorite == null || favorite.length == 0) {
      items.add(Container(
        child: Center(
          child: Text('Long press to add item'),
        ),
      ));
    } else {
      if (workflow != null) {
        _scenarioList.forEach((scenario) {
          if (favorite.contains(scenario.id)) {
            //TODO fix active state
            final newItem = ButtonScenarios(
                function: () {
                  print("Container clicked: " + scenario.id.toString());
                  homeBloc.dispatch(HomeSelectScenario(
                      workflowId: workflow.id, scenarioId: scenario.id));
                },
                name: scenario.name,
                active: false);
            items.add(newItem);
          }
        });
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    List<WorkflowScenario> _scenarioList = workflow.scenarios;

    final homeBloc = BlocProvider.of<HomeBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double itemHeight = screenWidth / 3 - 7;
    itemHeight = (itemHeight > 120) ? 120 : itemHeight;
//    print('itemHeight $itemHeight');

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoadedScenarios) {
        if (state.scenarios != null) {
          _scenarioList = state.scenarios;
        }
      }

      return _container(itemHeight, context, homeBloc, _scenarioList);
    });
  }

  Widget _container(
      double itemHeight, BuildContext context, HomeBloc homeBloc, List<WorkflowScenario> _scenarioList) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 0, left: 5, right: 5),
      height: itemHeight + 20,
//      color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 20,
            child: Text(
              'Scenarios',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          new Expanded(
            child: new GestureDetector(
              onLongPressEnd: (LongPressEndDetails details) {
//                print("long press end");
                () async {
                  final scenarios = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SceneFavoriteEditor(
                        favorite: favorite,
                        workflow: workflow,
                      ),
                    ),
                  );
                  if (scenarios != null) {
//                    print('selected scenarios');
                    homeBloc
                        .dispatch(HomeUpdateFavoriteScenarioList(scenarios));
                  } else {
//                    print('scenarios not selected');
                  }
                }();
              },
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                crossAxisCount: 1,
                children: _buttonBuilder(homeBloc, _scenarioList),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
