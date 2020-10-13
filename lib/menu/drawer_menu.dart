import 'package:flutter/material.dart';

import '../quiz/pages/make_quiz.dart';
import '../quiz/pages/view_questions.dart';

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MakeQuiz()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Questions'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QuestionList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
