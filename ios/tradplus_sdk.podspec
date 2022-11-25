#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tradplus_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tradplus_sdk'
  s.version          = '1.0.3'
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
  s.static_framework = true
  
  s.frameworks = 'NetworkExtension','DeviceCheck'

  s.pod_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lObjC']}
  
  s.libraries = 'c++', 'z', 'sqlite3', 'xml2', 'resolv', 'bz2.1.0','bz2','xml2','resolv.9','iconv','c++abi'

  s.vendored_frameworks = 'TradPlusFrameworks/**/*.framework'
  
  s.vendored_libraries = ['TradPlusFrameworks/GDTMob/GDTSDK/*.a','TradPlusFrameworks/Kidoz/KidozSDK/*.a','TradPlusFrameworks/YouDao/YDSDK/*.a',]
  
  s.resources = ['TradPlusFrameworks/**/*.bundle',"Assets/**/*"]


#   广告集成情况
#   AdMob
#   Meta
#   Pangle
#   TencentAds
#   CSJ
#   KuaiShou
#   Klevin
#   mintegral

  s.dependency 'TradPlusAdSDK', '8.3.20'
  s.dependency 'TradPlusAdSDK/FacebookAdapter', '8.3.20'
  s.dependency 'FBAudienceNetwork','6.11.2'
  s.dependency 'TradPlusAdSDK/AdMobAdapter', '8.3.20'
  s.dependency 'Google-Mobile-Ads-SDK','9.11.0'
  s.dependency 'TradPlusAdSDK/MintegralAdapter', '8.3.20'
  s.dependency 'MintegralAdSDK' ,'7.2.1'
  s.dependency 'MintegralAdSDK/All','7.2.1'
  s.dependency 'TradPlusAdSDK/KuaiShouAdapter', '8.3.20'
  s.dependency 'KSAdSDK', '3.3.32'
  s.dependency 'TradPlusAdSDK/GDTMobAdapter', '8.3.20'
  s.dependency 'GDTMobSDK', '4.13.90'
  s.dependency 'TradPlusAdSDK/PangleAdapter', '8.3.20'
  s.dependency 'Ads-Global/BUAdSDK_Compatible', '4.7.0.6'
  s.dependency 'TradPlusAdSDK/KlevinAdapter', '8.3.20'
  s.dependency 'KlevinAdSDK','2.9.1.207'
  s.dependency 'TradPlusAdSDK/TPCrossAdapter', '8.3.20'
  s.dependency 'TradPlusAdSDK/PangleAdapter', '8.3.20'
  s.dependency 'Ads-CN/BUAdSDK_Compatible', '4.8.0.8'


  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
end
