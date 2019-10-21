Pod::Spec.new do |s|
  s.name             = 'WBNoDataView'
  s.version          = '1.0.0'
  s.summary          = 'tableView以及collectionView没数据默认图，支持自定义图片，自定义问题，设置图片大小'
  s.description      = <<-DESC
TODO: "tableView以及collectionView没数据默认图，支持自定义图片，自定义问题，设置图片大小".
                       DESC

  s.homepage         = 'https://github.com/wangbo1185742894/WBNoDataView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangbo1185742894' => 'wangbo3919@163.com' }
  s.source           = { :git => 'https://github.com/wangbo1185742894/WBNoDataView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'WBNoDataView/Classes/WBNoDataView/*'
  
  # s.resource_bundles = {
  #   'WBNoDataView' => ['WBNoDataView/Assets/*.png']
  # }

  #s.public_header_files = 'Pod/Classes/WBNoDataView/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'MJRefresh', '~> 3.1.0'

  s.static_framework = true
end
