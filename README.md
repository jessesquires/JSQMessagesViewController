# MessagesTableViewController

A messages UI for iPhone and iPad.

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

This messages tableview controller is very similar to the one in the iOS Messages app. **Note, this is only a messaging UI, not a messaging app.** This is intended to be used in an existing app where you have (or are developing) a messaging system and need a user interface for it.

**See more [screenshots][link1] in the `Screenshots/` directory. (Surprise!)**

## About

This is based on work by [@soffes](http://github.com/soffes) [SSMessagingViewController][ss]. I took Soffes' code base and developed this to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users. The features section lists the most notable improvements from [SSMessagingViewController][ss].

[Square message bubbles][img4] designed by [@michaelschultz](http://www.twitter.com/michaelschultz).

## Features 

* Up-to-date for iOS 6.0 and ARC
* Storyboards support (if that's how you roll)
* Universal for iPhone and iPad
* Allows arbitrary message (and bubble) sizes
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
	* Set your view controller title

#####Implement the `JSMessagesViewDelegate` protocol

* `- (void)sendPressed:(UIButton *)sender withText:(NSString *)text`
	* Hook into your own backend here
	* Call `[self finishSend]` at the end of this method to animate and reset the text input view
	* Optionally play sound effects
		* For outgoing messages `[JSMessageSoundEffect playMessageSentSound]`
		* For incoming messages `[JSMessageSoundEffect playMessageReceivedSound]`

* `- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath`
	* The [style of the bubble][link1] for this row, options are:
		* `JSBubbleMessageStyleIncomingDefault`
		* `JSBubbleMessageStyleIncomingSquare`
		* `JSBubbleMessageStyleOutgoingDefault`
		* `JSBubbleMessageStyleOutgoingDefaultGreen`
		* `JSBubbleMessageStyleOutgoingSquare`

* `- (JSMessagesViewTimestampPolicy)timestampPolicyForMessagesView`
	* How/when to display timestamps for messages, options are:
		* `JSMessagesViewTimestampPolicyAll`
		* `JSMessagesViewTimestampPolicyAlternating`
		* `JSMessagesViewTimestampPolicyEveryThree`
		* `JSMessagesViewTimestampPolicyEveryFive`
		* `JSMessagesViewTimestampPolicyCustom`

* `- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath`
	* Returns if this row should display a timestamp or not, based on the value returned from the above method
	* If using a built-in timestamp policy, simply return `[self shouldHaveTimestampForRowAtIndexPath:indexPath]`
	* If using `JSMessagesViewTimestampPolicyCustom`, you are on your own!

#####Implement the `JSMessagesViewDataSource` protocol

* `- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath`
	* The text to be displayed for this row

* `- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath`
	* The timestamp to be displayed *above* this row

#####Implement the [table view data source][ref1] method that you should be familiar with

* `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section`

#####Customize

* Custom background color, call `- (void)setBackgroundColor:(UIColor *)color`
* Custom send button, override `- (UIButton *)sendButton`

##### Notes

* You may present view programmatically, or use Storyboards
* Your `JSMessagesViewController` subclass **must** be presented in a `UINavigationController`

##### Demo projects included

* `MessagesDemo.xcodeproj` for example of programmatic presentation
* `MessagesDemoStoryboards/MessagesDemoSB.xcodeproj` for example of use with Storyboards

## ToDo

* Landscape mode
* Allow text input view to resize up to navigation bar (instead of only 5 lines)
* Display "To: <recipient>" search field for new messages
* Option for user avatar to display next to bubbles
* "Send" images or video

## Related Projects

[SSMessagingViewController][ss]

[AcaniChat](https://github.com/acani/AcaniChat)


## License

You are free to use this as you please. No attribution necessary. 

**If you use this, please tell me about it!**

MIT License
Copyright &copy; 2013 Jesse Squires

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[ss]:https://github.com/soffes/ssmessagesviewcontroller

[ref1]:http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html#//apple_ref/occ/intf/UITableViewDataSource
[ref2]:http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot1.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot2.png
[img3]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot3.png
[img4]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot4.png

[link1]:https://github.com/jessesquires/MessagesTableViewController/tree/master/Screenshots