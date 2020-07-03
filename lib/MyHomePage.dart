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
  Color ply2Color = Colors.purpleAccent;
  int randomNo = 1;
  bool toAnimate = false;
  int ply1 = 0, ply2 = 0;
  bool plyturn = true;
  bool isComputer = false;

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
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
                  setState(() {
                    // ply1=0;ply2=0;
                    ply1 = 100;
                  });
                })
          ],
        ),
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
                      : InkWell(
                          onTap: () {
                            var randomizer = new Random();
                            setState(() {
                              toAnimate = true;
                              Future.delayed(Duration(seconds: 1))
                                  .whenComplete(() {
                                setState(() {
                                  randomNo = randomizer.nextInt(6) + 1;
                                  print(randomNo);
                                  toAnimate = false;
                                  ply1 == 0
                                      ? randomNo == 1
                                          ? ply1 = randomNo
                                          : ply1 = 0
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
                                    showDialog(
                                        context: context,
                                        builder: (_) => new AlertDialog(
                                              title:
                                                  new Text("Snakes & Ladders"),
                                              content:
                                                  new Text("Player 1 WON !!!"),
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
                              margin: EdgeInsets.all(0),
                              borderOnForeground: true,
                              // key: list[index],
                              color: ply1 == 100 - index || ply2 == 100 - index
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
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                          title: new Text("Snakes & Ladders"),
                                          content: new Text("Player 2 WON !!!"),
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
                          Future.delayed(Duration(milliseconds: 1500))
                              .whenComplete(() {
                            setState(() {
                              plyturn = !plyturn;
                              if (isComputer) {
                                toAnimate = true;
                                Future.delayed(Duration(seconds: 1))
                                    .whenComplete(() {
                                  setState(() {
                                    randomNo = randomizer.nextInt(6) + 1;
                                    print(randomNo);
                                    toAnimate = false;
                                    ply1 == 0
                                        ? randomNo == 1
                                            ? ply1 = randomNo
                                            : ply1 = 0
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
                                      showDialog(
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                                title: new Text(
                                                    "Snakes & Ladders"),
                                                content: new Text(
                                                    "Player 1 WON !!!"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      setState(() {
                                                        ply1 = 0;
                                                        ply2 = 0;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ));
                                  });
                                  Future.delayed(Duration(milliseconds: 1500))
                                      .whenComplete(() {
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
                                    : Image.asset(
                                        'assets/images/$randomNo.png'),
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
      ),
    );
  }
}
