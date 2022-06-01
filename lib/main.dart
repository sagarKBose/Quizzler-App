import 'package:flutter/material.dart';
import 'package:quizzler_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> skoreKeeper = [];
  int right = 0;
  int wrong = 0;
  void checkAnswer(bool userAnswer) {
    bool correctAns = quizBrain.getCorrectAns();
    setState(
      () {
        if (quizBrain.isFinished() == true) {
          int totalScore = right + 1;
          Alert(
                  context: context,
                  title: "Congratulations!",
                  desc:
                      "You finished the Game.\nYour score is $totalScore.\nYou got $wrong wrong answers!")
              .show();
          quizBrain.reset();
          skoreKeeper = [];
          right = 0;
          wrong = 0;
        } else {
          if (userAnswer == correctAns) {
            skoreKeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              ),
            );
            right++;
          } else {
            skoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
            wrong++;
          }
          quizBrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(children: skoreKeeper),
      ],
    );
  }
}
