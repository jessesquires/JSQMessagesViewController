# JSMessagesViewController [![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController)

A messages UI for iPhone and iPad.

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

This messages tableview controller is very similar to the one in the iOS Messages app. **Note, this is only a messaging UI, not a messaging app.** This is intended to be used in an existing app where you have (or are developing) a messaging system and need a user interface for it.

**See more [screenshots][link1] in the `Screenshots/` directory. (Surprise!)**

## Update!

####Version 3.0.0 just released with a brand new API! iOS 7 support + documentation coming soon!

## Features 

* Highly customizable
* Arbitrary message sizes
* Copy & paste messages
* Support for group messages
* Data detectors (recognizes phone numbers, links, dates, etc)
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
* Universal

## Requirements

* iOS 6.0+ 
* ARC

## Installation

### From [CocoaPods](http://www.cocoapods.org)

    pod 'JSMessagesViewController'

### From source

* Drag the `JSMessagesViewController/` folder to your project.
* Add the `AudioToolbox.framework` to your project, if you want to use the sound effects

## How To Use

###Subclass `JSMessagesViewController`

* In `- (void)viewDidLoad`
	* Set your view controller as the `delegate` and `datasource`
	* Set your view controller `title`

###Implement the `JSMessagesViewDelegate` protocol

````objective-c 
- (void)didSendText:(NSString *)text;
````

* Hook into your own backend here
* Call `finishSend` at the end of this method to animate and reset the text input view
* Call `scrollToBottomAnimated:` to scroll to newly sent message
* Optionally play sound effects
	* For outgoing messages `[JSMessageSoundEffect playMessageSentSound]`
	* For incoming messages `[JSMessageSoundEffect playMessageReceivedSound]`

````objective-c
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath;
````

* The type of bubble for this row, options are:
	* `JSBubbleMessageTypeIncoming`
	* `JSBubbleMessageTypeOutgoing`

````objective-c
- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath;
````

* The [bubble image view][link1] for this row, see `JSBubbleImageViewFactory`

````objective-c 
- (JSMessagesViewTimestampPolicy)timestampPolicy
````

* How/when to display timestamps for messages:
	* `JSMessagesViewTimestampPolicyAll`
	* `JSMessagesViewTimestampPolicyAlternating`
	* `JSMessagesViewTimestampPolicyEveryThree`
	* `JSMessagesViewTimestampPolicyEveryFive`
	* `JSMessagesViewTimestampPolicyCustom`

````objective-c 
- (JSMessagesViewAvatarPolicy)avatarPolicy
````

* How/when to display avatars:
	* `JSMessagesViewAvatarPolicyAll`
	* `JSMessagesViewAvatarPolicyIncomingOnly`
	* `JSMessagesViewAvatarPolicyOutgoingOnly`
	* `JSMessagesViewAvatarPolicyNone`


````objective-c
- (JSMessagesViewSubtitlePolicy)subtitlePolicy;
````

* How/when to display subtitles:
	* `JSMessagesViewSubtitlePolicyAll`
	* `JSMessagesViewSubtitlePolicyIncomingOnly`
	* `JSMessagesViewSubtitlePolicyOutgoingOnly`
	* `JSMessagesViewSubtitlePolicyNone`


````objective-c 
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
````

* *Optional* Returns if this row should display a timestamp or not
* Required if using `JSMessagesViewTimestampPolicyCustom`

````objective-c 
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling;
````

* *Optional* Return `YES` if you would like to prevent the tableview from being scrolled to the bottom while the user is scrolling the tableview manually. The method `scrollToRowAtIndexPath:indexPath:atScrollPosition:animated:` can also be used to implement scrolling functionality that respects this setting.

````objective-c 
- (UIButton *)sendButtonForInputView;
````	

* *Optional* Return a custom send button, the frame is set for you.


###Implement the `JSMessagesViewDataSource` protocol

````objective-c 
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The text to be displayed for this row

````objective-c 
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The timestamp to be displayed *above* this row

````objective-c 
- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath*)indexPath
````

* The avatar image view to be displayed this row

````objective-c 
- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath*)indexPath
````

* The subtitle text to be displayed *below* this row

###Implement the [table view data source][ref1] method

````objective-c 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
````

###Customize

* For custom background color, use `- (void)setBackgroundColor:(UIColor *)color`

### Notes

* You may present view programmatically, or use Storyboards
* Your `JSMessagesViewController` subclass **must** be presented in a `UINavigationController`
* Demo project included: `MessagesDemo.xcodeproj` 

## About

This project was originally based on work by [@soffes](http://github.com/soffes) [SSMessagingViewController][ss]. 

I developed this to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users.

[Square message bubbles][img4] designed by [@michaelschultz](http://www.twitter.com/michaelschultz).

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)

[Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## Related Projects

[SSMessagingViewController][ss]

[AcaniChat](https://github.com/acani/AcaniChat)

[UIBubbleTableView](https://github.com/AlexBarinov/UIBubbleTableView)

## [MIT License](http://opensource.org/licenses/MIT)

You are free to use this as you please. No attribution necessary. **However, a link back to [Hexed Bits](http://www.hexedbits.com) or here would be appreciated. If you use this, please tell me about it!**

Copyright &copy; 2013 Jesse Squires

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[ss]:https://github.com/soffes/ssmessagesviewcontroller

[ref1]:http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html#//apple_ref/occ/intf/UITableViewDataSource
[ref2]:http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot0.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot2.png
[img3]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot3.png
[img4]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot4.png

[link1]:https://github.com/jessesquires/MessagesTableViewController/tree/master/Screenshots
