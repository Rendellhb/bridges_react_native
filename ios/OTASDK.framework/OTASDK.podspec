#
# Be sure to run `pod lib lint OTASDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OTASDK'
  s.version          = '3.11.4'
  s.summary          = 'OTA keys iOS SDK'
  s.description      = 'iOS SDK for interacting with the OTA keys middleware and Car-sharing module (CSM)'
  s.homepage         = 'https://www.otakeys.com/'
  s.license          = { :type => 'Proprietary software', :text => <<-LICENSE
    Proprietary software
    LICENSE
    }
  s.author           = { 'Sébastien Kalb' => 'sebastien@otakeys.com' }
  s.source           = { :http => 'www.otakeys.com' }
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.vendored_frameworks = 'OTASDK.framework' 
  s.frameworks = 'CoreBluetooth', 'CoreData'
end
