import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Snek extends StatefulWidget {
  @override
  _SnekState createState() => _SnekState();
}

class _SnekState extends State<Snek> {
  int score = 0;
  bool check = false;

  void startGame() {
    score = 0;
    check = false;
    snakePosition = [22, 42, 62];
    const duration = const Duration(milliseconds: 100);
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (gameOver() || check == true) {
        timer.cancel();
        showGameOverScreen();
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content:
                Text('You\'re score: ' + (snakePosition.length - 3).toString()),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    setState(() {
      check = false;
    });
  }

  List snakePosition = [22, 42, 62];

  static var randomNumber = Random();
  int food = randomNumber.nextInt(480);
  void generateNewFood() {
    food = randomNumber.nextInt(480);
  }

  var direction = 'left';

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last + 20 > 480) {
            snakePosition.add(snakePosition.last + 20 - 480);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;

        case 'up':
          if (snakePosition.last - 20 < 0) {
            snakePosition.add(snakePosition.last - 20 + 480);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        case 'right':
          if (snakePosition.last % 20 == 19) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }
      if (snakePosition.last == food) {
        setState(() {
          score = score + 1;
        });
        generateNewFood();
      } else {
        snakePosition.remove(snakePosition.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Text(
              'Snek',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 480,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20),
                    itemBuilder: (BuildContext context, int index) {
                      if (snakePosition.contains(index)) {
                        return Container(
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffef335e),
                              ),
                              width: 5,
                              height: 5,
                            ),
                          ),
                        );
                      }
                      if (index == food) {
                        return Container(
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff5fef33),
                              ),
                              width: 5,
                              height: 5,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff121212),
                              ),
                              width: 5,
                              height: 5,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: Text(
              score.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            children: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    check = false;
                  });
                  startGame();
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Start',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 1,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    check = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Stop',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
