# JSMessagesViewController [![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSMessagesViewController/badge.png)][docsLink]

A messages UI for iPhone and iPad.

`JSMessagesViewController` is a `UIViewController` subclass that is very similar to the iOS Messages app. 

**Note: this is only a messaging UI, not a messaging app.**

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

*See more [screenshots](https://github.com/jessesquires/MessagesTableViewController/tree/master/Screenshots) in the `Screenshots/` directory.*

## Features 

* Highly customizable
* Text content Messages
* Image ( Photos,Videos ) attached content messages with description title
* Arbitrary message sizes
* Copy & paste Text messages
* Action delegate to see more information for displayed media messages when tapping
* Support for group messages
* Data detectors (recognizes phone numbers, links, dates, etc.)
* Timestamps
* Avatars
* Subtitles
* Lots of bubble styles, or use your own!
* Swipe down to hide keyboard
* Dynamically resizes input text view as you type
* Smooth animations
* Automatically enables/disables send button (if text view is empty or not)
* Send/Receive sound effects
* Storyboards support (if that's how you roll)
* Universal for iPhone and iPad

## Requirements

* iOS 6.0+ 
* ARC

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'JSMessagesViewController'`

#### From source

* Drag the `JSMessagesViewController/` folder to your project.
* Add the `AudioToolbox.framework` to your project, if you want to use the sound effects

#### Too cool for [ARC](https://developer.apple.com/library/mac/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)?

* Add the `-fobjc-arc` compiler flag to all source files in your project in Target Settings > Build Phases > Compile Sources.

## Getting Started

1. Subclass `JSMessagesViewController`
2. Setup your `viewDidLoad` like the following:

````objective-c

- (void)viewDidLoad
{
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    
    self.title = @"Messages";
    [self.messageInputView showMediaButton:YES];
    
    self.messageInputView.textView.placeHolder = @"New Message";
}

````

3. Implement the `JSMessagesViewDelegate` protocol
4. Implement the `JSMessagesViewDataSource` protocol
5. Implement `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section` from the [`UITableViewDataSource` protocol](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html).
6. Present your subclassed ViewController programatically or via StoryBoards. Your subclass should be the `rootViewController` of a `UINavigationController`.
7. Be a badass [programming-motherfucker](http://programming-motherfucker.com) and read the fucking documentation. (Yes, there's documentation! [Seriously](http://dailyyeah.com/wp-content/uploads/2008/07/crazy_fat_kid.gif)!)
8. See the included demo project: `JSMessagesDemo.xcodeproj`

## Documentation

Documentation is [available here][docsLink] via [CocoaDocs](http://cocoadocs.org). Thanks [@CocoaDocs](https://twitter.com/CocoaDocs)!

## Customization

*Stuff here coming soon!*

## How To Contribute

1. [Find an issue](https://github.com/jessesquires/MessagesTableViewController/issues?sort=created&state=open) to work on, or create a new one.
2. Fork me.
3. Create a new branch with a sweet fucking name: `git checkout -b issue_<##>_<featureOrFix>`.
4. Do some motherfucking programming.
5. Keep your code nice and clean by adhering to Google's [Objective-C Style Guide](http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml) and Apple's [Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html).
6. Don't break shit, especially `master`.
7. Update the documentation header comments.
8. Update the pod spec and project version numbers, adhering to the [semantic versioning](http://semver.org) specification.
9. Submit a pull request.
10. See step 1.

## Credits

Created by [@jesse_squires](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

Assets extracted using [@0xced](https://github.com/0xced) **/** [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor).

Originally inspired by [@soffes](http://github.com/soffes) **/** [SSMessagingViewController][ss].

Many thanks to [the contributors](https://github.com/jessesquires/MessagesTableViewController/graphs/contributors) of this project.

Square message bubbles designed by [@michaelschultz](http://www.twitter.com/michaelschultz).

## About

I initially developed this control to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users.

As it turns out, messaging is a popular thing that iOS devs want to do — I know, this is *shocking*. Thus, I am supporting this project in my free time and have added features way beyond what [Hemoglobe](http://www.hemoglobe.com) ever needed.

Check out my work at [Hexed Bits](http://www.hexedbits.com).

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[Oxwall Messenger](https://github.com/tochman/OxwallMessenger)

[FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)

[Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## Related Projects

[SSMessagingViewController][ss]

[AcaniChat](https://github.com/acani/AcaniChat)

[UIBubbleTableView](https://github.com/AlexBarinov/UIBubbleTableView)

## [MIT License](http://opensource.org/licenses/MIT)

You are free to use this as you please. **No attribution necessary, but much appreciated.**

Copyright &copy; 2013 Jesse Squires

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[docsLink]:http://cocoadocs.org/docsets/JSMessagesViewController/3.2.0

[ss]:https://github.com/soffes/ssmessagesviewcontroller

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot-ios7.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot5.png
