#
# Be sure to run `pod lib lint HYComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYComponents'
  s.version          = '0.1.3'
  s.summary          = '各种组件封装'
  s.swift_version    = '5.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 掌上公交所有的组件库.
                       DESC

  s.homepage         = 'https://github.com/hengyudianzi/HYComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hengyudianzi' => 'sdhy_dz@163.com' }
  s.source           = { :git => 'https://github.com/hengyudianzi/HYComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.platform     = :ios, "13.0"
  s.ios.deployment_target = '13.0'
  s.static_framework = true
  s.source_files = 'HYComponents/Classes/**/*'
#  s.resource = ['HYComponents/Classes/Res/ImagesRes.bundle']
#  s.resources = ['HYComponents/Classes/Res/*']
#/Users/sdch/Desktop/HYProject/Modules/HYComponents/HYComponents/Classes/Res

  s.resource_bundles = {
    'HYComponents' => ['HYComponents/Assets/*']
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency  'Masonry','~>1.1.0'
  s.dependency  'Alamofire','~>4.9.1'
  s.dependency  'CLToast'
  s.dependency  'SnapKit'
  s.dependency  'HandyJSON'
  s.dependency  'MJRefresh'
  s.dependency  'PGDatePicker','~>2.6.9'

end
