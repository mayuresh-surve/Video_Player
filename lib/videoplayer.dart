import 'package:player/flutter_player_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:player/otherchannel.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPause extends StatefulWidget {
  VideoPlayPause(this.controller);

  final VideoPlayerController controller;

  @override
  State createState() {
    return _VideoPlayPauseState();
  }
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  _VideoPlayPauseState() {
    listener = () {
      setState(() {});
    };
  }

  FadeAnimation imageFadeAnim = FadeAnimation(
      child: const Icon(
    Icons.play_arrow,
    size: 100.0,
    color: Colors.white,
  ));
  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
    controller.setVolume(1.0);
    controller.play();
  }

  @override
  void deactivate() {
    controller.setVolume(0.0);
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(controller),
        onTap: () {
          if (!controller.value.initialized) {
            return;
          }
          if (controller.value.isPlaying) {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.pause, size: 100.0));
            controller.pause();
          } else {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
            controller.play();
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      ),
      Center(child: imageFadeAnim),
      Center(
          child: controller.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];

    return Stack(
      fit: StackFit.passthrough,
      children: children,
    );
  }
}

class FadeAnimation extends StatefulWidget {
  FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 1000)});

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  }
}

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
}

class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  _NetworkPlayerLifeCycleState createState() => _NetworkPlayerLifeCycleState();
}

class AssetPlayerLifeCycle extends PlayerLifeCycle {
  AssetPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  _AssetPlayerLifeCycleState createState() => _AssetPlayerLifeCycleState();
}

abstract class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  @override

  /// Subclasses should implement [createVideoPlayerController], which is used
  /// by this method.
  void initState() {
    super.initState();
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }

  VideoPlayerController createVideoPlayerController();
}

class _NetworkPlayerLifeCycleState extends _PlayerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.network(widget.dataSource);
  }
}

class _AssetPlayerLifeCycleState extends _PlayerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.asset(widget.dataSource);
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return Center(
        child: AspectRatio(
          aspectRatio: size.width / size.height,
          child: VideoPlayPause(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}

class Videoplayer extends StatefulWidget {
  @override
  _VideoplayerState createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          AssetPlayerLifeCycle(
            'assets/Falling.mp4',
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatioVideo(controller),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '2 months ago',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          '2.7 M Views',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade700,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                        'Video Name, Lengthning the Title for the Idea of the Title Placement',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0))),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      FlutterPlayer.heart,
                      size: screenHeight * 0.035,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      'Like',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      FlutterPlayer.heart_broken,
                      size: screenHeight * 0.035,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      'Dislike',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      FlutterPlayer.gift,
                      size: screenHeight * 0.035,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      'Gift',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      FlutterPlayer.share,
                      size: screenHeight * 0.035,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      'Share',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      FlutterPlayer.comment,
                      size: screenHeight * 0.035,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      'Comment',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade700,
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'assets/Profile-1.png',
                        height: screenHeight * 0.08,
                        width: screenHeight * 0.08,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Otherchannel(title: 'Channel Name')));
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: Text('Channel Name',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16.0))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Otherchannel(title: 'Channel Name')));
                        },
                      ),
                      Text('123k Followers',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 12.0)))
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/Follow.png',
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.055,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: screenHeight * 0.05,
                      width: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Advertisement',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'www.example.com',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                Image.asset(
                  'assets/Small Button ad.png',
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.04,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('You May Also Like',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0))),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: screenHeight * 0.12,
                        width: screenWidth * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/firework.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: screenWidth * 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  'Video Name, Lengthning the Title for the Idea of the Title Placement',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 11.0))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('04:08 min',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 10.0)))
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Channel Name',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.0))),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text('2.7k Views',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 10.0)))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
