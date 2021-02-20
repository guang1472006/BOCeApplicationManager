#
# Be sure to run `pod lib lint BOCeApplicationManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BOCeApplicationManager'
  s.version          = '0.0.1'
  s.summary          = 'zhangwenxue'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'BOCE P2C Lunch'

  s.homepage         = 'https://github.com/guang1472006/BOCeApplicationManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '734781246@qq.com' => '734781246@qq.com' }
  s.source           = { :git => 'https://github.com/guang1472006/BOCeApplicationManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BOCeApplicationManager/Classes/*'
  
  s.resource_bundles = {
      'BOCeApplicationManager' => ['BOCeApplicationManager/Assets/*.plist']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.static_framework = true
  
  s.dependency 'BOCeUpImageManager'
  
  # BOCeStart
  s.subspec 'BOCeStart' do | start |
  start.source_files = 'BOCeApplicationManager/Classes/BOCeStart/*.{h,m}'
  start.dependency 'Appirater', '~> 2.3.1'
  end
  
  # BOCeUpdate
  s.subspec 'BOCeUpdate' do | update |
  update.source_files = 'BOCeApplicationManager/Classes/BOCeUpdate/*.{h,m}'
  end
  
  # BOCeAnimated
  s.subspec 'BOCeAnimated' do | animated |
  animated.source_files = 'BOCeApplicationManager/Classes/BOCeAnimated/*.{h,m}'
  animated.dependency 'TABAnimated', '~> 2.5.1'
  end
  
  # BOCeContoller
  s.subspec 'BOCeContoller' do | contoller |
  contoller.source_files = 'BOCeApplicationManager/Classes/BOCeContoller/*.{h,m}'
  contoller.dependency 'WMZDialog', '~> 1.2.0'
  contoller.dependency 'UMengAnalytics-NO-IDFA', '~> 4.2.5'
  contoller.dependency 'AEGuideView', '~> 1.1.0'
  contoller.dependency 'SVGKit', '~> 3.0.0-beta3'
  end
  
  # BOCePay
  s.subspec 'BOCePay' do | pay |
  pay.source_files = 'BOCeApplicationManager/Classes/BOCePay/*.{h,m}'
  pay.dependency 'AlipaySDK-iOS', '~> 15.7.9'
  pay.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChatFull','~> 4.3.15'
  end
  
  # BOCePush
  s.subspec 'BOCePush' do | push |
  push.source_files = 'BOCeApplicationManager/Classes/BOCePush/*.{h,m}'
  push.dependency 'JPush', '~>3.3.6'
  end
  
  # BOCeShare
  s.subspec 'BOCeShare' do | share |
  share.source_files = 'BOCeApplicationManager/Classes/BOCeShare/*.{h,m}'
  share.dependency 'mob_sharesdk','~> 4.3.15'
  share.dependency 'mob_sharesdk/ShareSDKUI','~> 4.3.15'
  share.dependency 'mob_sharesdk/ShareSDKExtension','~> 4.3.15'
  share.dependency 'mob_sharesdk/ShareSDKPlatforms/QQ','~> 4.3.15'
  share.dependency 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo','~> 4.3.15'
  share.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChatFull','~> 4.3.15'
  end
  
  # BOCeRP
  s.subspec 'BOCeRP' do | rp |
  rp.source_files = 'BOCeApplicationManager/Classes/BOCeRP/*.{h,m}'
  rp.dependency 'AlicloudRPSDK', '3.6.0'
  rp.dependency 'AlicloudSGSecurityBody', '5.4.12987657-rp'
  end
  
end
