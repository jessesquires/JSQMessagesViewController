# JSQMessagesViewController 

*An elegant messages UI framework for iOS* [![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSMessagesViewController/badge.png)][docsLink] [![license MIT](http://b.repl.ca/v1/license-MIT-blue.png)][mitLink]

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

> [More screenshots here](https://www.cocoacontrols.com/controls/jsmessagesviewcontroller)

## Features 

* Highly configurable & customizable
* Data detectors
* Timestamps
* Avatars
* Custom chat bubbles
* Subtitles
* Arbitrary message sizes
* Copy & paste messages
* Group chat
* Smooth keyboard animations
* UIDynamics for springy bubbles
* Dynamic input text view resizing
* Smooth animations
* Universal

## Requirements

* iOS 7.0+ 
* ARC
* [JSQSystemSoundPlayer][playerLink]

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'JSMessagesViewController'`

#### From source

* Drag the `JSQMessagesViewController/` folder to your project
* Install [JSQSystemSoundPlayer][playerLink]
* Add the `QuartzCore.framework`

## Getting Started

### Model

Your model objects should conform to the `JSQMessageData` protocol. 
However, you may use the provided `JSQMessage` class.

### View Controller

1. Subclass `JSQMessagesViewController`

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

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Donate

Support the developement of this **free**, open-source framework, via [Square Cash](https://square.com/cash).

<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSMessagesViewController!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSMessagesViewController!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSMessagesViewController!">Send $10</a> <em>This totally saved me time!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$25&body=Thanks for developing JSMessagesViewController!">Send $25</a> <em>I want new features!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$50&body=Thanks for developing JSMessagesViewController!">Send $50</a> <em>I love this project!</em></h4>

## Customization

## Credits

Created by [@jesse_squires](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

Assets extracted using [@0xced](https://github.com/0xced) **/** [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor).

Originally inspired by [@soffes](http://github.com/soffes) **/** [SSMessagingViewController][ss].

Many thanks to [the contributors](https://github.com/jessesquires/MessagesTableViewController/graphs/contributors) of this project.

## About

I initially developed this control to use in [Hemoglobe](http://www.hemoglobe.com) for private messages between users.

As it turns out, messaging is a popular thing that iOS devs and users want. Thus, I am supporting this project in my free time and have added features way beyond what [Hemoglobe](http://www.hemoglobe.com) ever needed.

Check out my work at [Hexed Bits](http://www.hexedbits.com).

## Apps Using This Control

* [Hemoglobe](http://bit.ly/hemoglobeapp)
* [Loopse](https://itunes.apple.com/us/app/loopse-spots-friends-sessions/id704783915?mt=8)
* [Oxwall Messenger](https://github.com/tochman/OxwallMessenger)
* [FourChat](https://itunes.apple.com/us/app/fourchat/id650833730?mt=8)
* [AwesomeChat](https://github.com/relatedcode/AwesomeChat)
* [Quick Text Message](https://itunes.apple.com/us/app/quick-text-message-fast-sms/id583729997?mt=8)
* [Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## [MIT License][mitLink]

JSQMessagesViewController is released under an [MIT License][mitLink]. See LICENSE for details.

Copyright &copy; 2014 Jesse Squires

*Please provide attribution, it is greatly appreciated.*

[docsLink]:http://cocoadocs.org/docsets/JSMessagesViewController/4.0.0

[mitLink]:http://opensource.org/licenses/MIT

[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[ss]:https://github.com/soffes/ssmessagesviewcontroller

[img1]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot-ios7.png
[img2]:https://raw.github.com/jessesquires/MessagesTableViewController/master/Screenshots/iphone5-screenshot5.png

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jessesquires/messagestableviewcontroller/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
