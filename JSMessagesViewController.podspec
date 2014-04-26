Pod::Spec.new do |s|
	s.name				= 'JSMessagesViewController'
	s.version			= '4.0.4'
	s.summary			= 'A messages UI for iPhone and iPad.'
	s.homepage			= 'https://github.com/jessesquires/MessagesTableViewController'
	s.social_media_url	= 'https://twitter.com/jesse_squires'
	s.license			= 'MIT'
	s.authors			= { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.source			= { :git => 'https://github.com/jessesquires/MessagesTableViewController.git', :tag => s.version.to_s }
	s.platform			= :ios, '6.0'
	s.source_files		= 'JSMessagesViewController/Classes/**/*'
	s.resources			= 'JSMessagesViewController/Resources/**/**/*'
	s.frameworks		= 'QuartzCore'
	s.requires_arc		= true

	s.dependency 'JSQSystemSoundPlayer'
end
