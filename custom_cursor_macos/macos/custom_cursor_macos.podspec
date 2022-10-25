#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint custom_cursor.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'custom_cursor_macos'
  s.version          = '0.0.1'
  s.summary          = 'macOS implementation of the custom_cursor plugin.'
  s.description      = <<-DESC
Provides access to additional data types from NSClipboard via a method channel.
                       DESC
  s.homepage         = 'http://github.com/BringingFire/custom_cursor'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bringing Fire' => 'engineering@bringingfire.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
