# MessagesTableViewController

A messages UI for iPhone and iPad.

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

This messages tableview controller is very similar to the one in the iOS Messages app. **Note, this is only a messaging UI, not a messaging app.** This is intended to be used in an existing app where you have (or are developing) a messaging system and need a user interface for it.

**See more [screenshots][link1] in the `Screenshots/` directory. (Surprise!)**

## About

This is based on work by [@soffes](http://github.com/soffes) [SSMessagingViewController][ss]. 

I developed this to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users.

[Square message bubbles][img4] designed by [@michaelschultz](http://www.twitter.com/michaelschultz).

## Features 

* Up-to-date for iOS 6.0 and ARC (iOS 5.0+ required)
* Storyboards support (if that's how you roll)
* Universal for iPhone and iPad
* Allows arbitrary message (and bubble) sizes
* Copy & paste messages
* Timestamp options
* Swipe/pull down to hide keyboard
* Dynamically resizes input text view as you type
* Smooth hiding/showing keyboard animations with `NSNotification`
* Automatically enables/disables send button if text view is empty or not
* Smooth send animations
* Send/Receive sound effects
* Various bubble styles

## Installation

### From [CocoaPods](http://www.cocoapods.org)

    pod 'JSMessagesViewController'

### From source

* Drag the `JSMessagesTableViewController/` folder to your project.
* Add the `AudioToolbox.framework` to your project, if you want to use the sound effects

## How To Use

#####Subclass `JSMessagesViewController`

* In `- (void)viewDidLoad`
	* Set your view controller as the `delegate` and `datasource`
	* *Optional* set `preventScrollToBottomWhileUserScrolling` to `YES` if you would like to prevent the tableview from being scrolled to the bottom while the user is scrolling the tableview manually. The method `scrollToRowAtIndexPath:indexPath:atScrollPosition:animated:` can also be used to implement scrolling functionality that respects this setting.
	* Set your view controller `title`

#####Implement the `JSMessagesViewDelegate` protocol

````objective-c 
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
````

* Hook into your own backend here
* Call `[self finishSend]` at the end of this method to animate and reset the text input view
* Optionally play sound effects
	* For outgoing messages `[JSMessageSoundEffect playMessageSentSound]`
	* For incoming messages `[JSMessageSoundEffect playMessageReceivedSound]`

````objective-c
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The type of bubble for this row, options are:
	* `JSBubbleMessageTypeIncoming`
	* `JSBubbleMessageTypeOutgoing`

````objective-c
- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The [style of the bubble][link1] for this row, options are:
	* `JSBubbleMessageStyleDefault`
	* `JSBubbleMessageStyleSquare`
	* `JSBubbleMessageStyleDefaultGreen`

````objective-c 
- (JSMessagesViewTimestampPolicy)timestampPolicy
````

* How/when to display timestamps for messages, options are:
	* `JSMessagesViewTimestampPolicyAll`
	* `JSMessagesViewTimestampPolicyAlternating`
	* `JSMessagesViewTimestampPolicyEveryThree`
	* `JSMessagesViewTimestampPolicyEveryFive`
	* `JSMessagesViewTimestampPolicyCustom`

````objective-c 
- (JSMessagesViewAvatarPolicy)avatarPolicy
````

* *Optional* How/when to display avatars, options are:
	* `JSMessagesViewAvatarPolicyIncomingOnly`
	* `JSMessagesViewAvatarPolicyOutgoingOnly`
	* `JSMessagesViewAvatarPolicyBoth`
	* `JSMessagesViewAvatarPolicyNone`

````objective-c 
- (JSAvatarStyle)avatarStyle
````

* The [style for the avatars][link1], options are:
	* `JSAvatarStyleCircle`
	* `JSAvatarStyleSquare`
	* `JSAvatarStyleNone`

````objective-c 
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
````

* Returns if this row should display a timestamp or not
* Required only if using `JSMessagesViewTimestampPolicyCustom`

````objective-c
- (BOOL)hasSubtitleForRowAtIndexPath:(NSIndexPath *)indexPath
````

* *Optional* Return `YES` if you want to display a small bit of text under the bubble.

#####Implement the `JSMessagesViewDataSource` protocol

````objective-c 
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The text to be displayed for this row

````objective-c 
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
````

* The timestamp to be displayed *above* this row

````objective-c 
- (UIImage *)avatarImageForIncomingMessageAtIndexPath:(NSIndexPath*)indexPath
````

* *Optional* The avatar image for incoming messages

````objective-c 
- (UIImage *)avatarImageForOutgoingMessageAtIndexPath:(NSIndexPath*)indexPath;
````

* *Optional* The avatar image for outgoing messages

````objective-c 
- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath*)indexPath
````

* *Optional* The text to display underneath the bubble

````objective-c 
- (void)messageDoneSending
````

* *Optional* Implement this method if you do not wish for the table view to be reloaded and scrolled to the bottom when `finishSend` is called.

#####Implement the [table view data source][ref1] method that you should be familiar with

````objective-c 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
````

#####Customize

* For custom background color, use `- (void)setBackgroundColor:(UIColor *)color`
* For custom send button, override `- (UIButton *)sendButton`

##### Notes

* You may present view programmatically, or use Storyboards
* Your `JSMessagesViewController` subclass **must** be presented in a `UINavigationController`

##### Demo projects included

* `MessagesDemo.xcodeproj` for example of programmatic presentation
* `MessagesDemoStoryboards/MessagesDemoSB.xcodeproj` for example of use with Storyboards

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)

[Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## Related Projects

[SSMessagingViewController][ss]

[AcaniChat](https://github.com/acani/AcaniChat)

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
