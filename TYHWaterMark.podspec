#
# Be sure to run `pod lib lint TYHWaterMark.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TYHWaterMark'
  s.version          = '0.1.3'
  s.summary          = 'A short description of TYHWaterMark.'

  s.description      = <<-DESC
    Add water mark for iOS app without blocking system presented vc (UIImagePickerViewController)
                       DESC

  s.homepage         = 'https://github.com/pencilCool/TYHWaterMark'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pencilCool' => 'yhtangcoder@gmail.com' }
  s.source           = { :git => 'https://github.com/pencilCool/TYHWaterMark.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'TYHWaterMark/Classes/**/*'
  s.frameworks = 'UIKit'
end
