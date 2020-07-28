import 'dart:async';
import 'package:flutter/material.dart';

class Snek extends StatefulWidget {
  @override
  _SnekState createState() => _SnekState();
}

class _SnekState extends State<Snek> {
  void startGame() {
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
    });
  }

  List snakePosition = [22, 42, 62];

  var direction = 'right';

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last + 20 > 760) {
            snakePosition.add(snakePosition.last + 20 - 760);
            snakePosition.remove(snakePosition.first);
          } else {
            snakePosition.add(snakePosition.last + 20);
            snakePosition.remove(snakePosition.first);
          }
          break;

        case 'up':
          if (snakePosition.last - 20 < 0) {
            snakePosition.add(snakePosition.last - 20 + 760);
            snakePosition.remove(snakePosition.first);
          } else {
            snakePosition.add(snakePosition.last - 20);
            snakePosition.remove(snakePosition.first);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
            snakePosition.remove(snakePosition.first);
          } else {
            snakePosition.add(snakePosition.last - 1);
            snakePosition.remove(snakePosition.first);
          }
          break;

        case 'right':
          if (snakePosition.last % 20 == 19) {
            snakePosition.add(snakePosition.last + 1 - 20);
            snakePosition.remove(snakePosition.first);
          } else {
            snakePosition.add(snakePosition.last + 1);
            snakePosition.remove(snakePosition.first);
          }
          break;

        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 760,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20),
                    itemBuilder: (BuildContext context, int index) {
                      if (snakePosition.contains(index)) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffef335e),
                          ),
                          margin: EdgeInsets.all(1),
                          width: 5,
                          height: 5,
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff121212),
                          ),
                          margin: EdgeInsets.all(1),
                          width: 5,
                          height: 5,
                        );
                      }
                    }),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              startGame();
            },
            child: Container(
              child: Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
