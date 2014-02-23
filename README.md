# JSMessagesViewController 
[![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSMessagesViewController/badge.png)][docsLink] [![license MIT](http://b.repl.ca/v1/license-MIT-blue.png)][mitLink]

A messages UI for iPhone and iPad.

`JSMessagesViewController` is a `UIViewController` subclass that is very similar to the iOS Messages app. 

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

### Setup your model

Your model objects should conform to the `JSMessageData` protocol. However, you may use the provided `JSMessage` class for your model objects if you wish.

### Setup your view controller

1. Subclass `JSMessagesViewController`
2. Conform to the protocols `<JSMessagesViewDelegate, JSMessagesViewDataSource>`
3. Implement the `JSMessagesViewDelegate` protocol
4. Implement the `JSMessagesViewDataSource` protocol
5. Implement `tableView: numberOfRowsInSection:` from the [`UITableViewDataSource` protocol](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html).
6. Setup your `viewDidLoad` like the following:

````objective-c
- (void)viewDidLoad
{
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    
    [[JSBubbleView appearance] setFont:/* your font for the message bubbles */];

    self.title = @"Your view controller title";
    
    self.messageInputView.textView.placeHolder = @"Your placeholder text";

    self.sender = @"Username of sender";
}
````

### Present your view controller

1. Present your subclassed view controller programatically or via StoryBoards. Your subclass should be the `rootViewController` of a `UINavigationController`, or pushed on an existing navigation stack.

2. You may want to show the most recent message when presenting your view: (*this is no longer default behavior*)

````objective-c
// Scroll to the most recent message before view appears
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self scrollToBottomAnimated:NO];
}
````

## Questions?

1. Be a badass [programming-motherfucker](http://programming-motherfucker.com) and [read](http://thecodinglove.com/post/64679177345/when-i-use-a-lib-without-reading-documentation) the fucking documentation. Yes, there's fucking documentation! And it is fucking kept up-to-date. How fucking sweet is that? [Pretty fucking sweet](http://thecodinglove.com/post/45748349769/when-the-library-has-a-very-good-documentation).
2. See the included demo: **`JSMessagesDemo.xcworkspace`**. Don't forget to run `pod install` before opening!
3. Still need help? That's ok! Just [open a new issue](https://github.com/jessesquires/MessagesTableViewController/issues/new) with your question, and *add the question label*. 
4. **Please do not email me your question if you need help**. *But I really want to email you. Why can't I?*
    * Opening an issue is better for you and the community, because it provides better transparency.
    * I'm often busy and may not reply in a timely manor.
    * People using this library and watching this repo may be able to answer your question sooner.
    * Someone else likely has a similar question and also needs an answer.
    * Users of this library can search the issues for previously asked questions.

## Documentation

Documentation is [available here][docsLink] via [CocoaDocs](http://cocoadocs.org). Thanks [@CocoaDocs](https://twitter.com/CocoaDocs)!

## Donate

Support the developement of this **free**, open-source control! via [Square Cash](https://square.com/cash).

<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSMessagesViewController!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSMessagesViewController!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSMessagesViewController!">Send $10</a> <em>This totally saved me time!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$25&body=Thanks for developing JSMessagesViewController!">Send $25</a> <em>I want new features!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$50&body=Thanks for developing JSMessagesViewController!">Send $50</a> <em>I love this project!</em></h4>

## Customization

* You can customize almost any property of a cell by implementing the optional delegate method `configureCell: atIndexPath:`

````objective-c
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {

        // Customize any UITextView properties
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    
        if ([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:UITextAttributeTextColor];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    // Customize any UILabel properties for timestamps or subtitles
    if (cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if (cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }

    // Enable data detectors
    cell.bubbleView.textView.dataDetectorTypes = UIDataDetectorTypeAll;
}
````

* Set the font for your messages bubbles via `UIAppearance`

````objective-c
[[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
````

* Customize your message bubbles with `JSBubbleImageViewFactory`

* Customize your avatars with `JSAvatarImageFactory`

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

As it turns out, messaging is a popular thing that iOS devs and users want. Thus, I am supporting this project in my free time and have added features way beyond what [Hemoglobe](http://www.hemoglobe.com) ever needed.

Check out my work at [Hexed Bits](http://www.hexedbits.com).

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[Loopse](https://itunes.apple.com/us/app/loopse-spots-friends-sessions/id704783915?mt=8)

[Oxwall Messenger](https://github.com/tochman/OxwallMessenger)

[FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)

[Quick Text Message](https://itunes.apple.com/us/app/quick-text-message-fast-sms/id583729997?mt=8)

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

[docsLink]:http://cocoadocs.org/docsets/JSMessagesViewController/4.0.0

[mitLink]:http://opensource.org/licenses/MIT

[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[ss]:https://github.com/soffes/ssmessagesviewcontroller

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot-ios7.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot5.png

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jessesquires/messagestableviewcontroller/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
