Pod::Spec.new do |s|
  s.name         = "MessagesTableViewController"
  s.version      = "0.0.1"
  s.summary      = "A messages UI for iPhone and iPad.."
  s.homepage     = "https://github.com/jessesquires/MessagesTableViewController"
  s.license      = 'MIT License'
  s.author       = { "Jesse Squires" => "jesse.d.squires@gmail.com" }
  s.source       = { :git => "https://github.com/jessesquires/MessagesTableViewController.git", :commit => 'b286fc182a' }
  s.platform     = :ios
  s.source_files = 'MessagesTableViewController'
  s.resources = "MessagesTableViewController/Resources/**/*.*"
  s.frameworks = 'AudioToolbox'
  s.requires_arc = true
end
