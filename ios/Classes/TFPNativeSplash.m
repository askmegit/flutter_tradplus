//
//  TFPNativeSplash.m
//  tradplus_sdk
//
//  Created by Mac_BigSur on 2022/11/24.
//

#import "TFPNativeSplash.h"
#import <TradPlusAds/TradPlusAds.h>
#import <TradPlusAds/TradPlusNativeSplash.h>
#import "TradplusSdkPlugin.h"



@interface TFPNativeSplash()<TradPlusADNativeDelegate>

@property (nonatomic,strong)TradPlusNativeSplash *nativeSplash;
@end


@implementation TFPNativeSplash






- (BOOL)isAdReady
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    return self.nativeSplash.isAdReady;
}


@end
