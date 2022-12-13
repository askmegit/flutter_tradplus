late final AdListenerManager = _AdListenerCenter._();

class _AdListenerCenter {
  _AdListenerCenter._();

  Map<String, AdListener> _adListenerCached = {};

  void addAdListener(String adUnitId, AdListener listener) {
    _adListenerCached[adUnitId] = listener;
  }

  void removeAdListener({String? adUnitId, AdListener? adListener}) {
    assert(adUnitId != null || adListener != null, "广告ID和AdListener不可同时为空");
    _adListenerCached.removeWhere((key, value) => adUnitId == adUnitId || value == adListener);
  }

  AdListener? getAdListener(String adUnitId) {
    return _adListenerCached[adUnitId];
  }
}

AdListener SimpleAdListener(
    {Function(String adUnitId, dynamic adInfo)? onAdClosed,
    Function(String adUnitId, dynamic adInfo)? onAdLoadFailed,
    Function(String adUnitId, dynamic adInfo)? onAdLoaded,
    Function(String adUnitId, dynamic adInfo)? onAdReward,
    Function(String adUnitId, dynamic adInfo)? onAdShow,
    Function(String adUnitId, dynamic adInfo, dynamic error)? onAdShowFailed}) {
  return AdListener(onAdClosed: (adUnitId, adInfo) {
    onAdClosed?.call(adUnitId, adInfo);
  }, onAdLoadFailed: (adUnitId, adInfo) {
    onAdLoadFailed?.call(adUnitId, adInfo);
  }, onAdLoaded: (adUnitId, adInfo) {
    onAdLoaded?.call(adUnitId, adInfo);
  }, onAdShowFailed: (adUnitId, adInfo, error) {
    onAdShowFailed?.call(adUnitId, adInfo, error);
  }, onAdReward: (adUnitId, adInfo) {
    onAdReward?.call(adUnitId, adInfo);
  }, onAdShow: (adUnitId, adInfo) {
    onAdShow?.call(adUnitId, adInfo);
  });
}

///广告监听
class AdListener {
  ///加载成功
  final Function(String adUnitId, dynamic adInfo) onAdLoaded;

  ///加载失败
  final Function(String adUnitId, dynamic error) onAdLoadFailed;

  ///展示失败
  final Function(String adUnitId, dynamic adInfo, dynamic error) onAdShowFailed;

  ///广告展示成功
  final Function(String adUnitId, dynamic adInfo)? onAdShow;

  ///广告关闭
  final Function(String adUnitId, dynamic adInfo) onAdClosed;

  ///获取奖励
  final Function(String adUnitId, dynamic adInfo)? onAdReward;

  AdListener({required this.onAdClosed, required this.onAdLoadFailed, required this.onAdLoaded, required this.onAdShowFailed, this.onAdReward, this.onAdShow});
}
