import 'package:flutter/material.dart';
import 'native_custom_template.dart';

abstract class AdConfig {}

///开屏广告配置
class SplashAdConfig extends AdConfig {
  ///android splash 背景 only android
  final Color? backgroundColor;

  ///android上底部拼接的logo区域
  final Widget? androidLogoView;

  ///iOS上底部拼接的nib名称,需要在主工程中创建对应名称的nib
  final String? iOSBottomLayoutNib;

  ///原生拼接开屏自定义渲染样式文件
  final String? customLayoutClassName;

  SplashAdConfig({this.backgroundColor, this.androidLogoView, this.iOSBottomLayoutNib, this.customLayoutClassName});
}

///原生广告配置
class NativeAdConfig extends AdConfig {
  ///使用flutter自渲染模板样式
  List<NativeCustomTemplateItem>? customTemplateItems;

  ///使用原生布局自渲染样式
  String? customLayoutClassName;

  ///原生广告宽度，不配置会使用广告商默认配置
  final double width;

  ///原生广告高度，不配置会使用广告商默认配置
  final double height;

  NativeAdConfig({required this.width, required this.height, this.customTemplateItems, this.customLayoutClassName});
}

///激励视频广告配置
class RewardAdConfig extends AdConfig {
  RewardAdConfig();
}

class BannerAdConfig extends AdConfig {
  ///横幅广告宽度，不配置会使用广告商默认配置
  final double width;

  ///横幅广告高度，不配置会使用广告商默认配置
  final double height;

  BannerAdConfig({required this.width, required this.height});
}
