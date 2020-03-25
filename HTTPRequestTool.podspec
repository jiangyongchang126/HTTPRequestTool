
Pod::Spec.new do |s|

  s.name         = "HTTPRequestTool"
  s.version      = "0.0.2"
  s.summary      = "A short description of HTTPRequestTool."
  s.description  = "a HTTPRequestTool repository demo" 
  s.homepage     = "https://github.com/jiangyongchang126/HTTPRequestTool"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "jianggongzi" => "jiang_yongchang@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/jiangyongchang126/HTTPRequestTool.git", :tag => "0.0.2" }
  s.source_files  =  "HTTPRequestTool/HTTPRequestTool/Http/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.frameworks = "Foundation","UIKit"
  s.public_header_files = "HTTPRequestTool/Http/HttpRequestHeader.h"
  s.dependency "AFNetworking", "~> 3.2.1"  
  s.dependency "MBProgressHUD", "~> 1.1.0"

end
