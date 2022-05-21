import 'package:flutter/material.dart';
import 'package:flutter_flame_game/main_game_runner.dart';
import 'package:flutter_flame_game/mainmenu.dart';
import 'package:video_player/video_player.dart';

class startLore extends StatefulWidget {
  const startLore({Key? key}) : super(key: key);

  @override
  State<startLore> createState() => _startLoreState();
}

class _startLoreState extends State<startLore> {
  late VideoPlayerController _controller;

  // void checkVideo() {
  //   if (_controller.value.position ==
  //       Duration(
  //         seconds: 19,
  //       )) {
  //     Navigator.of(context).push(_createRoute());
  //   }
  // }

  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/LoreFinal.mp4")
      ..initialize().then((_) {
        _controller.play();
        //_controller.setLooping(true);

        setState(() {});
      });

    // _controller.addListener(checkVideo);

    Future.delayed(const Duration(seconds: 23), () {
      Navigator.of(context).push(_createRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                )),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MyAppGame(),
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
