import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/home_page.dart';
import '../screens/quiz_list.dart';
import '../screens/view_questions.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 90,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                localizations.drawerTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(localizations.homepage),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.live_help),
            title: Text(localizations.quiz(2)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => QuizzesList()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text(localizations.question(2)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => QuestionList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
