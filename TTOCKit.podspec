#
#  Be sure to run `pod spec lint TTSource.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "TTOCKit"
    s.version      = "1.0.8"
    s.summary      = " mvc."
    s.description  = <<-DESC
                easy to mvc.
                   DESC
    s.homepage     = "https://github.com/ttayaa/TTOCKit"
    s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author       = { "ttayaa" => "2087154267@qq.com" }
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/ttayaa/TTOCKit.git", :tag => "v#{s.version}" }
    s.source_files  = "TTOCKit/**/*.{h,m,mm}"
    
    s.resource  = "TTOCKit/**/*.{png,xib,storyboard,plist,der,js,json,strings,imageset,xcassets}"
    s.requires_arc = true
    
    
    s.source_files = 'TTOCKit/TTOCKitHeader/TTOCKitConfig.h'
    
    
    s.subspec 'TTControllerCategory' do |ss|
        ss.source_files = 'TTOCKit/TTControllerCategory/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTMVVM' do |ss|
        ss.source_files = 'TTOCKit/TTMVVM/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTTools' do |ss|
        ss.source_files = 'TTOCKit/TTTools/TTTools.h'
        
        
        ss.subspec 'TTBtnArrSelected' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTBtnArrSelected/**/*.{h,m,mm}'

        end
        ss.subspec 'TTQRScanController' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTQRScanController/**/*.{h,m,mm}'

        end
        ss.subspec 'TTPhotoBrowser' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTPhotoBrowser/**/*.{h,m,mm}'
            sss.dependency 'SDWebImage'
        end
        ss.subspec 'TTNSStringCategory' do |sss|
             sss.source_files = 'TTOCKit/TTTools/TTNSStringCategory/**/*.{h,m,mm}'
        end
        ss.subspec 'TTPlaceholderPlace' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTPlaceholderPlace/**/*.{h,m,mm}'

        end
        ss.subspec 'TTNumberTF' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTNumberTF/**/*.{h,m,mm}'

        end
        ss.subspec 'TTProgress' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTProgress/**/*.{h,m,mm}'

        end
        ss.subspec 'TTLimitTextField' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTLimitTextField/**/*.{h,m,mm}'

        end
        ss.subspec 'TTAlertView' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTAlertView/**/*.{h,m,mm}'

        end
        ss.subspec 'TTWebView' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTWebView/**/*.{h,m,mm}'

        end
        ss.subspec 'TTLogVcDealloc' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTLogVcDealloc/**/*.{h,m,mm}'

        end
        ss.subspec 'TTButtonInnerRect' do |sss|
            sss.source_files = 'TTOCKit/TTTools/TTButtonInnerRect/**/*.{h,m,mm}'

        end
    end
    
    s.subspec 'TTNetwork' do |ss|
        ss.source_files = 'TTOCKit/TTNetwork/**/*.{h,m,mm}'
        ss.dependency 'AFNetworking'
        ss.dependency 'YYModel'
    end
    
    s.subspec 'TTSignal' do |ss|
        ss.source_files = 'TTOCKit/TTSignal/**/*.{h,m,mm}'
    end
    
    s.subspec 'TTRouter' do |ss|
        ss.source_files = 'TTOCKit/TTRouter/**/*.{h,m,mm}'
        ss.dependency 'YYModel'
    end
    
    

end
