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

  Question({this.email, this.statement, this.correctAnswer, this.incorrectAnswer, this.complexity, this.subject, this.img, this.rating});

  Question.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        statement = json['statement'],
        correctAnswer = json['correctAnswer'],
        incorrectAnswer = json['incorrectAnswer'],
        complexity = json['complexity'],
        subject = json['subject'],
        img = json['img'],
        rating = json['rating'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'statement': statement,
        'correctAnswer': correctAnswer,
        'incorrectAnswer': incorrectAnswer,
        'complexity': complexity,
        'subject': subject,
        'img': img,
        'rating': rating,
      };
}
