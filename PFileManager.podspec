Pod::Spec.new do |s|
  s.name         = "PFileManager"
  s.version      = "0.0.1"
  s.summary      = "A short description of PFileManager."

  s.description  = <<-DESC
                   A longer description of PFileManager in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://github.com/Present-Inc/PFileManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "justinmakaila" => "justinmakaila@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "http://github.com/Present-Inc/PFileManager.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "PFileManager/PFileManager/*.{h,m}"
end
