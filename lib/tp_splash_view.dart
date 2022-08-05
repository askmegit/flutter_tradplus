import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TPSplashViewWidget extends StatefulWidget {
  TPSplashViewWidget(this.adUnitId);

  String adUnitId;

  @override
  State<StatefulWidget> createState() {
    return TPSplashViewWidgetState();
  }
}

class TPSplashViewWidgetState extends State<TPSplashViewWidget> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        key: UniqueKey(),
        viewType: 'tp_splash_view',
        creationParams: <String, dynamic>{"adUnitId": widget.adUnitId},
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return const Text("Unsupported platform");
    }
  }
}