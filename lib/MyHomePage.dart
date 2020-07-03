import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snakeladder/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomNo = 1;
  bool toAnimate = false;
  int ply1 = 0, ply2 = 0;
  bool plyturn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            plyturn
                ? SizedBox(
                    height: 100,
                    width: 100,
                    child: Icon(
                      Icons.person,
                      color: Colors.amberAccent,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      var randomizer = new Random();
                      setState(() {
                        toAnimate = true;
                        Future.delayed(Duration(seconds: 1)).whenComplete(() {
                          setState(() {
                            randomNo = randomizer.nextInt(6) + 1;
                            print(randomNo);
                            toAnimate = false;
                            ply1 == 0
                                ? randomNo == 1 ? ply1 = randomNo : ply1 = 0
                                : ply1 + randomNo > 100
                                    ? ply1 = ply1
                                    : ply1 = ply1 + randomNo;
                            Future.delayed(Duration(seconds: 1))
                                .whenComplete(() {
                              setState(() {
                                switch (ply1) {
                                  case 17:
                                    ply1 = 6;
                                    break;
                                  case 33:
                                    ply1 = 14;
                                    break;
                                  case 39:
                                    ply1 = 28;
                                    break;
                                  case 54:
                                    ply1 = 46;
                                    break;
                                  case 81:
                                    ply1 = 43;
                                    break;
                                  case 99:
                                    ply1 = 18;
                                    break;

                                  case 84:
                                    ply1 = 95;
                                    break;
                                  case 47:
                                    ply1 = 86;
                                    break;
                                  case 50:
                                    ply1 = 59;
                                    break;
                                  case 2:
                                    ply1 = 43;
                                    break;
                                  default:
                                }
                              });
                            });
                            if (ply1 == 100)
                              showAboutDialog(
                                  context: context,
                                  children: [Text('Player 1 WON!!!')]);
                          });
                          Future.delayed(Duration(milliseconds: 1500))
                              .whenComplete(() {
                            setState(() {
                              plyturn = !plyturn;
                            });
                          });
                        });
                      });
                    },
                    child: SizedBox(
                      // height: 100,
                      // width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              Icons.person,
                              color: Colors.amberAccent,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              child: toAnimate
                                  ? Flare(
                                      animation: '1',
                                    )
                                  : Image.asset('assets/images/$randomNo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      child: GridView.count(
                        crossAxisCount: 10, padding: EdgeInsets.all(2),
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(100, (index) {
                          return new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            margin: EdgeInsets.all(0), borderOnForeground: true,
                            // key: list[index],
                            color: (10 <= index && index <= 19) ||
                                    (30 <= index && index <= 39) ||
                                    (50 <= index && index <= 59) ||
                                    (70 <= index && index <= 79) ||
                                    (90 <= index && index <= 99)
                                ? index.isOdd
                                    ? Color.fromRGBO(220, 200, 109, 1)
                                    : Color.fromRGBO(39, 25, 60, 1)
                                : index.isEven
                                    ? Color.fromRGBO(220, 200, 109, 1)
                                    : Color.fromRGBO(39, 25, 60, 1),
                            child: Hero(
                              tag: ply1 == 100 - index
                                  ? 'ply1'
                                  : ply2 == 100 - index ? 'ply2' : 'None',
                              child: Text(
                                ' ${100 - index}',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/board.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      child: GridView.count(
                        crossAxisCount: 10, padding: EdgeInsets.all(2),
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(100, (index) {
                          return new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            margin: EdgeInsets.all(0), borderOnForeground: true,
                            // key: list[index],
                            color: Color.fromRGBO(255, 255, 255, 0.0),
                            child: Hero(
                              tag: ply1 == 100 - index
                                  ? 'ply1'
                                  : ply2 == 100 - index ? 'ply2' : 'None',
                              child: ply1 == 100 - index
                                  ? ply1 == ply2
                                      ? Center(
                                          child: Icon(
                                            Icons.people,
                                            color: Colors.grey,
                                          ),
                                        )
                                      : Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.amberAccent,
                                          ),
                                        )
                                  : ply2 == 100 - index
                                      ? ply1 == ply2
                                          ? Center(
                                              child: Icon(
                                                Icons.people,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.purpleAccent,
                                              ),
                                            )
                                      : SizedBox(),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !plyturn
                ? SizedBox(
                    height: 100,
                    width: 100,
                    child: Icon(
                      Icons.person,
                      color: Colors.purpleAccent,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      var randomizer =
                          new Random(); // can get a seed as a parameter

                      // Integer between 0 and 100 (0 can be 100 not)
                      setState(() {
                        toAnimate = true;
                        Future.delayed(Duration(seconds: 1)).whenComplete(() {
                          setState(() {
                            randomNo = randomizer.nextInt(6) + 1;
                            print(randomNo);
                            toAnimate = false;
                            ply2 == 0
                                ? randomNo == 1 ? ply2 = randomNo : ply2 = 0
                                : ply2 + randomNo > 100
                                    ? ply2 = ply2
                                    : ply2 = ply2 + randomNo;
                            Future.delayed(Duration(seconds: 1))
                                .whenComplete(() {
                              setState(() {
                                switch (ply2) {
                                  case 17:
                                    ply2 = 6;
                                    break;
                                  case 33:
                                    ply2 = 14;
                                    break;
                                  case 39:
                                    ply2 = 28;
                                    break;
                                  case 54:
                                    ply2 = 46;
                                    break;
                                  case 81:
                                    ply2 = 43;
                                    break;
                                  case 99:
                                    ply2 = 18;
                                    break;

                                  case 84:
                                    ply2 = 95;
                                    break;
                                  case 47:
                                    ply2 = 86;
                                    break;
                                  case 50:
                                    ply2 = 59;
                                    break;
                                  case 2:
                                    ply2 = 43;
                                    break;
                                  default:
                                }
                              });
                            });
                            if (ply2 == 100)
                              showAboutDialog(
                                  context: context,
                                  children: [Text('Player2 WON!!!')]);
                          });
                        });
                        Future.delayed(Duration(milliseconds: 1500))
                            .whenComplete(() {
                          setState(() {
                            plyturn = !plyturn;
                          });
                        });
                      });
                    },
                    child: SizedBox(
                      // height: 100,
                      // width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              Icons.person,
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              child: toAnimate
                                  ? Flare(
                                      animation: '1',
                                    )
                                  : Image.asset('assets/images/$randomNo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Get 1 to start the game for a player'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
