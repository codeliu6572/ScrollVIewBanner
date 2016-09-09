

Pod::Spec.new do |s|

  s.name         = "LHHTopScrollView"
  s.version      = "0.0.1"
  s.summary      = "A banner for iOS."

  s.homepage     = "http://blog.csdn.net/codingfire/article/details/52470802"


 
  s.license      = "MIT"


  s.author       = { "codeliu6572" => "codeliu6572@163.com" }

  s.source       = { :git => "https://github.com/codeliu6572/ScrollVIewBanner.git", :tag => "0.0.1" }


 
  s.source_files  = "LHHTopScrollView", "LHHTopScrollView/**/*.{h,m}"


  s.resources = "LHHTopScrollView/*.png"

  s.framework  = "UIKit"
  s.requires_arc = true

  s.dependency 'SDWebImage'

end
