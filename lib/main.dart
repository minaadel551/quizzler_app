import 'package:flutter/material.dart';
import 'queiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Icon> scoreKeeper = [];

  Quiz_brain quizBrain = Quiz_brain();

  void userAnswer(bool trueAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();


        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (trueAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlatButton(
                      child: Text(
                        'True',
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        userAnswer(true);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlatButton(
                      child: Text(
                        'False',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        userAnswer(false);
                      },
                    ),
                  ),
                ),
                Row(
                  children: scoreKeeper,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
