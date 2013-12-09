Pod::Spec.new do |s|
	s.name			= 'JSMessagesViewController'
	s.version		= '3.4.0'
	s.summary		= 'A messages UI for iPhone and iPad.'
	s.homepage		= 'https://github.com/jessesquires/MessagesTableViewController'
	s.license		= 'MIT License'
	s.author        = { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.source        = { :git => 'https://github.com/jessesquires/MessagesTableViewController.git', :tag => s.version.to_s }
	s.platform		= :ios, '6.0'
	s.source_files	= 'JSMessagesViewController/Classes/**/*'
	s.resources		= 'JSMessagesViewController/Resources/**/**/*'
	s.frameworks	= 'QuartzCore'
	s.requires_arc	= true
    
    s.dependency 'JSQSystemSoundPlayer'
end
