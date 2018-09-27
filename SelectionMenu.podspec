#
# Be sure to run `pod lib lint SelectionMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SelectionMenu'
  s.version          = '0.1.1'
  s.summary          = 'Overlay menu supporting both buttons and option selection'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Overlay menu with customizable appearance and variation of content sections.
It allows to present single-selection, multi-selection or button-like rows.
                       DESC

  s.homepage         = 'https://github.com/ntvr/SelectionMenu'
  s.screenshots     = 'https://raw.githubusercontent.com/ntvr/SelectionMenu/master/Screenshots/Menu_screenshots/Red_leftBottom_rightTop.png',
                      'https://raw.githubusercontent.com/ntvr/SelectionMenu/master/Screenshots/Menu_screenshots/Green_rightBottom_rightTop.png',
                      'https://raw.githubusercontent.com/ntvr/SelectionMenu/master/Screenshots/Menu_screenshots/Blue_leftBottom_rightBottom.png',
                      'https://raw.githubusercontent.com/ntvr/SelectionMenu/master/Screenshots/Menu_screenshots/White_rightBottom_leftTop.png',
                      'https://raw.githubusercontent.com/ntvr/SelectionMenu/master/Screenshots/Menu_screenshots/Black_center_centerDown.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'stemberamichal' => 'stembera.michal@gmail.com' }
  s.source           = { :git => 'https://github.com/ntvr/SelectionMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'

  s.source_files = 'SelectionMenu/Source/**/*'
  
  # s.resource_bundles = {
  #   'SelectionMenu' => ['SelectionMenu/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
   s.dependency 'SnapKit', '~> 4'
end
