import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz_app/data/question.dart';

void main() {
  test('JsonSerializable', () {
    final question = Question('Correo123@ikasle.ehu.eus', 'Statement?', 'Right',
        ['Wrong_01', 'Wrong_02', 'Wrong_03'], 0, "Test Subject", "img", 0);

    final questionJson = _encode(question);

    final question2 =
        Question.fromJson(json.decode(questionJson) as Map<String, dynamic>);

    expect(question.email, question2.email);
    expect(question.statement, question2.statement);
    expect(question.correctAnswer, question2.correctAnswer);
    expect(question.incorrectAnswer, question2.incorrectAnswer);
    expect(question.complexity, question2.complexity);
    expect(question.subject, question2.subject);
    expect(question.img, question2.img);
    expect(question.rating, question2.rating);

    expect(_encode(question2), equals(questionJson));
  });
}

String _encode(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);
