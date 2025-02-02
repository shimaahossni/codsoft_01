import 'dart:ui';

class Question{
  final String text;
  final List answer;
  final String img;
  Question({required this.text,required this.answer,required this.img});
}


class Answer{
  final String text;
  final bool isCorrect;
  Answer({required this.text, required this.isCorrect});
}

List<Question> questions=[
  Question(text: "what is this amimale", answer: [
    Answer(text: "dog", isCorrect: true),
    Answer(text: "cat", isCorrect: false),
    Answer(text: "rabbit", isCorrect: false),
    Answer(text: "turule", isCorrect: false),
  ], img: 'assets/images/dog.png'),

  Question(text: "what is this amimale", answer: [
    Answer(text: "dog", isCorrect: false),
    Answer(text: "cat", isCorrect: true),
    Answer(text: "rabbit", isCorrect: false),
    Answer(text: "turule", isCorrect: false),
  ], img: 'assets/images/cat.jpg'),

  Question(text: "what is this amimale", answer: [
    Answer(text: "dog", isCorrect: false),
    Answer(text: "cat", isCorrect: false),
    Answer(text: "rabbit", isCorrect: true),
    Answer(text: "turule", isCorrect: false),
  ], img: 'assets/images/rabbit.jpg'),

  Question(text: "what is this amimale", answer: [
    Answer(text: "dog", isCorrect: false),
    Answer(text: "cat", isCorrect: false),
    Answer(text: "rabbit", isCorrect: false),
    Answer(text: "turule", isCorrect: true),
  ], img: 'assets/images/turtle.jpeg'),
];