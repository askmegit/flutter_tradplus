#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `s.dependency lib lint tradplus_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tradplus_sdk'
  s.version          = '1.1.6'
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
  s.platform = :ios, '12.0'
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

  s.dependency 'TradPlusAdSDK', '12.0.0'
  s.dependency 'TradPlusAdSDK/FacebookAdapter', '12.0.0'
  s.dependency 'FBAudienceNetwork','6.15.1'
  s.dependency 'TradPlusAdSDK/AdMobAdapter', '12.0.0'
  s.dependency 'Google-Mobile-Ads-SDK','11.7.0'
  s.dependency 'TradPlusAdSDK/MintegralAdapter', '12.0.0'
  s.dependency 'MintegralAdSDK' ,'7.6.9'
  s.dependency 'MintegralAdSDK/All','7.6.9'
  s.dependency 'TradPlusAdSDK/KuaiShouAdapter', '12.0.0'
  s.dependency 'KSAdSDK', '3.3.66.3'
  s.dependency 'TradPlusAdSDK/GDTMobAdapter', '12.0.0'
  s.dependency 'GDTMobSDK', '4.14.90'
#   s.dependency 'TradPlusAdSDK/KlevinAdapter', '8.7.0'
#   s.dependency 'KlevinAdSDK','2.11.0.215'
  s.dependency 'TradPlusAdSDK/TPCrossAdapter', '12.0.0'
#   s.dependency 'TradPlusAdSDK/PangleAdapter', '12.0.0'
#   s.dependency 'Ads-CN/BUAdSDK_Compatible', '4.9.0.7'




  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 arm64' }
end
