import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'globals.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get appTitle => Intl.message(
        'Quiz App',
        name: 'appTitle',
        desc: 'Title of the app',
      );
  
  String get drawerTitle => Intl.message(
        'Menu',
        name: 'drawerTitle',
        desc: 'Title for the drawer widget',
      );

  String get homepage => Intl.message(
        'Homepage',
        name: 'homepage',
        desc: 'Title for the Demo application',
      );
  
  String get language => Intl.message(
        'Language:',
        name: 'language',
        desc: 'Text for language dropdown button',
      );

  String get quizzes => quiz(2);

  String quiz(int howMany) => Intl.plural(
        howMany,
        one: 'Quiz',
        other: 'Quizzes',
        name: 'quiz',
        args: [howMany],
        desc: 'Quiz text',
      );

  String get questions => question(2);

  String question(int howMany) => Intl.plural(
        howMany,
        one: 'Question',
        other: 'Questions',
        name: 'question',
        args: [howMany],
        desc: 'Question text',
      );

  String get startQuiz => Intl.message(
        'Start Quiz!',
        name: 'startQuiz',
        desc: 'Start quiz button text',
      );

  String get goodJob => Intl.message(
        'Good Job!',
        name: 'goodJob',
        desc: 'Good job text',
      );

  String get wrong => Intl.message(
        'Wrong',
        name: 'wrong',
        desc: 'Wrong text',
      );

  String get onward => Intl.message(
        'Onward!',
        name: 'onward',
        desc: 'Continue onward button text',
      );

  String get tryAgain => Intl.message(
        'Try again...',
        name: 'tryAgain',
        desc: 'Try again button text',
      );

  String congratsQuiz(String quizName) => Intl.message(
        'Congrats! You completed "$quizName"!',
        name: 'congratsQuiz',
        args: [quizName],
        examples: const {'quizName': 'Quiz'},
        desc: 'Quiz congratulation message',
      );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
