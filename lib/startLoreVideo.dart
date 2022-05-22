import 'package:flutter/material.dart';
import 'package:flutter_flame_game/main_game_runner.dart';
//import 'package:flutter_flame_game/mainmenu.dart';
import 'package:video_player/video_player.dart';

class startLore extends StatefulWidget {
  const startLore({Key? key}) : super(key: key);

  @override
  State<startLore> createState() => _startLoreState();
}

class _startLoreState extends State<startLore> {
  late VideoPlayerController _controller;
  late bool forwarded;

  // void checkVideo() {
  //   if (_controller.value.position ==
  //       Duration(
  //         seconds: 19,
  //       )) {
  //     Navigator.of(context).push(_createRoute());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/LoreFinal.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.addListener(() {
          if (!_controller.value.isPlaying) {
            //Navigator.of(context).push(_createRoute());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyAppGame()),
            );
          }
        });

        //_controller.setLooping(true);
        setState(() {});
      });
    //_controller.addListener(checkVideo);
//add here
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                )),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height / 2,
              left: MediaQuery.of(context).size.width / 1.2,
              child: GestureDetector(
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/fastForward.png'),
                        fit: BoxFit.fill,
                      ))),
                  onTap: () {
                    forwarded = true;
                    _controller.pause();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAppGame()),
                    );
                  })),
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
