import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:sizer/sizer.dart';

import '../../../View/Custom header view/new_bottom_bar.dart';
import '../../../View/Manu/benefits/benefits.dart';
import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../../utils/widgets/extras/banner.dart';

class AmateurUserLimitationPage extends StatefulWidget {
  int pageIndex;
  bool showBottomBar;
  int onBack;
  AmateurUserLimitationPage({
    super.key,
    required this.pageIndex,
    required this.showBottomBar,
    required this.onBack,
  });

  @override
  State<AmateurUserLimitationPage> createState() =>
      _AmateurUserLimitationPageState();
}

class _AmateurUserLimitationPageState extends State<AmateurUserLimitationPage> {
  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
            bottomNavigationBar: BannerWidget(
              onPressad: () {},
            ),
            body: BackGroundWidget(
              bannerRequired: false,
              backgroundImage: Assets.backgroundImage,
              fit: BoxFit.cover,
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize15(context: context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/imagess/Group.png",
                          height: sizeH * 0.09,
                        ),
                        Image.asset(
                          "assets/imagess/Group 2.png",
                          height: sizeH * 0.09,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Image.asset(
                      "assets/imagess/Pitch me Logo.png",
                      height: sizeH * 0.17,
                    ),
                  ),
                  spaceHeight(SizeConfig.getSize20(context: context)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize15(context: context)),
                    child: Image.asset(
                      'assets/imagess/YOU CANT 2.png',
                      height: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.11),
                    ),
                  ),
                  //spaceHeight(SizeConfig.getSize30(context: context)),
                  SizedBox(
                    child: Text(
                      'You have reached',
                      style: TextStyle(
                        fontSize: sizeH * 0.027,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: DynamicColor.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'the limit for',
                      style: TextStyle(
                        fontSize: sizeH * 0.027,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: DynamicColor.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'Amateur User',
                      style: TextStyle(
                        fontSize: sizeH * 0.027,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: DynamicColor.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: Platform.isAndroid ? sizeH * 0.1 : sizeH * 0.05,
                  ),

                  Card(
                    color: DynamicColor.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isCheck = 1;
                        });

                        PageNavigateScreen().normalpushReplesh(
                            context,
                            BenefitsPage(
                              pageIndex: widget.pageIndex,
                              onBack: widget.onBack,
                            ));
                      },
                      child: Container(
                        height: 5.h,
                        width: MediaQuery.of(context).size.width * 0.50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isCheck == 1 ? DynamicColor.white : null,
                            border: isCheck == 1
                                ? Border.all(color: DynamicColor.gredient2)
                                : null,
                            gradient: isCheck == 1
                                ? null
                                : DynamicColor.gradientColorChange),
                        child: Text(
                          "CHECK PRO BENEFITS",
                          style: isCheck == 1 ? gredient216bold : white16bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        widget.showBottomBar
            ? NewCustomBottomBar(
                index: widget.pageIndex,
                isBack: true,
              )
            : Container(),
      ],
    );
  }
}
