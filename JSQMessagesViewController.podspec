Pod::Spec.new do |s|
	s.name					= 'JSQMessagesViewController'
	s.version				= '5.0.0'
	s.summary				= 'An elegant messages UI framework for iOS.'
	s.homepage				= 'https://github.com/jessesquires/JSQMessagesViewController'
	s.license				= 'MIT'
	s.screenshots			= 'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot0.png'
	s.author				= { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.social_media_url		= 'https://twitter.com/jesse_squires'
	s.source				= { :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :tag => s.version.to_s }
	s.platform				= :ios, '7.0'	
	s.source_files			= 'JSQMessagesViewController/**/*.{h,m}'
	s.resources				= 'JSQMessagesViewController/Assets/**/**/*', 'JSQMessagesViewController/**/*.{xib}'
	s.frameworks			= 'QuartzCore'
	s.requires_arc			= true

	s.dependency 'JSQSystemSoundPlayer'
end
