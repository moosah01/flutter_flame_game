import 'package:flutter/material.dart';
import 'package:flutter_flame_game/startLoreVideo.dart';
import 'package:flutter_flame_game/withoutFlame/levelOne.dart';
import 'package:video_player/video_player.dart';

class mainMenu extends StatefulWidget {
  const mainMenu({Key? key}) : super(key: key);

  @override
  State<mainMenu> createState() => _mainMenuState();
}

class _mainMenuState extends State<mainMenu> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/VideoToUse.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
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
          const StartGameWidget(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StartGameWidget extends StatelessWidget {
  const StartGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Shapatarr Man",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: "Invasion2000")),
              GestureDetector(
                child: const Text("Play Without Flame",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Invasion2000")),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartScreen()));
                },
              ),
              GestureDetector(
                child: const Text("Play With Flame",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Invasion2000")),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const startLore()));
                },
              ),
              // const Text("Tap To Start Game",
              //     style: TextStyle(
              //         // fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //         fontSize: 10,
              //         fontFamily: "Invasion2000")),
              const SizedBox(
                width: 100,
                height: 50,
              ),
              const Text("Developed By",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Invasion2000")),
              const Text("Moosa\nAmmar\nEbrahim",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: "Invasion2000")),
            ],
          ),
        ),
      ),
    );
  }
}
