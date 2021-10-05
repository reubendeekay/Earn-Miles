import 'package:better_player/better_player.dart';
import 'package:earn_miles/models/tutorial_model.dart';
import 'package:flutter/material.dart';

class CustomVideo extends StatefulWidget {
  final TutorialModel video;
  CustomVideo({this.video});
  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  BetterPlayerController _betterPlayerController;
  BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.videoUrl,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,

        ///Android only option to use cached video between app sessions
        key: "testCacheKey",
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.preCache(_betterPlayerDataSource);
    super.initState();
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  BetterPlayer(controller: _betterPlayerController),
                  if (!isPlaying)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _betterPlayerController
                              .setupDataSource(_betterPlayerDataSource);
                          setState(() {
                            isPlaying = true;
                          });
                        },
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 32,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )))
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(widget.video.caption)),
          Divider(),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
