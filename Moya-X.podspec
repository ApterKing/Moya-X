
Pod::Spec.new do |s|
  s.name             = 'Moya-X'
  s.version          = '1.0.0'
  s.summary          = 'Moya extension'

  s.homepage         = 'https://github.com/ApterKing/Moya-X'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ApterKing' => 'wangcccong@outlook.com' }
  s.source           = { :git => 'https://github.com/ApterKing/Moya-X.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.requires_arc = true

  s.subspec 'Core' do |ss|
    ss.source_files = 'Moya-X/Classes/Core/*.swift'
    ss.dependency 'Moya/RxSwift'
  end

  s.subspec 'JSONMappable' do |ss|
    ss.source_files = 'Moya-X/Classes/JSONMappable/*.swift'
    ss.dependency 'Moya/RxSwift'
    ss.dependency 'SwiftyJSON-X'
  end

end
