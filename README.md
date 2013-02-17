# MessagesTableViewController

A messages UI for iPhone and iPad.

![Messages Tableview iPhone screenshot 1](https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone-screenshot1.png) &nbsp;&nbsp;&nbsp;&nbsp; ![Messages Tableview iPhone screenshot 2](https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone-screenshot2.png)

This messages tableview controller is very similar to the iOS Messages app. **Note, this is only a messaging UI, not a messaging app.** This is intended to be used in an existing app where you have (or are developing) a messaging system and need a user interface for it.

## About

This is *heavily* based on work by [Sam Soffes](https://github.com/soffes)' [SSMessagingViewController][1]. I took Soffes' code base and developed this to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users. I didn't fork the original repo simply because my refactoring was too extensive.

Notable changes from [SSMessagingViewController][1]:

* Brought up-to-date for iOS 6.0 and ARC
* Allows arbitrary message sizes (and message bubble sizes)
* Universal for iPhone and iPad
* Dynamically resizes input text view as you type
* Improved hiding/showing keyboard with `NSNotification`
* Automatically enables/disables send button if text view is empty or not
* Refactoring, refinements, and fixes

## Installation
		
* Drag the `MessagesTableViewController/` folder to your project.
* Add the `AudioToolbox.framework` to your project, if you want to use the sound effects
* Subclass `MessagesViewController`
* Override the following methods:
	* `- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath`
		* The style of the bubble for this row
		* Style options are: `BubbleMessageStyleOutgoing` or `BubbleMessageStyleIncoming`
	* `- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath`
		* The text to be displayed for this row
	* `- (void)sendPressed:(UIButton *)sender withText:(NSString *)text`
		* Hook into your own backend here
		* Call `[self finishSend]` at the end of this method to animate and reset the text input view
		* Optionally play sound effects with `[MessageSoundEffect playMessageSentSound]` or `[MessageSoundEffect playMessageReceivedSound]`
	* `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section`
		* The API table view data source method that you should be familiar with
* Present view programmatically, **does not work with Storyboards**
* See the included Demo project `MessagesDemo.xcodeproj` for example

## ToDo

* Landscape mode
* Swipe down to hide keyboard (like iOS Messages)
* Allow text input view to resize dynamically (i.e., stretch up to top navigation bar like iOS Messages)
* Display "To:" search field for new messages
* "Send" images or video
* Storyboards support

## Related Projects

[SSMessagingViewController][1]

[AcaniChat](https://github.com/acani/AcaniChat)


## License

You are free to use this as you please. No attribution necessary. 

**If you do use this, I would love to here about it!**

MIT License
Copyright &copy; 2013 Jesse Squires

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[1]:https://github.com/soffes/ssmessagesviewcontroller