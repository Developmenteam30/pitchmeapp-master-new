import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/selected_data_view/selected_page.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';
import '../success page/confirmation_post.dart';
import 'Controller/controller.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final String title;
  dynamic type;
  VideoPage({Key? key, required this.filePath, required this.title, this.type})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  final VideoFirstPageController _videoFirstPageController =
      Get.put(VideoFirstPageController());

  final _controller = PageController();

  int selectIndex = 2;
  int nextPage = 0;

  bool isSelectedScreen = true;
  bool isLoading = false;

  String compressVideoUrl = '';

  late Subscription _subscription;

  double progressData = 0.0;
  double precent = 0.0;

  @override
  void initState() {
    //  print('type = ' + widget.type.toString());
    //if (widget.type != null || widget.type != 'upload') {
    // compressVideo();
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   setState(() {
    //     progressData = progress;
    //     precent = 0 + progress / 100;
    //   });
    //   print('progress: $progress');
    //   print('precent: $precent');
    // });
    //  } else {
    setState(() {
      isLoading = true;
      _videoFirstPageController.videoUrl.value = widget.filePath;
      compressVideoUrl = widget.filePath;
    });

    _initVideoPlayer();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    //  }

    super.initState();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(compressVideoUrl));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    //await _videoPlayerController.play();
  }

  repalyVideo() async {
    await _videoPlayerController.play();
  }

  // Future<void> compressVideo() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await VideoCompress.setLogLevel(0);
  //   final info = await VideoCompress.compressVideo(
  //     widget.filePath,
  //     quality: VideoQuality.MediumQuality,
  //     deleteOrigin: false,
  //     includeAudio: true,
  //   );
  //   await VideoCompress.compressProgress$;
  //   setState(() {
  //     compressVideoUrl = info!.path!;
  //     _videoFirstPageController.videoUrl.value = compressVideoUrl;
  //     _initVideoPlayer();
  //     print('compressVideoUrl = ' + compressVideoUrl);
  //     print('compressVideoUrl size = ' + info.filesize.toString());
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: DynamicColor.gredient1)
              //   widget.type == 'upload' || widget.type == null
              //       ? CircularProgressIndicator()
              //       : CircularPercentIndicator(
              //           radius: 70.0,
              //           animation: true,
              //           animateFromLastPercent: true,
              //           animationDuration: 1200,
              //           lineWidth: 10.0,
              //           percent: precent,
              //           center: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text(
              //                 '${progressData.toStringAsFixed(1)}%',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold, fontSize: 20.0),
              //               ),
              //               Text(
              //                 'Processing...',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold, fontSize: 14.0),
              //               ),
              //             ],
              //           ),
              //           circularStrokeCap: CircularStrokeCap.butt,
              //           backgroundColor: Colors.grey.shade300,
              //           progressColor: Colors.green,
              //         ),
              )
          : Stack(
              children: [
                PageView(
                  controller: _controller,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  onPageChanged: (value) {
                    setState(() {
                      nextPage = value;
                    });
                  },
                  children: [
                    Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                _videoPlayerController.value.isPlaying
                                    ? _videoPlayerController.pause()
                                    : _videoPlayerController.play();
                              });
                            },
                            child: VideoPlayer(_videoPlayerController)),
                        SizedBox(
                          height: SizeConfig.getSize100(context: context) +
                              SizeConfig.getSize55(context: context),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.15),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    widget.title,
                                    style: gredient216bold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _videoPlayerController.value.isPlaying
                                        ? _videoPlayerController.pause()
                                        : _videoPlayerController.play();
                                  });
                                },
                                child: _videoPlayerController.value.isPlaying
                                    ? Container()
                                    : Icon(
                                        _videoPlayerController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: DynamicColor.white,
                                        size: 100,
                                      ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.24),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Pitch details', style: gredient116bold),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: Platform.isAndroid
                                      ? SizeConfig.getSize55(context: context)
                                      : SizeConfig.getSize60(context: context) +
                                          SizeConfig.getSize15(
                                              context: context),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  },
                                  child: RotatedBox(
                                      quarterTurns: 4,
                                      child: Image.asset(
                                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                        height: SizeConfig.getSize35(
                                            context: context),
                                        width: SizeConfig.getSize35(
                                            context: context),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.getSize30(context: context) +
                                  MediaQuery.of(context).size.height * 0.021,
                              left: SizeConfig.getFontSize25(context: context),
                              right:
                                  SizeConfig.getFontSize25(context: context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: AppBarIconContainer(
                                  height:
                                      SizeConfig.getSize38(context: context),
                                  width: SizeConfig.getSize38(context: context),
                                  color: DynamicColor.redColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: Icon(
                                    Icons.close,
                                    color: DynamicColor.white,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  TextStrings.textKey['add_seles_pitch']!
                                      .toUpperCase(),
                                  style: gredient115,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: AppBarIconContainer(
                                  height:
                                      SizeConfig.getSize38(context: context),
                                  width: SizeConfig.getSize38(context: context),
                                  color: DynamicColor.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  child: Icon(
                                    Icons.check,
                                    color: DynamicColor.white,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    _videoPlayerController.pause();
                                    Get.to(() => const ConfirmationPost());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // CustomHeaderView(
                        //   progressPersent: 1,
                        //   checkNext: 'next',
                        //   nextOnTap: () {
                        //     _videoPlayerController.pause();
                        //     Get.to(() => const ConfirmationPost());
                        //   },
                        // ),
                      ],
                    ),
                    SelectedPage(
                      showIcon: nextPage,
                      pageController: _controller,
                    )
                  ],
                ),
                NewCustomBottomBar(
                  index: 2,
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _videoPlayerController.pause();
    _subscription.unsubscribe();
    super.dispose();
  }
}
