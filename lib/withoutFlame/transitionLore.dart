import 'package:flutter/material.dart';
import 'package:flutter_flame_game/mainMenu.dart';
import 'package:video_player/video_player.dart';

class TransitionLore extends StatefulWidget {
  const TransitionLore({Key? key}) : super(key: key);

  @override
  State<TransitionLore> createState() => _TransitionLoreState();
}

class _TransitionLoreState extends State<TransitionLore> {
  late VideoPlayerController _loreController;

  @override
  void initState() {
    super.initState();
    _loreController = VideoPlayerController.asset("assets/TransitionLore.mp4")
      ..initialize().then((_) {
        _loreController.play();
        _loreController.addListener(() {
          if (!_loreController.value.isPlaying) {
            //Navigator.of(context).push(_createRoute());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const mainMenu()),
            );
          }
        });
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
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _loreController.value.size.width,
                  height: _loreController.value.size.height,
                  child: VideoPlayer(_loreController),
                )),
          ),
        ],
      ),
    );
  }
}
