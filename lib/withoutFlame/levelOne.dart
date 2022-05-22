import 'dart:async';
//import 'dart:ui';
//import 'dart:html';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_flame_game/withoutFlame/transitionLore.dart';

import '../mainMenu.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with WidgetsBindingObserver {
  double up = 0;
  double position = 0;
  bool stop1 = false;
  bool stop2 = false;
  double hFireMove = 0;
  double eFireMove = 0;
  final containerKey1 = GlobalKey(); //unused
  final containerKey2 = GlobalKey(); //unused
  int score = 0;
  // static AudioCache player = new AudioCache();
  // static const hitAudioPath = "hit.mp3";
  double moveRight = 0;
  double moveLeft = 0;
  int hp = 15;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if ((MediaQuery.of(context).size.width / 1.32 + eFireMove) <=
            MediaQuery.of(context).size.width) {
          eFireMove = 0;
          hp--;
        }
        if (score >= 15 || hp <= 0) {
          timer.cancel();
        }

        Timer.periodic(const Duration(milliseconds: 50), (timer) {
          setState(() {
            if (stop1 == false) {
              eFireMove -= 10;
            }
          });
        });
      });
    });
    // if (score >= 3) {
    //   gameOver();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        backgroundImage(context),
        heroSprite(context),
        enemySprite(context),
        enemyFireBall(context),
        heroFireBall(context),
        buildLeftButton(context),
        fireButton(context),
        buildRightButton(context),
        scoreBoard(context),
        healthBoard(context),
        if (score >= 15) youWin(context),
        if (hp <= 0) gameOver(context),
      ]),
    );
  }

  GestureDetector youWin(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/youWin.png"),
              fit: BoxFit.fill,
            ))),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TransitionLore()),
          );
        } //Navigate to lore and then to level 2
        );
  }

  GestureDetector gameOver(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/gameOver.png"),
              fit: BoxFit.fill,
            ))),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const mainMenu()),
          );
        } //Navigate to main menu
        );
  }

  Positioned fireButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 1.17,
      left: MediaQuery.of(context).size.width / 1.1,
      child: IconButton(
          icon: const Icon(Icons.local_fire_department_sharp),
          iconSize: 50,
          onPressed: () {
            score++;
            //hFireMove = 0;
            setState(() {
              // if ((MediaQuery.of(context).size.width / 6 + hFireMove) >= (MediaQuery.of(context).size.width / 1.25)) {
              //   score++;
              //   player.play(hitAudioPath);
              // }
              // if (score >= 3) {
              //   gameOver();
              // }
              if ((MediaQuery.of(context).size.width / 6 + hFireMove) >=
                  MediaQuery.of(context).size.width) {
                hFireMove =
                    ((MediaQuery.of(context).size.width / 20) + position);
              }
              Timer.periodic(const Duration(microseconds: 2000), (timer) {
                setState(() {
                  if (stop2 == false) {
                    hFireMove = hFireMove +
                        (((MediaQuery.of(context).size.width / 20) + position) +
                            10);
                  }
                });
              });
            });
          }),
    );
  }

  Positioned scoreBoard(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 20,
      left: MediaQuery.of(context).size.width / 1.15,
      child: Text(
        'Score: ' + score.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }

  Positioned healthBoard(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 20,
      right: MediaQuery.of(context).size.width / 1.1,
      child: Text(
        'HP: ' + hp.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }

  AnimatedPositioned backgroundImage(BuildContext context) {
    return AnimatedPositioned(
      right: moveRight,
      //left: moveLeft,
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/level1BG.jpg"),
            fit: BoxFit.fitHeight,
          ))),
      duration: const Duration(microseconds: 200),
    );
  }

  AnimatedPositioned heroSprite(BuildContext context) {
    return AnimatedPositioned(
      top: MediaQuery.of(context).size.height / 1.5,
      left: (MediaQuery.of(context).size.width / 20) + position,
      child: Container(
          key: containerKey1,
          height: 130,
          width: 120,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/heroSprite.png"),
            fit: BoxFit.fill,
          ))),
      duration: const Duration(microseconds: 10),
    );
  }

  AnimatedPositioned enemySprite(BuildContext context) {
    return AnimatedPositioned(
      top: MediaQuery.of(context).size.height / 1.5,
      left: MediaQuery.of(context).size.width / 1.25,
      child: Container(
          height: 130,
          width: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/enemySprite.png"),
            fit: BoxFit.fill,
          ))),
      duration: const Duration(microseconds: 10),
    );
  }

  AnimatedPositioned enemyFireBall(BuildContext context) {
    return AnimatedPositioned(
      top: MediaQuery.of(context).size.height / 1.37,
      left: MediaQuery.of(context).size.width / 1.32 + eFireMove,
      child: Container(
          key: containerKey2,
          height: 35,
          width: 50,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/enemyFireBall.png"),
            fit: BoxFit.fill,
          ))),
      duration: const Duration(microseconds: 10),
    );
  }

  AnimatedPositioned heroFireBall(BuildContext context) {
    return AnimatedPositioned(
      top: MediaQuery.of(context).size.height / 1.3,
      left: MediaQuery.of(context).size.width / 6 + hFireMove,
      child: Container(
          height: 35,
          width: 50,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/heroFireBall.png"),
            fit: BoxFit.fill,
          ))),
      duration: const Duration(microseconds: 5000),
    );
  }

  Positioned buildLeftButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 1.15,
      left: MediaQuery.of(context).size.width / 20,
      child: GestureDetector(
        child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/LeftButton.png"),
              fit: BoxFit.fill,
            ))),
        onTap: () {
          setState(() {
            // moveRight -= 10;
            position -= 40;
            if (position < -50) {
              position = 640;
            }
          });
        },
      ),
    );
  }

  Positioned buildRightButton(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height / 1.15,
        left: MediaQuery.of(context).size.width / 8,
        child: GestureDetector(
          child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/RightButton.png"),
                fit: BoxFit.fill,
              ))),
          onTap: () {
            setState(() {
              //moveRight += 5;
              position += 40;
              if (position > 640) {
                position = 0;
              }
            });
          },
        ));
  }

// void _onCheckTap() {
//   RenderObject box1 = containerKey1.currentContext.findRenderObject();
//   RenderObject box2 = containerKey2.currentContext.findRenderObject();
//
//   final size1 = box1.size;
//   final size2 = box2.size;
//
//   final position1 = box1.localToGlobal(Offset.zero);
//   final position2 = box2.localToGlobal(Offset.zero);
//
//   final collide = (position1.dx < position2.dx + size2.width &&
//       position1.dx + size1.width > position2.dx &&
//       position1.dy < position2.dy + size2.height &&
//       position1.dy + size1.height > position2.dy);
//
//   print('Containers collide: $collide');
// }
}
