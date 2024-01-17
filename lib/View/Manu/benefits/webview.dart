import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pitch_me_app/View/Manu/benefits/payment_faild.dart';
import 'package:pitch_me_app/View/Manu/benefits/payment_success.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class WebViewPage extends StatefulWidget {
  String webUrl;
  String clientKey;
  WebViewPage({super.key, required this.webUrl, required this.clientKey});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage>
    with TickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  late AnimationController animationController;

  Timer timer = Timer(const Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();

    // timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   checkPaymentApi();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.webUrl)),
      onLoadStart: (InAppWebViewController controller, url) {
        log('retrn = ' + url!.path.toString());
        setState(() {});

        if (url.path == "/paymentsuccess.html") {
          controller.goBack();
          PageNavigateScreen().normalpushReplesh(context, PaymentSuccessPage());
        } else if (url.path == "/paymentfailure.html") {
          controller.goBack();
          PageNavigateScreen().normalpushReplesh(context, PaymentFaildPage());
        } else if (url.path == "/api/acceptance/post_pay") {
          checkPaymentApi();
        }
      },
    );
  }

  Future<void> checkPaymentApi() async {
    try {
      await GetApiService()
          .getStatusApi(widget.clientKey.toString())
          .then((value) {
        if (value["code"] == "intention_already_processed") {
          updateMembershipApi();
        }
      });
      // var tempData = json.decode(res);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateMembershipApi() async {
    try {
      await GetApiService().updateMembershipApi().then((value) {
        if (value["message"] == "User has been successfully updated") {
          PageNavigateScreen().pushRemovUntil(context, Floatbar(0));
        }
      });
      // var tempData = json.decode(res);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    animationController.dispose();
  }
}
