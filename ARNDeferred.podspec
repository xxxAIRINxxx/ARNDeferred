Pod::Spec.new do |s|
  s.name         = "ARNDeferred"
  s.version      = "0.1.0"
  s.summary      = "implementation of futures and promises and jQuery.Deferred."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/xxxAIRINxxx/ARNDeferred"
  s.author       = { "xxxAIRINxxx" => "xl1138@gmail.com" }
  s.source       = { :git => "https://github.com/xxxAIRINxxx/ARNDeferred.git", :tag => "#{s.version}" }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'ARNDeferred/*.{h,m}'
end
