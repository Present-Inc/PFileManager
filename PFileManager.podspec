Pod::Spec.new do |s|
  s.name         = "PFileManager"
  s.version      = "0.0.1"
  s.summary      = "iOS File Manager wrapper"

  s.description  = <<-DESC
                   "An iOS File Manager wrapper that gets rid of a lot of boiler plate."
                   DESC

  s.homepage     = "http://github.com/Present-Inc/PFileManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "justinmakaila" => "justinmakaila@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Present-Inc/PFileManager.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "PFileManager/PFileManager/*.{h,m}"
  s.requires_arc = true
end
