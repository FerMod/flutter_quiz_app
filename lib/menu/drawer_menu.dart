
import 'package:flutter/material.dart';

import '../screens/quiz_list.dart';
import '../screens/view_questions.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
          ListTile(
            leading: Icon(Icons.live_help),
            title: Text('Quiz'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(
                  // MaterialPageRoute(builder: (context) => MakeQuiz()),
                  MaterialPageRoute(builder: (context) => QuizzesList()),
                );
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Questions'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(
                  MaterialPageRoute(builder: (context) => QuestionList()),
                );
            },
          ),
        ],
      ),
    );
  }
}
