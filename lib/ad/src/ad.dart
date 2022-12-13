import 'package:flutter/widgets.dart';

import 'config.dart';
import 'enum.dart';
import 'listener.dart';
import 'provider.dart';

late final AdManager = _AdManagerInner._();

///广告业务管理类
class _AdManagerInner extends AdProvider {
  _AdManagerInner._();

  late AdProvider _provider;

  void init(AdProvider provider) {
    _provider = provider;
  }

  @override
  void setCCPADoNotSell(bool canDataCollection) {
    _provider.setCCPADoNotSell(canDataCollection);
  }

  @override
  void setCOPPAIsAgeRestrictedUser(bool isChild) {
    _provider.setCOPPAIsAgeRestrictedUser(isChild);
  }

  @override
  void setOpenPersonalizedAd(bool open) {
    _provider.setOpenPersonalizedAd(open);
  }

  @override
  void setPrivacyUserAgree(bool privacyUserAgree) {
    _provider.setPrivacyUserAgree(privacyUserAgree);
  }

  @override
  void showGDPRDialog() {
    _provider.showGDPRDialog();
  }

  @override
  void setGDPRDataCollection(bool canDataCollection) {
    _provider.setGDPRDataCollection(canDataCollection);
  }

  @override
  void addAdListener(String adUnitId, AdListener adListener) {
    _provider.addAdListener(adUnitId, adListener);
  }

  @override
  void removeAdListener({String? adUnitId, AdListener? adListener}) {
    _provider.removeAdListener(adUnitId: adUnitId);
  }

  @override
  Future<bool> isAdReady(AdType adType, String adUnitId) {
    return _provider.isAdReady(adType, adUnitId);
  }

  @override
  Future<bool> isAdLoading(AdType adType, String adUnitId) {
    return _provider.isAdLoading(adType, adUnitId);
  }

  @override
  Future<bool> showSplashAd(BuildContext context, String adUnitId, {SplashAdConfig? adConfig}) async {
    return _provider.showSplashAd(context, adUnitId, adConfig: adConfig);
  }

  @override
  Future<AdLoadStatus> loadAd(AdType adType, String adUnitId, {AdConfig? config}) {
    return _provider.loadAd(adType, adUnitId, config: config);
  }

  @override
  Widget showNativeAd(String adUnitId, {NativeAdConfig? config}) {
    return _provider.showNativeAd(adUnitId, config: config);
  }

  @override
  Future<void> showRewardAd(String adUnitId) {
    return _provider.showRewardAd(adUnitId);
  }

  @override
  Widget showBannerAd(String adUnitId) {
    return _provider.showBannerAd(adUnitId);
  }
}
