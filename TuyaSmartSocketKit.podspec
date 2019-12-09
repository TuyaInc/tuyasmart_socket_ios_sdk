Pod::Spec.new do |s|
  s.name             = 'TuyaSmartSocketKit'
  s.version          = '1.0.2'
  s.summary          = 'TuyaSmartSocketKit is iOS developer tool using tuyayun to iclond connect.'
  s.description      = <<-DESC
TuyaSmartSocketKit is iOS developer tool using tuyayun to iclond connect.
                       DESC
  s.homepage         = 'https://github.com/TuyaInc/tuyasmart_socket_ios_sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WenMingYan' => 'wenmy@tuya.com' }
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/*.framework'
  
  s.ios.deployment_target = '8.0'
  s.dependency 'CocoaAsyncSocket'
end
