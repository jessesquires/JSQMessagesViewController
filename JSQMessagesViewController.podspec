Pod::Spec.new do |s|
	s.name					= 'JSQMessagesViewController'
	s.version				= '5.0.0-beta3'
	s.summary				= 'An elegant messages UI framework for iOS.'
	s.homepage				= 'https://github.com/jessesquires/MessagesTableViewController'
	s.license				= 'MIT'
	#s.screenshots			= ''
	s.author				= { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.social_media_url		= 'https://twitter.com/jesse_squires'
	s.source				= { :git => 'https://github.com/jessesquires/MessagesTableViewController.git', :tag => s.version.to_s }
	s.platform				= :ios, '7.0'	
	s.source_files			= 'JSQMessagesViewController/**/*.{h,m}'
	s.resources				= 'JSQMessagesViewController/Assets/**/**/*', 'JSQMessagesViewController/**/*.{xib}'
	s.frameworks			= 'QuartzCore'
	s.requires_arc			= true

	s.dependency 'JSQSystemSoundPlayer'
end
