#
#  Be sure to run `pod spec lint HTTPRequestTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "HTTPRequestTool"
  s.version      = "0.0.1"
  s.summary      = "A short description of HTTPRequestTool."
  s.description  = "a HTTPRequestTool repository demo"  #描述
  s.homepage     = "https://github.com/jiangyongchang126/HTTPRequestTool"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "jianggongzi" => "jiang_yongchang@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/jiangyongchang126/HTTPRequestTool.git", :tag => "0.0.1" }
  s.source_files  =  "HTTPRequestTool/Http/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.public_header_files = "HTTPRequestTool/Http/HttpRequestHeader.h"
  s.dependency "AFNetworking", "~> 3.2.1"
  s.dependency "MBProgressHUD", "~> 1.1.0"

end
