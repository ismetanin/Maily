Pod::Spec.new do |s|
  s.name = "Maily"
  s.version = "1.0.0"
  s.summary = "Library that helps you send email with standard mail client or third party mail clients"
  s.homepage = "https://github.com/ismetanin/Maily"
  s.license = "MIT"
  s.author = { "Ivan Smetanin" => "smetanin23@yandex.ru" }
  s.source = { :git => "https://github.com/ismetanin/Maily.git", :tag => s.version }

  s.source_files = 'Maily/**/*.swift'
  s.framework = 'UIKit'
  s.ios.deployment_target = '10.0'
  s.swift_version = '5'

end
