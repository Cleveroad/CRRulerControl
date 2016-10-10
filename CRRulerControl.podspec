Pod::Spec.new do |s|

s.name         = "CRRulerControl"
s.version      = "1.0.0"
s.summary      = "A CocoaPod that simplifies the process of setting and reading values from the ruler. Supplied with UIControl subclass."

s.homepage     = "https://github.com/Cleveroad/CRRulerControl"
s.screenshots  = "https://raw.githubusercontent.com/Cleveroad/CRRulerControl/master/images/header.jpg", "https://raw.githubusercontent.com/Cleveroad/CRRulerControl/master/images/demo.gif"
s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }


s.author             = { "Sergey" => "Chuchukalo.cr@gmail.com" }
s.platform     = :ios
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/Cleveroad/CRRulerControl.git", :tag => "1.0.0" }

s.source_files  = "CRMark{h,m}", "CRRulerControl{h,m}", "CRRulerLayer{h,m}"
s.public_header_files = "CRRulerControl.h"
end
