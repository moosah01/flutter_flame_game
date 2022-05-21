import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_flame_game/mainmenu.dart';

class animationLoader extends StatefulWidget {
  const animationLoader({Key? key}) : super(key: key);

  @override
  State<animationLoader> createState() => _animationLoaderState();
}

class _animationLoaderState extends State<animationLoader>
    with TickerProviderStateMixin {
  late AnimationController spincontroller;

  late Image cardFront;
  late Image cardBack;

  bool isBack = true;
  bool continueSpinAnimation = true;

  var _duration = new Duration(seconds: 3);

  // late final Animation<double> bounce;

  double angle = 0;

  @override
  void initState() {
    super.initState();

    cardBack = Image.asset("assets/CoinBack.png");
    cardFront = Image.asset("assets/CoinFront.png");

    // Initialize the animation controller
    spincontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 0)
      ..addListener(() {});

    //controller.forward();
    //controller.reverse();
    Future.delayed(const Duration(milliseconds: 100), () {
      initAnimate();
    });
  }

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   precacheImage(cardFront.image, context);
  //   precacheImage(cardBack.image, context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Text("Loading ...",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Invasion2000")),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Container(
                  child: animatedBuilderSpin(),

                  //animatedBuilderTransformTranslate(),
                ),
              ),
            ],
          )),
        ));
  }

  AnimatedBuilder animatedBuilderSpin() {
    return AnimatedBuilder(
      animation: spincontroller,
      builder: (context, child) {
        return transformWidget();
      },
    );
  }

  Transform transformWidget() {
    return Transform(
      transform: Matrix4.rotationY((spincontroller.value) * pi / 2),
      alignment: Alignment.center,
      child: containerSpin(),
    );
  }

  Container containerSpin() {
    return Container(
      height: 250,
      width: 250,
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: isBack ? cardFront : cardBack,
    );
  }

  Future<void> initAnimate() async {
    while (continueSpinAnimation) {
      // Flip the image

      await spincontroller.forward();
      setState(() => isBack = !isBack);
      await spincontroller.reverse();
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const mainMenu(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begiN = Offset(0.0, 1.0);
        const enD = Offset.zero;
        const curveS = Curves.ease;

        var tween = Tween(
          begin: begiN,
          end: enD,
        ).chain(CurveTween(curve: curveS));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
