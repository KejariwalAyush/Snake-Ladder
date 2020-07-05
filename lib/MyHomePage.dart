import 'dart:io';
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
  Color ply1Color = Colors.amberAccent;
  Color ply2Color = Colors.greenAccent;
  int randomNo = 1;
  bool toAnimate = false;
  int ply1 = 0, ply2 = 0;
  bool plyturn = true;
  bool isComputer = false;

  int order(int n) {
    if (n <= 10)
      return 11 - n;
    else if (n <= 30 && n > 20)
      return 31 - n + 20;
    else if (n <= 50 && n > 40)
      return 51 - n + 40;
    else if (n <= 70 && n > 60)
      return 71 - n + 60;
    else if (n <= 90 && n > 80)
      return 91 - n + 80;
    else
      return n;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              plyturn
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: ply1Color,
                          ),
                          Text(
                            isComputer ? 'Computer' : 'Player 1',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : isComputer
                      ? SizedBox(
                          // height: 100,
                          // width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Icon(
                                  Icons.person,
                                  color: ply1Color,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 150,
                                  child: toAnimate
                                      ? Flare(
                                          animation: '1',
                                        )
                                      : Image.asset(
                                          'assets/images/$randomNo.png'),
                                ),
                              ),
                            ],
                          ),
                        )
                      : player1(context),
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.width > 500
                      ? 500
                      : MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width > 500
                      ? 500
                      : MediaQuery.of(context).size.width,
                  // width: MediaQuery.of(context).size.width,
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
                                margin: EdgeInsets.all(0),
                                borderOnForeground: true,
                                // key: list[index],
                                color: ply1 == 100 - index ||
                                        ply2 == 100 - index
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : (10 <= index && index <= 19) ||
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
                                child: Text(
                                  ' ${order(100 - index)}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              );
                            }),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/custom.png',
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
                                margin: EdgeInsets.all(0),
                                borderOnForeground: true,
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
                                                color: ply1Color,
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
                                                    color: ply2Color,
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
              ),
              !plyturn
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: ply2Color,
                          ),
                          Text(
                            'Player 2',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : player2(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Get 1 to start the game for a player'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  InkWell player2(BuildContext context) {
    return InkWell(
      onTap: () {
        var randomizer = new Random(); // can get a seed as a parameter

        // Integer between 0 and 100 (0 can be 100 not)
        setState(() {
          toAnimate = true;
          Future.delayed(Duration(seconds: 1)).whenComplete(() {
            setState(() {
              randomNo = randomizer.nextInt(6) + 1;
              print(randomNo);
              toAnimate = false;
              ply2 == 0
                  ? randomNo == 1 ? ply2 = order(randomNo) : ply2 = 0
                  : ply2 + randomNo > 100
                      ? ply2 = ply2
                      : ply2 = order(order(ply2) + randomNo);
              Future.delayed(Duration(seconds: 1)).whenComplete(() {
                setState(() {
                  ply2 = snakeLadderCmd(ply2);
                });
              });
              if (ply2 == 100)
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: new Text("Snakes & Ladders"),
                          content: new Text(
                              "Player 2 WON !!!\nDo you want to Restart ?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                setState(() {
                                  ply1 = 0;
                                  ply2 = 0;
                                });
                                Navigator.of(context).pop();
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           new MyHomePage()),
                                // );
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
            });
          });
          Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
            setState(() {
              plyturn = !plyturn;
              if (isComputer) {
                toAnimate = true;
                Future.delayed(Duration(seconds: 1)).whenComplete(() {
                  setState(() {
                    randomNo = randomizer.nextInt(6) + 1;
                    print(randomNo);
                    toAnimate = false;
                    ply1 == 0
                        ? randomNo == 1 ? ply1 = order(randomNo) : ply1 = 0
                        : ply1 + randomNo > 100
                            ? ply1 = ply1
                            : ply1 = order(order(ply1) + randomNo);
                    Future.delayed(Duration(seconds: 1)).whenComplete(() {
                      setState(() {
                        ply1 = snakeLadderCmd(ply1);
                      });
                    });
                    if (ply1 == 100)
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                title: new Text("Snakes & Ladders"),
                                content: new Text(
                                    "Computer WON !!!\nDo you want to Restart ?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      setState(() {
                                        ply1 = 0;
                                        ply2 = 0;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                  });
                  Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
                    setState(() {
                      plyturn = !plyturn;
                    });
                  });
                });
              }
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
                color: ply2Color,
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
    );
  }

  int snakeLadderCmd(int ply) {
    switch (ply) {
      // Snakes
      case 99:
        ply = 66;
        break;
      case 95:
        ply = 72;
        break;
      case 79:
        ply = 49;
        break;
      case 68:
        ply = 41;
        break;
      case 56:
        ply = 36;
        break;
      case 43:
        ply = 33;
        break;
      case 37:
        ply = 30;
        break;
      case 25:
        ply = 16;
        break;
      case 21:
        ply = 3;
        break;
      case 18:
        ply = 7;
        break;

      // Ladders
      case 5:
        ply = 14;
        break;
      case 20:
        ply = 29;
        break;
      case 23:
        ply = 45;
        break;
      case 40:
        ply = 48;
        break;
      case 42:
        ply = 53;
        break;
      case 58:
        ply = 67;
        break;
      case 70:
        ply = 90;
        break;
      case 71:
        ply = 92;
        break;
      case 75:
        ply = 97;
        break;

      default:
    }
    return ply;
  }

  InkWell player1(BuildContext context) {
    return InkWell(
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
                  ? randomNo == 1 ? ply1 = order(randomNo) : ply1 = 0
                  : ply1 + randomNo > 100
                      ? ply1 = ply1
                      : ply1 = order(order(ply1) + randomNo);
              Future.delayed(Duration(seconds: 1)).whenComplete(() {
                setState(() {
                  ply1 = snakeLadderCmd(ply1);
                });
              });
              if (ply1 == 100)
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: new Text("Snakes & Ladders"),
                          content: new Text(
                              "Player 1 WON !!!\nDo you want to Restart ?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                setState(() {
                                  ply1 = 0;
                                  ply2 = 0;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
            });
            Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
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
                color: ply1Color,
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Snakes & Ladders'),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            icon: Icon(!isComputer ? Icons.computer : Icons.people_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        title: new Text("Snakes & Ladders"),
                        content: new Text(isComputer
                            ? "Would you like to change Player1 to mannual"
                            : "Would you like to convert Player 1 to Computer"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              setState(() {
                                isComputer = !isComputer;
                                plyturn = true;
                                print('isComputer = $isComputer');
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
              // setState(() {
              //   isComputer = !isComputer;
              // });
            }),
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        title: new Text("Snakes & Ladders"),
                        content: new Text("Would you like Restart ?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              setState(() {
                                ply1 = 0;
                                ply2 = 0;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
              // setState(() {
              //   ply1=0;ply2=0;
              //   // ply1 = 100;
              // });
            })
      ],
    );
  }
}
