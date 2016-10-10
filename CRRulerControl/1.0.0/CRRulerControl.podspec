Pod::Spec.new do |s|

s.name              = "CRRulerControl"
s.version           = "1.0.0"
s.summary           = "A CocoaPod that simplifies the process of setting and reading values from the ruler. Supplied with UIControl subclass."
s.description       = <<-DESC
A CocoaPod that simplifies the process of setting and reading values from the ruler. Supplied with UIControl subclass.
DESC

s.homepage          = "https://github.com/Cleveroad/CRRulerControl"
s.screenshots       = "https://raw.githubusercontent.com/Cleveroad/CRRulerControl/master/images/header.jpg", "https://raw.githubusercontent.com/Cleveroad/CRRulerControl/master/images/demo.gif"
s.license           = "MIT"
s.author            = { "Sergey" => "Chuchukalo.cr@gmail.com" }
s.source            = { :git => "https://github.com/Cleveroad/CRRulerControl.git", :tag => "1.0.0" }
s.platform          = :ios, "8.0"
s.requires_arc      = true
s.source_files      = 'CRRulerControl/Classes/**/*.{h,m}'

end