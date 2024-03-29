// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(quizName) => "Congrats! You completed \"${quizName}\"!";

  static m1(howMany) => "${Intl.plural(howMany, one: 'Question', other: 'Questions')}";

  static m2(howMany) => "${Intl.plural(howMany, one: 'Quiz', other: 'Quizzes')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("Quiz App"),
    "congratsQuiz" : m0,
    "drawerTitle" : MessageLookupByLibrary.simpleMessage("Menu"),
    "goodJob" : MessageLookupByLibrary.simpleMessage("Good Job!"),
    "homepage" : MessageLookupByLibrary.simpleMessage("Homepage"),
    "language" : MessageLookupByLibrary.simpleMessage("Language:"),
    "onward" : MessageLookupByLibrary.simpleMessage("Onward!"),
    "question" : m1,
    "quiz" : m2,
    "startQuiz" : MessageLookupByLibrary.simpleMessage("Start Quiz!"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Try again..."),
    "wrong" : MessageLookupByLibrary.simpleMessage("Wrong")
  };
}
