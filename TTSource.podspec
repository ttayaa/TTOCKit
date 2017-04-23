#
#  Be sure to run `pod spec lint TTSource.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "TTSource"
    s.version      = "1.0.2"
    s.summary      = " mvc."

    s.description  = <<-DESC
                easy to mvc.
                   DESC
 
    s.homepage     = "https://github.com/ttayaa/TTSource"

    s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


    s.author       = { "ttayaa" => "2087154267@qq.com" }

    s.platform     = :ios, "8.0"



    s.source       = { :git => "https://github.com/ttayaa/TTSource.git", :tag => "#{s.version}" }


    s.source_files  = "TTSource/**/*.{h,m,mm}"


    s.resource  = "TTSource/**/*.{png,xib,storyboard,plist,der,js,json,strings,imageset,xcassets}"

    s.requires_arc = true

    s.subspec 'TTSource' do |ttSource|
    
    
        ttSource.dependency 'Masonry'  #TTControllerCategory
    
        #TTLunchConfig
        ttSource.frameworks = 'CoreTelephony' #讯飞SDK
        ttSource.libraries = 'z'  #, 'bz2.1.0' #lib            #讯飞SDK
        ttSource.dependency 'BaiduMapAPI'
        ttSource.dependency 'AliPay', '~> 2.1.2'
        ttSource.dependency 'UMengUShare/UI'
        ttSource.dependency 'UMengUShare/Social/Sina'
        ttSource.dependency 'UMengUShare/Social/WeChat'
        ttSource.dependency 'UMengUShare/Social/QQ'
        ttSource.dependency 'UMengUShare/Social/SMS'
        ttSource.dependency 'UMengUShare/Social/TencentWeibo'
    
    end
    

end
