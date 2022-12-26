import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tradplus_sdk/tradplus_sdk.dart';
import 'ad.dart';

_print(Object object) {
  if (kDebugMode) {
    print(object);
  }
}

///tradplus广告代理
class Tradplus extends AdProvider {
  ///是否已经完成初始化
  bool _isInit = false;

  ///是否正在初始化
  bool _isIniting = false;
  String? appId;

  ///根据操作来缓存Completer
  Map<String, Completer> _adTask = {};

  ///根据广告单元ID缓存广告类型
  Map<String, AdType> _cacheAdTypeByUnitId = {};

  ///创建任务ID
  ///[op] 操作类型 比如加载  显示
  ///[type]广告类型,比如开屏 原生等
  ///[adUnitId]广告单元ID
  String _taskId(AdOp op, AdType type, String adUnitId) {
    return op.name + "_" + type.name + "_" + adUnitId;
  }

  ///设置测试模式
  void setTestMode({String? testId}) {
    if (kDebugMode && Platform.isAndroid) {
      TPSDKManager.setTestDevice(true, testModeId: testId);
    }
  }

  ///完成任务
  void _completeTask(String taskId, dynamic result) {
    Completer? completer = _adTask[taskId];
    if (completer != null && completer.isCompleted == false) {
      completer.complete(result);
    }
  }

  ///移除任务
  void _removeTask(String taskId) {
    _adTask.remove(taskId);
  }

  ///添加任务
  Completer _addTask(String taskId) {
    Completer completer = Completer();
    _adTask[taskId] = completer;
    return completer;
  }

  Future<void> init({required String appId, bool isChild = false}) async {
    this.appId = appId;
    if (_isInit == true) {
      return;
    }
    if (_isIniting == true) {
      return;
    }

    _isIniting = true;

    _print("Tradplus init with -> $appId");

    _setListener();

    ///初始化SDK前调用该方法
    ///检查区域
    await TPSDKManager.checkCurrentArea();

    ///当前app面向成人,直接设置为false
    setCOPPAIsAgeRestrictedUser(isChild);

    await TPSDKManager.init(appId);

    _setListener();
  }

  ///初始化之后就设置监听
  void _setListener() {
    _setInitAdListener();
    _setSplashAdListener();
    _setNativeAdListener();
    _setRewardAdListener();
    _setBannerAdListener();
  }

  ///设置初始化监听
  void _setInitAdListener() {
    TPSDKManager.setInitListener(TPInitListener(initFinish: (success) {
      if (success == true) {
        _isInit = true;
      }
      _isIniting = false;
    }, currentAreaSuccess: (bool isEu, bool isCn, bool isCa) {
      //获取到相关地域配置后，设置相关隐私API，然后在初始化SDK
      if (isEu) {
        // 表明是欧盟地区，设置GDPR
        setGDPRDataCollection(false);
      }
      if (isCa) {
        // 表明是美国加州地区，设置CCPA为false
        // 加州用户均不上报数据
        setCCPADoNotSell(false);
      }
    }));
  }

  ///检查是否初始化
  Future<void> _checkInit() async {
    assert(appId != null, "tradplus should init with appId");
    if (_isInit == false) {
      await init(appId: appId!);
    }
  }

  @override
  void setCCPADoNotSell(bool canDataCollection) {
    TPSDKManager.setCCPADoNotSell(canDataCollection);
  }

  @override
  void setCOPPAIsAgeRestrictedUser(bool isChild) {
    TPSDKManager.setCOPPAIsAgeRestrictedUser(isChild);
  }

  @override
  void setOpenPersonalizedAd(bool open) {
    TPSDKManager.setOpenPersonalizedAd(open);
  }

  @override
  void setPrivacyUserAgree(bool privacyUserAgree) {
    TPSDKManager.setPrivacyUserAgree(privacyUserAgree);
  }

  @override
  void showGDPRDialog() {
    TPSDKManager.showGDPRDialog();
  }

  @override
  void setGDPRDataCollection(bool canDataCollection) {
    TPSDKManager.setGDPRDataCollection(canDataCollection);
  }

  @override
  void addAdListener(String adUnitId, AdListener adListener) {
    super.addAdListener(adUnitId, adListener);
  }

  @override
  void removeAdListener({String? adUnitId, AdListener? adListener}) {
    super.removeAdListener(adUnitId: adUnitId);
  }

  ///通知广告加载成功
  void _notifyOnAdLoaded(String adUnitId, dynamic adInfo) {
    AdListenerManager.getAdListener(adUnitId)?.onAdLoaded(adUnitId, adInfo);
    AdType? adType = _cacheAdTypeByUnitId[adUnitId];
    if (adType != null) {
      String taskId = _taskId(AdOp.Load, adType, adUnitId);
      _completeTask(taskId, AdLoadStatus.Loaded);
    }
  }

  ///通知广告加载失败
  void _notifyOnAdLoadFailed(String adUnitId, dynamic adInfo) {
    AdListenerManager.getAdListener(adUnitId)?.onAdLoadFailed(adUnitId, adInfo);
    AdType? adType = _cacheAdTypeByUnitId[adUnitId];
    if (adType != null) {
      String taskId = _taskId(AdOp.Load, adType, adUnitId);
      _completeTask(taskId, AdLoadStatus.LoadFailed);
    }
  }

  ///通知广告展示成功
  void _notifyOnAdShow(String adUnitId, dynamic adInfo) {
    AdListenerManager.getAdListener(adUnitId)?.onAdShow?.call(adUnitId, adInfo);
  }

  ///通知广告展示失败
  void _notifyOnAdShowFailed(String adUnitId, dynamic adInfo, dynamic error) {
    AdListenerManager.getAdListener(adUnitId)?.onAdShowFailed(adUnitId, adInfo, error);
  }

  ///通知广告关闭
  void _notifyOnAdClose(String adUnitId, dynamic adInfo) {
    AdListenerManager.getAdListener(adUnitId)?.onAdClosed(adUnitId, adInfo);
    AdType? adType = _cacheAdTypeByUnitId[adUnitId];
    if (adType == AdType.Splash) {
      ///如果是开屏广告,则通知关闭,让流程继续走下去
      String taskId = _taskId(AdOp.ShowSplash, adType!, adUnitId);
      _completeTask(taskId, true);
    }
  }

  ///通知获取激励
  void _notifyOnAdReward(String adUnitId, dynamic adInfo) {
    AdListenerManager.getAdListener(adUnitId)?.onAdReward?.call(adUnitId, adInfo);
  }

  ///设置开屏广告监听
  void _setSplashAdListener() {
    TPSplashManager.setSplashListener(TPSplashAdListener(
        onAdLoaded: (adUnitId, adInfo) {
          _notifyOnAdLoaded(adUnitId, adInfo);
        },
        onAdLoadFailed: (adUnitId, adInfo) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdImpression: (adUnitId, adInfo) {
          _notifyOnAdShow(adUnitId, adInfo);
        },
        onAdShowFailed: (adUnitId, adInfo, error) {
          _notifyOnAdShowFailed(adUnitId, adInfo, error);
        },
        onAdClicked: (adUnitId, adInfo) {},
        onAdClosed: (adUnitId, adInfo) {
          _notifyOnAdClose(adUnitId, adInfo);
        },
        oneLayerLoadFailed: (adUnitId, adInfo, error) {}));
  }

  ///设置原生广告监听
  void _setNativeAdListener() {
    TPNativeManager.setNativeAdListener(TPNativeAdListener(
        onAdLoaded: (adUnitId, adInfo) {
          _notifyOnAdLoaded(adUnitId, adInfo);
        },
        onAdLoadFailed: (adUnitId, adInfo) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdImpression: (adUnitId, adInfo) {
          _notifyOnAdShow(adUnitId, adInfo);
        },
        onAdShowFailed: (adUnitId, adInfo, error) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdClicked: (adUnitId, adInfo) {},
        onAdClosed: (adUnitId, adInfo) {
          _notifyOnAdClose(adUnitId, adInfo);
        },
        oneLayerLoadFailed: (adUnitId, adInfo, error) {}));
  }

  ///添加激励视频
  void _setRewardAdListener() {
    TPRewardVideoManager.setRewardVideoListener(TPRewardVideoAdListener(
        onAdLoaded: (adUnitId, adInfo) {
          _notifyOnAdLoaded(adUnitId, adInfo);
        },
        onAdLoadFailed: (adUnitId, adInfo) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdImpression: (adUnitId, adInfo) {
          _notifyOnAdShow(adUnitId, adInfo);
        },
        onAdShowFailed: (adUnitId, adInfo, error) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdClicked: (adUnitId, adInfo) {},
        onAdClosed: (adUnitId, adInfo) {
          _notifyOnAdClose(adUnitId, adInfo);
        },
        onAdReward: (adUnitId, adInfo) {
          _notifyOnAdReward(adUnitId, adInfo);
        },
        oneLayerLoadFailed: (adUnitId, adInfo, error) {}));
  }

  ///横幅广告
  void _setBannerAdListener() {
    TPBannerManager.setBannerListener(TPBannerAdListener(
        onAdLoaded: (adUnitId, adInfo) {
          _notifyOnAdLoaded(adUnitId, adInfo);
        },
        onAdLoadFailed: (adUnitId, adInfo) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdImpression: (adUnitId, adInfo) {
          _notifyOnAdShow(adUnitId, adInfo);
        },
        onAdShowFailed: (adUnitId, adInfo, error) {
          _notifyOnAdLoadFailed(adUnitId, adInfo);
        },
        onAdClicked: (adUnitId, adInfo) {},
        onAdClosed: (adUnitId, adInfo) {
          _notifyOnAdClose(adUnitId, adInfo);
        },
        oneLayerLoadFailed: (adUnitId, adInfo, error) {}));
  }

  @override
  Future<AdLoadStatus> loadAd(AdType adType, String adUnitId, {AdConfig? config}) async {
    bool isReady = await isAdReady(adType, adUnitId);
    if (isReady) {
      return AdLoadStatus.Loaded;
    }
    String taskId = _taskId(AdOp.Load, adType, adUnitId);
    if (_adTask.containsKey(taskId)) {
      ///正在加载中就先取消
      _completeTask(taskId, AdLoadStatus.Loading);
    }
    Completer completer = _addTask(taskId);
    await _loadAdByType(adType, adUnitId, config: config);
    AdLoadStatus loaded = await completer.future ?? AdLoadStatus.LoadFailed;
    _removeTask(taskId);
    return loaded;
  }

  @override
  Future<bool> isAdLoading(AdType adType, String adUnitId) async {
    String taskId = _taskId(AdOp.Load, adType, adUnitId);
    return _adTask.containsKey(taskId);
  }

  ///根据类型加载广告
  Future<void> _loadAdByType(AdType adType, String adUnitId, {AdConfig? config}) async {
    if (adType == AdType.Splash) {
      Map? extraMap;
      if (config is SplashAdConfig && config.iOSBottomLayoutNib != null) {
        extraMap = TPSplashManager.createSplashExtraMap(customMap: {"bottom_layout_nib": config.iOSBottomLayoutNib});
      }

      ///开屏广告
      await TPSplashManager.loadSplashAd(adUnitId, extraMap: extraMap);
      return;
    }

    if (adType == AdType.Native) {
      ///原生广告
      Map? extraMap;
      if (config is NativeAdConfig) {
        extraMap = TPNativeManager.createNativeExtraMap( templateHeight: config.width, templateWidth: config.height);
      }
      await TPNativeManager.loadNativeAd(adUnitId, extraMap: extraMap);
      return;
    }

    if (adType == AdType.Reward) {
      ///激励视频
      Map? extraMap;
      if (config is RewardAdConfig) {
        extraMap = TPRewardVideoManager.createRewardVideoExtraMap();
      }
      await TPRewardVideoManager.loadRewardVideoAd(adUnitId, extraMap: extraMap);
      return;
    }

    ///横幅广告
    if (adType == AdType.Banner) {
      Map? extraMap;
      if (config is BannerAdConfig) {
        extraMap = TPBannerManager.createBannerExtraMap(width: config.width, height: config.height);
      }
      await TPBannerManager.loadBannerAd(adUnitId, extraMap: extraMap);
      return;
    }

    throw Exception("暂不支持此广告类型${adType.name}");
  }

  @override
  Future<bool> isAdReady(AdType adType, String adUnitId) async {
    await _checkInit();

    ///根据广告ID把广告类型缓存起来
    _cacheAdTypeByUnitId[adUnitId] = adType;

    if (adType == AdType.Splash) {
      return TPSplashManager.splashAdReady(adUnitId);
    }

    if (adType == AdType.Native) {
      return TPNativeManager.nativeAdReady(adUnitId);
    }

    if (adType == AdType.Reward) {
      return TPRewardVideoManager.rewardVideoAdReady(adUnitId);
    }

    if (adType == AdType.Banner) {
      return TPBannerManager.bannerAdReady(adUnitId);
    }

    return false;
  }

  @override
  Future<bool> showSplashAd(BuildContext context, String adUnitId, {SplashAdConfig? adConfig}) async {
    bool isReady = await isAdReady(AdType.Splash, adUnitId);

    if (isReady) {
      String taskId = _taskId(AdOp.ShowSplash, AdType.Splash, adUnitId);
      if (_adTask.containsKey(taskId)) {
        _completeTask(taskId, false);
      }
      bool hasPop = false;
      Completer completer = _addTask(taskId);

      String? customLayoutClassName = adConfig?.customLayoutClassName;

      if (Platform.isAndroid) {
        ///android 上是个widget
        ///这里改为透明路由,避免某些广告加载不出来黑屏
        Navigator.of(context)
            .push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return WillPopScope(
                      onWillPop: () async => false,
                      child: Scaffold(
                          backgroundColor: adConfig?.backgroundColor ?? Colors.transparent,
                          body: Column(
                            children: [
                              Expanded(
                                  child: TPSplashViewWidget(
                                adUnitId,
                                layoutName: customLayoutClassName,
                              )),
                              adConfig?.androidLogoView ?? Container()
                            ],
                          )));
                }))
            .whenComplete(() {
          ///主动关闭
          if (hasPop == false) {
            hasPop = true;
            _completeTask(taskId, true);
          }
        });
      } else {
        ///iOS是跳转到其它页面
        await TPSplashManager.showSplashAd(adUnitId, className: customLayoutClassName ?? "");
      }
      bool show = await completer.future ?? false;
      _removeTask(taskId);
      if (Platform.isAndroid && hasPop == false) {
        hasPop = true;
        Navigator.of(context).pop();
      }
      return show;
    } else {
      return false;
    }
  }

  @override
  Widget showNativeAd(String adUnitId, {NativeAdConfig? config}) {
    if (config?.customTemplateItems != null) {
      ///自定义模板
      Map<String, Map> extraMap = {};

      for (var item in config!.customTemplateItems!) {
        var attr = item.attr;
        extraMap[item.name] = attr.toMap();
      }
      return TPNativeViewWidget(adUnitId, config.width, config.height, extraMap: extraMap);
    }

    ///使用tradplus的渲染模板
    String layoutName = config?.customLayoutClassName ?? (Platform.isIOS ? "TPNativeTemplate" : "tp_native_ad_list_item");
    return TPNativeViewWidget(adUnitId, config?.width, config?.height, className: layoutName);
  }

  @override
  Future<void> showRewardAd(String adUnitId) {
    return TPRewardVideoManager.showRewardVideoAd(adUnitId);
  }

  @override
  Widget showBannerAd(String adUnitId) {
    return TPBannerViewWidget(adUnitId);
  }
}
