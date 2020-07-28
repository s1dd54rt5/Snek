import 'package:flutter/material.dart';

class Snek extends StatefulWidget {
  @override
  _SnekState createState() => _SnekState();
}

class _SnekState extends State<Snek> {
  static List snakePosition = [22, 42, 62];

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
                    itemCount: 700,
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
        ],
      ),
    );
  }
}
