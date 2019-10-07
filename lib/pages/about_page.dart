import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../constants.dart';


class AboutPage extends StatelessWidget {
  AboutPage();

  // These tiles are also used as drawer nav items in home route.
  static final List<Widget> kAboutListTiles = <Widget>[
    ListTile(
      title: Text(APP_DESCRIPTION),
    ),
    Divider(),
    ListTile(
      leading: Icon(Icons.code),
      title: Text('Source code on GitHub'),
      onTap: () => url_launcher.launch(GITHUB_URL),
    ),
    ListTile(
      leading: Icon(Icons.bug_report),
      title: Text('Report issue on GitHub'),
      onTap: () => url_launcher.launch('$GITHUB_URL/issues'),
    ),
    ListTile(
      leading: Icon(Icons.open_in_new),
      title: Text('Visit website'),
      onTap: () => url_launcher.launch(WEBSITE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final header = ListTile(
      leading: kAppIcon,
      title: Text(APP_NAME),
      subtitle: Text(APP_VERSION),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: kAppIcon,
              children: <Widget>[Text(APP_DESCRIPTION)]);
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: ListView(
        children: <Widget>[
          header,
          ...kAboutListTiles,
        ],
      ),
    );
  }
}
