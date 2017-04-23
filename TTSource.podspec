#
#  Be sure to run `pod spec lint TTSource.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TTSource"
  s.version      = "1.0.1"
  s.summary      = " mvc."

  s.description  = <<-DESC
                easy to mvc.
                   DESC

  s.homepage     = "https://github.com/ttayaa/TTSource"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "ttayaa" => "2087154267@qq.com" }

  s.platform     = :ios, "8.0"



  s.source       = { :git => "https://github.com/ttayaa/TTSource.git", :tag => "#{s.version}" }


  s.source_files  = "TTSource/**/*.{h,m,mm}"


   s.resource  = "Sources/**/*.{png,xib,storyboard,plist,der,js,json,strings,imageset,xcassets}"

  s.requires_arc = true


end
