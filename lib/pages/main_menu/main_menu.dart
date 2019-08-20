import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/authentication/authentication.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/pages/about/about.dart';
import 'package:smart_home_app/pages/home/home.dart';
import 'package:smart_home_app/pages/settings/settings.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  User user;

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.dispatch(FetchCurrentUser());

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {}
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            user = state.user;
          }
          if (state is AuthenticationUnauthenticated) {
            user = null;
          }
          Widget _logout() {
            if (user != null) {
              return ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  authenticationBloc.dispatch(LoggedOut());
                },
              );
            } else {
              return Container(
                child: null,
              );
            }
          }

          Widget _header() {
            if (user != null) {
              return UserAccountsDrawerHeader(
                accountName: Text(user.firstName +
                    " " +
                    user.lastName +
                    " <" +
                    user.nickname +
                    ">"),
                accountEmail: Text(user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white
                          : Colors.blue,
                  child: Text(
                    user.nickname.substring(0, 1),
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              );
            } else {
              return DrawerHeader(
                child: Text('Smart home'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              );
            }
          }

          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                _header(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                _logout(),
              ],
            ),
          );
        },
      ),
    );
  }
}
