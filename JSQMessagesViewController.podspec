Pod::Spec.new do |s|
	s.name = 'JSQMessagesViewController'
	s.version = '7.0.1'
	s.summary = 'An elegant messages UI library for iOS.'
	s.homepage = 'http://jessesquires.github.io/JSQMessagesViewController'
	s.license = 'MIT'
	s.platform = :ios, '7.0'

	s.author = { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.social_media_url = 'https://twitter.com/jesse_squires'

	s.screenshots = ['https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot0.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot1.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot2.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot3.png']

	s.source = { :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :tag => s.version }
	s.source_files = 'JSQMessagesViewController/**/*.{h,m}'

	s.resources = ['JSQMessagesViewController/Assets/JSQMessagesAssets.bundle', 'JSQMessagesViewController/**/*.{xib}']
	
	s.frameworks = 'QuartzCore', 'CoreGraphics', 'CoreLocation', 'MapKit', 'UIKit', 'Foundation'
	s.requires_arc = true

	s.dependency 'JSQSystemSoundPlayer', '~> 2.0.1'
end
