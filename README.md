![JSQMessagesViewController banner](https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Assets/jsq_messages_banner.png)

[![Build Status](https://secure.travis-ci.org/jessesquires/JSQMessagesViewController.svg)](http://travis-ci.org/jessesquires/JSQMessagesViewController) [![Version Status](http://img.shields.io/cocoapods/v/JSQMessagesViewController.png)][docsLink] [![license MIT](http://img.shields.io/badge/license-MIT-orange.png)][mitLink]

### Update: 6.0-beta6 is out! See [#476](https://github.com/jessesquires/JSQMessagesViewController/issues/476) for details.

![Messages Screenshot 1][img1] &nbsp;&nbsp;&nbsp; ![Messages Screenshot 2][img2]

> More screenshots available at [CocoaControls](https://www.cocoacontrols.com/controls/jsqmessagesviewcontroller)

## Requirements

* iOS 7.0+
* ARC
* [JSQSystemSoundPlayer][playerLink]

*Need support for iOS 6? [You shouldn't](http://www.macrumors.com/2014/07/14/apple-ios-7-adoption-90-percent/). But, there's a branch for that!*
````
git checkout iOS6_support_stable
````

*Note: the `iOS6_support_stable` branch does not include many of the latest hip and fancy features or fixes*

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

For iOS 6.0 support:
````
pod 'JSMessagesViewController', :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :branch => 'iOS6_support_stable'
````

## Getting Started

````
#import <JSQMessagesViewController/JSQMessages.h>    // import all headers
````

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

Support the development of this **free**, open-source library!

>*Donations made via [Square Cash](https://square.com/cash)*

><h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSQMessagesViewController!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSQMessagesViewController!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSQMessagesViewController!">Send $10</a> <em>This totally saved me time!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$25&body=Thanks for developing JSQMessagesViewController!">Send $25</a> <em>I want new features!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$50&body=Thanks for developing JSQMessagesViewController!">Send $50</a> <em>I love this project!</em></h4>
>*You can also send donations via [PayPal](https://www.paypal.com) to jesse.squires.developer@gmail.com*

## Credits

Created by [**@jesse_squires**](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

* Assets extracted using [**@0xced**](https://github.com/0xced) / [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor).
* Originally inspired by [**@soffes**](http://github.com/soffes) / [SSMessagingViewController](https://github.com/soffes/ssmessagesviewcontroller).
* Many thanks to [**the contributors**](https://github.com/jessesquires/JSQMessagesViewController/graphs/contributors) of this project.

## About

I initially developed this library to use in [Hemoglobe](http://bit.ly/hmglb) for private messages between users.

As it turns out, messaging is something that iOS devs and users really want. Messaging of any kind has turned out to be an increasingly popular mobile app feature in all sorts of contexts and for all sorts of reasons. Thus, I am supporting this project in my free time and have added features way beyond what Hemoglobe ever needed.

Feel free to check out my work at [Hexed Bits](http://bit.ly/0x29A), or read [my blog](http://bit.ly/jsqsf).

## Apps using this library

* [Hemoglobe](http://bit.ly/hemoglobeapp)
* [ClassDojo](https://itunes.apple.com/us/app/classdojo/id552602056)
* [Schools App](https://itunes.apple.com/us/app/schools-app/id495845755)
* [ChatSecure](https://chatsecure.org)
* [Kytt](https://itunes.apple.com/de/app/kytt-neue-leute-in-der-umgebung/id848959696)
* [Spark Social](https://itunes.apple.com/us/app/spark-social/id823785892)
* [Spabbit](https://itunes.apple.com/us/app/spabbit/id737363908)
* [Elodie](https://itunes.apple.com/app/elodie/id821610181)
* [Instaply](https://itunes.apple.com/us/app/instaply/id558562920)
* [Loopse](https://itunes.apple.com/us/app/loopse-spots-friends-sessions/id704783915)
* [Oxwall Messenger](https://github.com/tochman/OxwallMessenger)
* [FourChat](https://itunes.apple.com/us/app/fourchat/id650833730)
* [vCinity](https://itunes.apple.com/us/app/vcinity-chat-without-internet/id875395391)
* [Quick Text Message](https://itunes.apple.com/us/app/quick-text-message-fast-sms/id583729997)
* [Libraries for developers](https://itunes.apple.com/us/app/libraries-for-developers/id653427112)
* [Buhz|Hyve](http://itunes.apple.com/us/app/buhz-hyve/id818568956)
* [PocketSuite](https://itunes.apple.com/us/app/pocketsuite/id721795146)
* [Ringring.io](https://github.com/ringring-io/ringring-ios)
* [gDecide](https://itunes.apple.com/ca/app/gdecide/id716801285)
* [AwesomeChat](https://github.com/relatedcode/AwesomeChat)
* [ParseChat](https://github.com/relatedcode/ParseChat)
* *Your app here*

## License

`JSQMessagesViewController` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2014 Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[docsLink]:http://cocoadocs.org/docsets/JSQMessagesViewController
[mitLink]:http://opensource.org/licenses/MIT
[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[img1]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot0.png
[img2]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot1.png
