Pod::Spec.new do |s|

  s.name         = "category"
  s.version      = "0.0.1"
  s.summary      = "A demo of category."
  s.description  = "A demo of zujianhua. I just want to test"

  s.homepage     = "https://github.com/fzq2016/category.git"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "fzq2016" => "3029778489@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/fzq2016/category.git", :tag => "#{s.version}" }
  s.source_files  = "OC/**/*.{h,m}"

end
