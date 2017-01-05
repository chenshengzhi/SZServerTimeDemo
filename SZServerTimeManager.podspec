
Pod::Spec.new do |s|

  s.name         = "SZServerTimeManager"
  s.version      = "0.0.1"
  s.summary      = "Server Time Manager"
  s.homepage     = "https://github.com/chenshengzhi"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "chenshengzhi" => "329012084@qq.com" }
  s.source       = { :git => "https://github.com/chenshengzhi/SZServerTimeDemo.git", :tag => s.version.to_s }
  s.source_files = "SZServerTimeManager", "SZServerTimeManager/*.{h,m}"

end
