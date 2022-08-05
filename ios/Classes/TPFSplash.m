//
//  TPFSplash.m
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/19.
//

#import "TPFSplash.h"

#import <TradPlusAds/TradPlusAds.h>
#import "TradplusSdkPlugin.h"

@interface TPFSplash()<TradPlusADSplashDelegate>

@property (nonatomic,strong)TradPlusAdSplash *splash;
@end

@implementation TPFSplash

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.splash = [[TradPlusAdSplash alloc] init];
        self.splash.delegate = self;
    }
    return self;
}

- (void)setAdUnitID:(NSString * _Nonnull)adUnitID
{
    MSLogTrace(@"%s adUnitID:%@", __PRETTY_FUNCTION__,adUnitID);
    [self.splash setAdUnitID:adUnitID];
}

- (void)setCustomMap:(NSDictionary *)dic
{
    MSLogTrace(@"%s dic:%@", __PRETTY_FUNCTION__,dic);
    id segmentTag = dic[@"segment_tag"];
    if([segmentTag isKindOfClass:[NSString class]])
    {
        self.splash.segmentTag = segmentTag;
    }
    self.splash.dicCustomValue = dic;
}

- (void)loadAd
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    [self.splash loadAdWithWindow:[MsCommon getTopWindow] bottomView:nil];
}

- (void)showAd
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    [self.splash show];
}

- (BOOL)isAdReady
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    return self.splash.isAdReady;
}

- (NSString *)eventName:(NSString *)event
{
    return [NSString stringWithFormat:@"splash_%@",event];
}

#pragma mark - TradPlusADSplashDelegate

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpSplashAdLoaded:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"loaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///AD加载失败
///tpSplashAdOneLayerLoad:didFailWithError：返回三方源的错误信息
- (void)tpSplashAdLoadFailWithError:(NSError *)error
{
    MSLogInfo(@"%s error:%@", __PRETTY_FUNCTION__, error);
    NSString *eventNam = [self eventName:@"loadFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:nil error:error];
}

///AD展现
- (void)tpSplashAdImpression:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"impression"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///AD展现失败
- (void)tpSplashAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"showFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:error];
}

///AD被点击
- (void)tpSplashAdClicked:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"clicked"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///AD关闭
- (void)tpSplashAdDismissed:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"closed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///v7.6.0+新增 开始加载流程
- (void)tpSplashAdStartLoad:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"startLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpSplashAdLoadStart:(NSDictionary *)adInfo;
- (void)tpSplashAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerStartLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///bidding开始
- (void)tpSplashAdBidStart:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"bidStart"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///bidding结束 error = nil 表示成功
- (void)tpSplashAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    MSLogInfo(@"%s adInfo:%@ error:%@", __PRETTY_FUNCTION__, adInfo,error);
    NSString *eventNam = [self eventName:@"bidEnd"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:error];
}

///当每个广告源加载成功后会都会回调一次。
- (void)tpSplashAdOneLayerLoaded:(NSDictionary *)adInfo
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:nil];
}

///当每个广告源加载失败后会都会回调一次，返回三方源的错误信息
- (void)tpSplashAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogInfo(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoadedFail"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:adInfo error:error];
}

///加载流程全部结束
- (void)tpSplashAdAllLoaded:(BOOL)success
{
    MSLogInfo(@"%s success:%@", __PRETTY_FUNCTION__, @(success));
    NSString *eventNam = [self eventName:@"allLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.splash.unitID adInfo:nil error:nil exp:@{@"success":@(success)}];
}
@end