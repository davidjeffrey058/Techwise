import 'dart:math';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

bool isDisabled = false;
bool resultShown = false;
int result = 0;
int counter = 0;
int correct = 0;
String message = '';
Color? answerTextColor;

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              children: [
                roundContainer(Theme.of(context).primaryColor, counter),
                SizedBox(width: 10,),
                roundContainer(Colors.green, correct),
                SizedBox(width: 10,),
                roundContainer(Colors.red, counter - correct),
              ],
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose An Option',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              resultShown
                  ? Text(
                      answer(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: answerTextColor),
                    )
                  : Container(
                      width: 0,
                    ),
              SizedBox(
                height: resultShown ? 30 : 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  optionButton(
                      bottomColor: Color(0xff229704),
                      topColor: Color(0xffB7FFC1),
                      text: 'Home',
                      value: 1),
                  optionButton(
                      bottomColor: Color(0xff979704),
                      topColor: Color(0xffFFFFB7),
                      text: 'Draw',
                      value: 2),
                  optionButton(
                      topColor: Color(0xffFFB7B7),
                      bottomColor: Color(0xff970404),
                      text: 'Away',
                      value: 3)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              !resultShown
                  ? Container(
                      width: 0,
                    )
                  : Text(
                      message,
                      style: TextStyle(fontSize: 20),
                    )
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter < 1
            ? null
            : () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Results'),
                        children: [
                          Text('Number of Guess: ${counter}'),
                          Text('Number of Correct Guess: ${correct}'),
                          Text(
                              'Number of Incorrect Guess: ${counter - correct}'),
                          Text(
                              'Win percentage: ${((correct / counter) * 100).round()}%'),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    counter = 0;
                                    correct = 0;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('End'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Continue'),
                              )
                            ],
                          )
                        ],
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      );
                    });
              },
        tooltip: 'End',
        child: Icon(Icons.stop),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  optionButton(
      {required Color bottomColor,
      required Color topColor,
      required String text,
      required int value}) {
    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              result = Random().nextInt(3) + 1;
              if (result == value) {
                correct++;
                message = 'Correct guess';
              } else {
                message = 'You suck at guessing';
              }
              setState(() {
                counter++;
                isDisabled = true;
                resultShown = true;
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  isDisabled = false;
                  resultShown = false;
                });
              });
            },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              isDisabled ? Color(0xff787878) : bottomColor,
              isDisabled ? Color(0xffF1F1F1) : topColor,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  answer() {
    switch (result) {
      case 1:
        answerTextColor = Colors.green;
        return 'Home';
      case 2:
        answerTextColor = Colors.yellow;
        return 'Draw';
      case 3:
        answerTextColor = Colors.red;
        return 'Away';
    }
  }

  roundContainer(color, int value){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Text(
        '$value',
        style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
