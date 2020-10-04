class Option {
  String value;
  bool correct;

  Option({this.value, this.correct = false});

  Option.fromMap(Map data) {
    value = data['value'] ?? '';
    correct = data['correct'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'correct': correct,
    };
  }
}

class Question {
  int id;
  String text;
  // String image;
  int difficulty;
  int rating;
  String subject;
  List<Option> options;

  Question({this.id, this.text, this.difficulty, this.rating, this.subject, this.options});

  Question.fromMap(Map data) {
    id = data['id'] ?? 0; //TODO: Auto generate id
    text = data['text'] ?? '';
    difficulty = data['difficulty'] ?? 0;
    rating = data['rating'] ?? 0;
    subject = data['subject'] ?? '';
    options = (data['options'] as List ?? []).map((v) => Option.fromMap(v)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'difficulty': difficulty,
      'rating': rating,
      'subject': subject,
      'options': options,
    };
  }
}

/*
// Question fields //
id
email
statement
options -> ( option1 , option2, ...)
complexity
subject
img
rating
*/
