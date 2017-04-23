Pod::Spec.new do |s|
s.name         = "TTSource"
s.version      = "1.0.0"
s.summary      = "TT库"
s.homepage     = "https://github.com/ttayaa/TTSource"
s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
s.author       = { "ttayaa" => "2087154267@qq.com" }
s.platform     = :ios, '8.0'
s.source       = { :git => 'https://git.oschina.net/ttayaa/TTSource.git', :tag => "1.0.0" }
s.source_files  = 'TTSource/**/*.{h,m,mm}'    #源码
s.requires_arc = true       #是否需要arc

s.vendored_frameworks = 'TTSource/**/*.{framework}'
s.vendored_libraries = 'TTSource/**/*.{a}'         #.a静态库
s.resource = 'Sources/**/*.{png,xib,storyboard,plist,der,js,json,strings,imageset,xcassets}'
# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }


s.subspec 'TTSource' do |ttSource|
    
    ttSource.frameworks = 'CoreTelephony' #TTLunchConfig中的讯飞引用
    ttSource.libraries = 'z'         #TTLunchConfig中的讯飞引用     #.a静态库
    
    ttSource.dependency 'Masonry'  #TTControllerCategory
    
    ttSource.dependency 'BaiduMapAPI'
    ttSource.dependency 'AliPay'
    ttSource.dependency 'UMengUShare/UI'
    ttSource.dependency 'UMengUShare/Social/Sina'
    ttSource.dependency 'UMengUShare/Social/WeChat'
    ttSource.dependency 'UMengUShare/Social/QQ'
    ttSource.dependency 'UMengUShare/Social/SMS'
    ttSource.dependency 'UMengUShare/Social/TencentWeibo'
    
end





