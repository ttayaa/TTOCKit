#
#  Be sure to run `pod spec lint TTSource.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "TTSource"
    s.version      = "1.0.3"
    s.summary      = " mvc."
    s.description  = <<-DESC
                easy to mvc.
                   DESC
    s.homepage     = "https://github.com/ttayaa/TTSource"
    s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author       = { "ttayaa" => "2087154267@qq.com" }
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://git.oschina.net/ttayaa/ttsource.git", :tag => "v#{s.version}" }
    #s.source_files  = "TTSource/**/*.{h,m,mm}"
    
    s.resource  = "TTSource/**/*.{png,xib,storyboard,plist,der,js,json,strings,imageset,xcassets}"
    s.requires_arc = true
    
    
    s.source_files = 'TTSource/TTSourceConfig.h'
    
    
    s.subspec 'TTCategory' do |ss|
        ss.source_files = 'TTSource/TTCategory/**/*.{h,m,mm}'
        ss.dependency 'Masonry'
    end
    
    s.subspec 'TTControllerCategory' do |ss|
        ss.source_files = 'TTSource/TTControllerCategory/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTMacros(宏)' do |ss|
        ss.source_files = 'TTSource/TTMacros(宏)/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTMVC' do |ss|
        ss.source_files = 'TTSource/TTMVC/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTMVC2' do |ss|
        ss.source_files = 'TTSource/TTMVC2/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTRefresh' do |ss|
        ss.source_files = 'TTSource/TTRefresh/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTTools(工具类)' do |ss|
        ss.source_files = 'TTSource/TTTools(工具类)/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTTransitions' do |ss|
        ss.source_files = 'TTSource/TTTransitions/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTUI' do |ss|
        ss.source_files = 'TTSource/TTUI/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTView' do |ss|
        ss.source_files = 'TTSource/TTView/**/*.{h,m,mm}'
    end
    
    

end
