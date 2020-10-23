import 'package:flutter/material.dart';

import '../app_localizations.dart';
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
            height: 100,
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
            leading: Icon(Icons.live_help),
            title: Text(localizations.quizzes),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => QuizzesList()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text(localizations.questions),
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
