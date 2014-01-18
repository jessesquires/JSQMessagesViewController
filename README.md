# JSMessagesViewController 
[![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSMessagesViewController/badge.png)][docsLink] [![license MIT](http://b.repl.ca/v1/license-MIT-blue.png)][mitLink]

A messages UI for iPhone and iPad.

`JSMessagesViewController` is a `UIViewController` subclass that is very similar to the iOS Messages app. 

**Note: this is only a messaging UI, not a messaging app.**

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

*See more [screenshots](https://github.com/jessesquires/MessagesTableViewController/tree/master/Screenshots) in the `Screenshots/` directory.*

## Features 

* Highly customizable
* Arbitrary message sizes
* Copy & paste messages
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
* [JSQSystemSoundPlayer][playerLink]

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'JSMessagesViewController'`

#### From source

* Drag the `JSMessagesViewController/` folder to your project
* Download [JSQSystemSoundPlayer][playerLink] and follow its install instructions
* Add the `QuartzCore.framework` to your project

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
    
    [[JSBubbleView appearance] setFont:/* your font for the message bubbles */];

    self.title = @"Your view controller title";
    
    self.messageInputView.textView.placeHolder = @"Your placeholder text";
}
````

3. Implement the `JSMessagesViewDelegate` protocol
4. Implement the `JSMessagesViewDataSource` protocol
5. Implement `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section` from the [`UITableViewDataSource` protocol](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html).
6. Present your subclassed ViewController programatically or via StoryBoards. Your subclass should be the `rootViewController` of a `UINavigationController`.
7. Be a badass [programming-motherfucker](http://programming-motherfucker.com) and read the fucking documentation. (Yes, there's documentation! [Seriously](http://dailyyeah.com/wp-content/uploads/2008/07/crazy_fat_kid.gif)!)
8. See the included demo: **`JSMessagesDemo.xcworkspace`**
    * Don't forget to run `pod install` before opening the demo!

## Documentation

Documentation is [available here][docsLink] via [CocoaDocs](http://cocoadocs.org). Thanks [@CocoaDocs](https://twitter.com/CocoaDocs)!

## Donate

Support the developement of this **free**, open-source control! via [Square Cash](https://square.com/cash).

<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSMessagesViewController!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSMessagesViewController!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSMessagesViewController!">Send $10</a> <em>This totally saved me time!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$25&body=Thanks for developing JSMessagesViewController!">Send $25</a> <em>I want new features!</em></h4>

## Customization

* You can customize almost any property of a cell by implementing the optional delegate method `configureCell: atIndexPath:`

````objective-c
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    
        if([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:UITextAttributeTextColor];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if(cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if(cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
}
````

* Set the font for your messages bubbles via `UIAppearance`

````objective-c
[[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
````

* Customize your message bubbles with `JSBubbleImageViewFactory`

* Customize your avatars with `JSAvatarImageFactory`

*More tips coming soon!* Have your own? Submit a PR!

## How To Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

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

[Loopse](https://itunes.apple.com/us/app/loopse-spots-friends-sessions/id704783915?mt=8)

[Oxwall Messenger](https://github.com/tochman/OxwallMessenger)

[FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)

[Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## Related Projects

[SSMessagingViewController][ss]

[AcaniChat](https://github.com/acani/AcaniChat)

[UIBubbleTableView](https://github.com/AlexBarinov/UIBubbleTableView)

[SPHChatBubble](https://github.com/sibahota059/SPHChatBubble)

## [MIT License][mitLink]

You are free to use this as you please. **No attribution necessary, but much appreciated.**

Copyright &copy; 2013 Jesse Squires

>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[docsLink]:http://cocoadocs.org/docsets/JSMessagesViewController/3.4.4

[mitLink]:http://opensource.org/licenses/MIT

[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[ss]:https://github.com/soffes/ssmessagesviewcontroller

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot-ios7.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot5.png

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jessesquires/messagestableviewcontroller/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
