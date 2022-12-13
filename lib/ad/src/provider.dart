import 'package:flutter/material.dart';

import 'config.dart';
import 'enum.dart';
import 'listener.dart';

abstract class AdProvider {
  ///以下是隐私政策相关内容

  ///如果是在美国加州地区，需要设置CCPA，然后在初始化SDK
  void setCCPADoNotSell(bool canDataCollection);

  ///美国儿童在线隐私权保护法（Children’s Online Privacy Protection Act，）主要针对在线收集 13 岁以下儿童个人信息的行为。
  /// 该保护法规定网站管理者应遵守隐私规则，须说明向儿童家长索求同意的时间及提供可验证方式，且网站管理者须保护儿童在线隐私和安全，包括限制向 13 岁以下的儿童销售。
  void setCOPPAIsAgeRestrictedUser(bool isChild);

  ///欧盟地区需要调用showGDPRDialog来确认是否可以收集数据
  void setGDPRDataCollection(bool canDataCollection);

  ///欧盟地区才调用showGDPRDialog设置GDPR。
  void showGDPRDialog();

  ///开启或关闭 个性化推荐广告
  ///一般默认开启
  void setOpenPersonalizedAd(bool open);

  ///设置隐私信息控制开关（国内）
  ///(1)默认开启状态 true，关闭传false。
  /// (2)初始化TP SDK后，请求广告前调用。
  /// (3)仅在应用第一次设置时候生效，
  /// 如需更改需要重启应用重新设置。
  void setPrivacyUserAgree(bool privacyUserAgree);

  ///以下是广告相关

  ///添加广告监听
  ///[adUnitId]广告单元ID
  ///[adListener]广告监听
  void addAdListener(String adUnitId, AdListener adListener) {
    AdListenerManager.addAdListener(adUnitId, adListener);
  }

  ///移除广告监听
  ///[adUnitId]广告单元ID
  ///[adListener]添加的监听
  void removeAdListener({String? adUnitId, AdListener? adListener}) {
    AdListenerManager.removeAdListener(adUnitId: adUnitId, adListener: adListener);
  }

  ///加载广告
  ///[adType]所需加载的广告类型
  ///[adUnitId]广告单元ID
  ///[adConfig]需要传递给广告平台的配置信息
  ///return 表示加载状态
  Future<AdLoadStatus> loadAd(AdType adType, String adUnitId, {AdConfig? config});

  ///是否正在加载中,加载前可以判断下,避免重复加载
  Future<bool> isAdLoading(
    AdType adType,
    String adUnitId,
  );

  ///广告是否准备好了
  ///[adType]广告类型
  ///[adUnitId]广告单元ID
  Future<bool> isAdReady(AdType adType, String adUnitId);

  ///显示开屏广告
  ///返回值表示是否显示结束
  Future<bool> showSplashAd(BuildContext context, String adUnitId, {SplashAdConfig? adConfig});

  ///显示原生广告
  Widget showNativeAd(String adUnitId, {NativeAdConfig? config});

  ///显示激励视频
  Future<void> showRewardAd(String adUnitId);

  ///显示bannerview
  Widget showBannerAd(String adUnitId);
}
