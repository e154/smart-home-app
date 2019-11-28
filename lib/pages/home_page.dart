import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  UserSettings _userSettings;
  Workflow _workflow;
  List<MapElement> _deviceList;

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final streamBloc = BlocProvider.of<StreamBloc>(context);
    homeBloc.dispatch(HomeFetchSettings());

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading || state is HomeInitial) {
        return _isLoading();
      }
      if (state is HomeLoaded) {
        if (state.userSettings == null) {
        } else {
          _userSettings = state.userSettings;
          if (state.workflow != null) {
            _workflow = state.workflow;
          }
          if (state.deviceList != null) {
            _deviceList = state.deviceList;
          }
        }
      }

      return _showTabs(tabBloc, homeBloc);
    });
  }

  Widget _showSelectWorkflow() {
    return BlocBuilder<WorkflowsBloc, WorkflowsState>(
        builder: (context, state) {
      if (state is LoginSettingsLoaded) {}
      return WorkflowsList();
    });
  }

  Text _workflowName() {
    return _workflow != null
        ? Text(_workflow.name)
        : Text('workflow not selected');
  }

  Widget _showTabs(TabBloc tabBloc, HomeBloc homeBloc) {
    return BlocBuilder<TabBloc, AppTab>(builder: (context, state) {
      if (state is LoginSettingsLoaded) {}
      return Scaffold(
        appBar: AppBar(
          title: _workflowName(),
          actions: <Widget>[
            IconButton(
              tooltip: "select workflow",
              key: ArchSampleKeys.selectWorkflowButton,
              icon: Icon(Icons.settings),
              onPressed: () async {
                final wf = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkflowsList(),
                  ),
                );
                if (wf != null) {
//                  print('workflow selected: $wf');
//                  weatherBloc.dispatch(FetchWeather(city: city));
                  homeBloc.dispatch(HomeSelectWorkflow(wf));
                } else {
                  print('workflow not selected');
                }
              },
            )
          ],
        ),
        body: state == AppTab.favorite
            ? HomeTabFavorite(
                userSettings: _userSettings,
                workflow: _workflow,
                deviceList: _deviceList,
                doAction: (MapDeviceAction action) {
                  homeBloc.dispatch(HomeDoAction(action: action));
                },
              )
            : HomeTabEtc(),
        bottomNavigationBar: HomeTabSelector(
          activeTab: state,
          onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab)),
        ),
        drawer: MainMenu(),
      );
    });
  }

  Widget _isLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
