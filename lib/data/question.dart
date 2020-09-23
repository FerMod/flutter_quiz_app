// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable(nullable: false)
class Question {
  //final int id;
  final String email;
  final String statement;
  final String correctAnswer;
  final List<String> incorrectAnswer;
  final int complexity;
  final String subject;
  final String img;
  final int rating;

  Question(
      //this.id,
      this.email,
      this.statement,
      this.correctAnswer,
      this.incorrectAnswer,
      this.complexity,
      this.subject,
      this.img,
      this.rating);

// factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
// Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
