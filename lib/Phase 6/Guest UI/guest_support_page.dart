import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/extras/extras.dart';

class GuestSupportPage extends StatefulWidget {
  int pageIndex;
  GuestSupportPage({
    super.key,
    required this.pageIndex,
  });

  @override
  State<GuestSupportPage> createState() => _GuestSupportPageState();
}

class _GuestSupportPageState extends State<GuestSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        child: Image.asset(
          'assets/images/17580.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(160),
            child: Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange),
                    height: MediaQuery.of(context).size.height * 0.235,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.getSize60(context: context) +
                                  SizeConfig.getSize20(context: context),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 2,
                                  left: SizeConfig.getFontSize25(
                                      context: context),
                                  right: SizeConfig.getFontSize25(
                                      context: context)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppBarIconContainer(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    height:
                                        SizeConfig.getSize38(context: context),
                                    width:
                                        SizeConfig.getSize38(context: context),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: DynamicColor.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Image.asset(
                                            "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                            height: 30,
                                            width: 30,
                                            color: DynamicColor.gredient1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Image.asset(
                          "assets/image/handshake.png",
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          aapSupporter(),
        ],
      ),
      CustomAppbarWithWhiteBg(
        title: 'CHATS',
        colorTween: 'BIOGRAPHY',
        onPressad: () {
          PageNavigateScreen().push(
              context,
              GuestManuPage(
                title: 'CHATS',
                pageIndex: 3,
              ));
        },
      ),
      NewCustomBottomBar(
        index: widget.pageIndex,
        isBack: 'Guest',
      ),
    ]));
  }

  Widget aapSupporter() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize20(context: context),
          right: SizeConfig.getFontSize20(context: context)),
      child: Column(
        children: [
          Divider(
            height: 0,
            color: DynamicColor.butnClr2,
          ),
          ListTile(
            onTap: () {
              whatsappLuncher();
              // if (adminChatID == null) {
              //   myToast(context,
              //       msg: 'Something went wrong please try again later.');
              // } else {
              //   PageNavigateScreen().push(
              //       context,
              //       AppSupporterChatPage(
              //         img: '',
              //         name: 'Pitch Me App',
              //         id: adminChatID,
              //         recieverid: 'admin',
              //         back: 'back',
              //       ));
              // }
            },
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 5.0,
            minLeadingWidth: 0.0,
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('assets/image/handshake.png'),
              backgroundColor: DynamicColor.gredient2,
            ),
            title: Text(
              'Pitch Me App Support',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'How can we help?',
              // adminmessage != null
              //     ? adminmessage['message']
              //     : 'How can we help?',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: DynamicColor.hintclr, fontWeight: FontWeight.w400),
            ),
          ),
          Divider(
            height: 0,
            color: DynamicColor.butnClr2,
          ),
        ],
      ),
    );
  }

  whatsappLuncher() async {
    var contact = "+971585084829";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      myToast(context, msg: 'WhatsApp is not installed.');
    }
  }

  @override
  void dispose() {
    //controller.close();

    super.dispose();
  }
}
