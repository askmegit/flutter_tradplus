#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tradplus_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tradplus_sdk'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
Tradplus SDK Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  
  s.frameworks = 'NetworkExtension'

  s.pod_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lObjC']}
  
  s.libraries = 'c++', 'z', 'sqlite3', 'xml2', 'resolv', 'bz2.1.0','bz2','xml2','resolv.9','iconv','c++abi'

  s.vendored_frameworks = 'TradPlusFrameworks/**/*.framework'
  
  s.vendored_libraries = ['TradPlusFrameworks/GDTMob/GDTSDK/*.a','TradPlusFrameworks/Kidoz/KidozSDK/*.a','TradPlusFrameworks/YouDao/YDSDK/*.a',]
  
  s.resources = ['TradPlusFrameworks/**/*.bundle',"Assets/**/*"]

    s.dependency 'TradPlusAdSDK', '7.9.0'
    s.dependency 'TradPlusAdSDK/FacebookAdapter', '7.9.0'
    s.dependency 'FBAudienceNetwork','6.11.2'
    s.dependency 'TradPlusAdSDK/AdMobAdapter', '7.9.0'
    s.dependency 'Google-Mobile-Ads-SDK','9.7.0'
    s.dependency 'TradPlusAdSDK/UnityAdapter', '7.9.0'
    s.dependency 'UnityAds','4.2.1'
    s.dependency 'TradPlusAdSDK/AppLovinAdapter', '7.9.0'
    s.dependency 'AppLovinSDK','11.4.3'
    s.dependency 'TradPlusAdSDK/TapjoyAdapter', '7.9.0'
    s.dependency 'TapjoySDK','12.10.0'
    s.dependency 'TradPlusAdSDK/VungleAdapter', '7.9.0'
    s.dependency 'VungleSDK-iOS', '6.11.0'
    s.dependency 'TradPlusAdSDK/IronSourceAdapter', '7.9.0'
    s.dependency 'IronSourceSDK','7.2.3.1'
    s.dependency 'TradPlusAdSDK/AdColonyAdapter', '7.9.0'
    s.dependency 'AdColony','4.9.0'
    s.dependency 'TradPlusAdSDK/InMobiAdapter', '7.9.0'
    s.dependency 'InMobiSDK/Core' ,'10.0.8'
    s.dependency 'TradPlusAdSDK/MintegralAdapter', '7.9.0'
    s.dependency 'MintegralAdSDK' ,'7.1.8.0'
    s.dependency 'MintegralAdSDK/All','7.1.8.0'
    s.dependency 'TradPlusAdSDK/PangleAdapter', '7.9.0'
    s.dependency 'Ads-CN/International', '4.6.0.7'
    s.dependency 'Ads-CN/BUAdSDK', '4.6.0.7'
    s.dependency 'TradPlusAdSDK/SmaatoAdapter', '7.9.0'
    s.dependency 'smaato-ios-sdk', '21.7.6'
    s.dependency 'smaato-ios-sdk/Banner', '21.7.6'
    s.dependency 'smaato-ios-sdk/Interstitial', '21.7.6'
    s.dependency 'smaato-ios-sdk/RewardedAds', '21.7.6'
    s.dependency 'TradPlusAdSDK/GDTMobAdapter', '7.9.0'
    s.dependency 'GDTMobSDK', '4.13.81'

  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'armv7 arm64' }
end
