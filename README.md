# JSQMessagesViewController 

*An elegant messages UI framework for iOS* 

[![Build Status](https://secure.travis-ci.org/jessesquires/MessagesTableViewController.png)](http://travis-ci.org/jessesquires/MessagesTableViewController) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSMessagesViewController/badge.png)][docsLink] [![license MIT](http://b.repl.ca/v1/license-MIT-blue.png)][mitLink]

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

> [More screenshots here](https://www.cocoacontrols.com/controls/jsmessagesviewcontroller)

## Features 

* Highly configurable & customizable
* Data detectors
* Timestamps
* Custom avatars with photos or initials
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
* Need support for iOS 6? See branch `iOS6_support_stable`

## Installation

````
pod 'JSQMessagesViewController'
````

Otherwise, drag the `JSQMessagesViewController/` folder to your project. Install [`JSQSystemSoundPlayer`][playerLink] and add the `QuartzCore.framework`.

>**NOTE:** 
>
>This repo was formerly named `MessagesTableViewController`.
>
>And this pod was formerly named `JSMessagesViewController`.


## Getting Started

* **Demo project**
  * There's a fucking sweet demo project: `JSQMessages.xcworkspace`.
  * Run `pod install` first.

* **Model**
  * Your model objects should conform to the `JSQMessageData` protocol.
  * However, you may use the provided `JSQMessage` class.

* **View Controller**
  * Subclass `JSQMessagesViewController`.
  * Implement the required methods in the `JSQMessagesCollectionViewDataSource` protocol.
  * Implement the required methods in the `JSQMessagesCollectionViewDelegateFlowLayout` protocol.

* **Customizing**
  * The demo project is well-commented. This should help you configure your view however you like.

## Documentation

Read the fucking docs, [available here][docsLink] via [@CocoaDocs](https://twitter.com/CocoaDocs).

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Donate

Support the development of this **free**, open-source framework! Donate via [Square Cash](https://square.com/cash).

><h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSMessagesViewController!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSMessagesViewController!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSMessagesViewController!">Send $10</a> <em>This totally saved me time!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$25&body=Thanks for developing JSMessagesViewController!">Send $25</a> <em>I want new features!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$50&body=Thanks for developing JSMessagesViewController!">Send $50</a> <em>I love this project!</em></h4>

## Credits

Created by [@jesse_squires](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

* Assets extracted using [@0xced](https://github.com/0xced) **/** [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor).
* Originally inspired by [@soffes](http://github.com/soffes) **/** [SSMessagingViewController](https://github.com/soffes/ssmessagesviewcontroller).
* *Many thanks to [the contributors](https://github.com/jessesquires/MessagesTableViewController/graphs/contributors) of this project.*

## About

I initially developed this framework to use in [Hemoglobe](http://bit.ly/hemoglobeapp) for private messages between users. 

As it turns out, messaging is something that iOS devs and users really want. Messaging of any kind has turned out to be an increasingly popular mobile app feature in all sorts of contexts and for all sorts of reasons. Thus, I am supporting this project in my free time and have added features way beyond what Hemoglobe ever needed.

Check out my work at [Hexed Bits](http://www.hexedbits.com).

## Apps Using This Control

* [Hemoglobe](http://bit.ly/hemoglobeapp)
* [Schools App](https://itunes.apple.com/us/app/schools-app/id495845755)
* [Spabbit](https://itunes.apple.com/us/app/spabbit/id737363908)
* [Instaply](https://itunes.apple.com/us/app/instaply/id558562920)
* [Loopse](https://itunes.apple.com/us/app/loopse-spots-friends-sessions/id704783915)
* [Oxwall Messenger](https://github.com/tochman/OxwallMessenger)
* [FourChat](https://itunes.apple.com/us/app/fourchat/id650833730)
* [Quick Text Message](https://itunes.apple.com/us/app/quick-text-message-fast-sms/id583729997)
* [Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112)
* [Buhz|Hyve](http://itunes.apple.com/us/app/buhz-hyve/id818568956)
* [AwesomeChat](https://github.com/relatedcode/AwesomeChat)

## License

`JSQMessagesViewController` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2014 Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[docsLink]:http://cocoadocs.org/docsets/JSMessagesViewController/4.0.0
[mitLink]:http://opensource.org/licenses/MIT
[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[img1]:https://raw.githubusercontent.com/jessesquires/MessagesTableViewController/develop/Screenshots/screenshot0.png
[img2]:https://raw.githubusercontent.com/jessesquires/MessagesTableViewController/develop/Screenshots/screenshot1.png
