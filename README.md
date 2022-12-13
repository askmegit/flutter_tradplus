# tradplus_flutter_sdk

# fork https://github.com/tradplus/flutter_demo

# 当前版本1.0.4 [https://docs.tradplusad.com/docs/integration_flutter/download_flutter]

# android 8.8.0.1

# iOS 8.5.0

# 修改了原SDK中Android部分的代码,主要是把依赖由example改到了插件中,这样业务方只需要依赖此SDK即可,无需其它配置操作

# 注意事项

1、android广告源区分了国内和国外,可以通过在宿主工程android项目下的gradle.properties中进行如下配置

## 0海外 1国内

isReleaseOnGP = 1

2、iOS14.5之后需要明确获取IDFA,在获取不到的时候需要配置启用SKAdNetwork跟踪转化 具体参考SKAdNetworkIdentifier文件进行配置
目前已知Smaato渠道在SKAdNetworkItems超过320条时无法正常加载广告 最后更新日期：2022年09月23日

配置说明参考
Android：https://docs.tradplusad.com/docs/tradplussdk_android_doc_v6/tradplussdk_android_doc_v6/android_config
基于当前版本的各类配置信息已经在库中进行了配置 没有配置的如下 

3、如果用到AdMob需要配置AppId(ca-app-pub-xxx)(注意是AdMob的)
,获取地址https://apps.admob.com
iOS如下
<key>GADApplicationIdentifier</key>
<string>xxxx</string>

Android如下
<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID"
android:value="xxxx"/>

4、如果用到Applovin需要配置SDK_KEY，在TP后台配置即可,现在的版本已支持TP下发

