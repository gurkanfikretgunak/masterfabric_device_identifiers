Pod::Spec.new do |s|
  s.name             = 'masterfabric_device_identifiers'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin that provides unique device identifiers for Android and iOS.'
  s.description      = <<-DESC
A Flutter plugin that provides unique device identifiers for Android and iOS platforms.
                       DESC
  s.homepage         = 'https://github.com/gurkanfikretgunak/device_identifiers'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
