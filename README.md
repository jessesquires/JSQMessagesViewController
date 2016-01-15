![JSQMessagesViewController banner](https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Assets/jsq_messages_banner.png)

[![Build Status](https://secure.travis-ci.org/jessesquires/JSQMessagesViewController.svg)](https://travis-ci.org/jessesquires/JSQMessagesViewController) [![Version Status](https://img.shields.io/cocoapods/v/JSQMessagesViewController.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/JSQMessagesViewController.svg)][mitLink] [![codecov.io](https://img.shields.io/codecov/c/github/jessesquires/JSQMessagesViewController.svg)](https://codecov.io/github/jessesquires/JSQMessagesViewController) [![Platform](https://img.shields.io/cocoapods/p/JSQMessagesViewController.svg)][docsLink]

![Screenshot0][img0] &nbsp;&nbsp; ![Screenshot1][img1] &nbsp;&nbsp; 

![Screenshot2][img2] &nbsp;&nbsp; ![Screenshot3][img3]

> More screenshots available at [CocoaControls](https://www.cocoacontrols.com/controls/jsqmessagesviewcontroller)

## Features

See the [website](http://www.jessesquires.com/JSQMessagesViewController/) for the list of features.

## Dependencies

* [JSQSystemSoundPlayer][playerLink]

## Requirements

* iOS 7.0+
* ARC

## Installation

### [CocoaPods](https://cocoapods.org/) (recommended)

````ruby
# For latest release in cocoapods
pod 'JSQMessagesViewController'  

# Latest on develop
pod 'JSQMessagesViewController', :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :branch => 'develop'

# For version 5.3.2
pod 'JSQMessagesViewController', :git => 'https://github.com/jessesquires/JSQMessagesViewController', :branch => 'version_5.3.2_patch'
````

## Getting Started

````objective-c
#import <JSQMessagesViewController/JSQMessages.h>    // import all the things
````

>Read the [blog post](http://www.jessesquires.com/introducing-jsqmessagesvc-6-0/) about the 6.0 release!

* **Demo Project**
  * There's a sweet demo project: `JSQMessages.xcworkspace`.
  * Run `pod install` first.
  * [Firebase](https://www.firebase.com) also has a sweet [demo project](https://github.com/firebase/ios-swift-chat-example), and it's in Swift!

* **Message Model**
  * Your message model objects should conform to the `JSQMessageData` protocol.
  * However, you may use the provided `JSQMessage` class.
   
* **Media Attachment Model**
  * Your media attachment model objects should conform to the `JSQMessageMediaData` protocol.
  * However, you may use the provided classes: `JSQPhotoMediaItem`, `JSQLocationMediaItem`, `JSQVideoMediaItem`.
  * Creating your own custom media items is easy! Simply follow the pattern used by the built-in media types.
  * Also see `JSQMessagesMediaViewBubbleImageMasker` for masking your custom media views as message bubbles.

* **Avatar Model**
  * Your avatar model objects should conform to the `JSQMessageAvatarImageDataSource` protocol.
  * However, you may use the provided `JSQMessagesAvatarImage` class.
  * Also see `JSQMessagesAvatarImageFactory` for easily generating custom avatars.

* **Message Bubble Model**
  * Your message bubble model objects should conform to the `JSQMessageBubbleImageDataSource` protocol.
  * However, you may use the provided `JSQMessagesBubbleImage` class.
  * Also see `JSQMessagesBubbleImageFactory` and `UIImage+JSQMessages.h` for easily generating custom bubbles.

* **View Controller**
  * Subclass `JSQMessagesViewController`.
  * Implement the required methods in the `JSQMessagesCollectionViewDataSource` protocol.
  * Implement the required methods in the `JSQMessagesCollectionViewDelegateFlowLayout` protocol.
  * Set your `senderId` and `senderDisplayName`. These properties correspond to the methods found in `JSQMessageData` and determine which messages are incoming or outgoing.

* **Customizing**
  * The demo project is well-commented. Please use this as a guide.

## Questions & Help

* Review the [FAQ](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/FAQ.md).
* Search issues for previous and current [questions](https://github.com/jessesquires/JSQMessagesViewController/issues?utf8=✓&q=label%3A%22questions+%26+help%22+). *Do not open duplicates.*
* See the [StackOverflow tag](http://stackoverflow.com/questions/tagged/jsqmessagesviewcontroller), which is often the appropriate place for questions and help.
* See the [Migration Guide](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/MIGRATION.md) for migrating between major versions of the library.
* **Only ask questions that are _specific_ to this library.**
* **Please avoid emailing questions.** I prefer to keep questions and their answers open-source.

## Documentation

Read the docs, [available here][docsLink] via [@CocoaDocs](https://twitter.com/CocoaDocs).

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/CONTRIBUTING.md).

## Donate

Support the development of this **free** *open-source* library!

>*Donations made via [Square Cash](https://cash.me/).*

><h4><a href="https://cash.me/$jsq/5">Send $5</a> <em>Just saying thanks. Here's a coffee!</em> :coffee:</h4>
<h4><a href="https://cash.me/$jsq/10">Send $10</a> <em>This library is great. Lunch is on me!</em> :ramen:</h4>
<h4><a href="https://cash.me/$jsq/25">Send $25</a> <em>This totally saved me time. Go get a nice dinner!</em> :fork_and_knife:</h4>
<h4><a href="https://cash.me/$jsq/50">Send $50</a> <em>I love this library. I want new features!</em> :clap:</h4>
<h4><a href="https://cash.me/$jsq/100">Send $100</a> <em>I really want to support this project!</em> :tada:</h4>
>*You can also send donations via [PayPal](https://www.paypal.com/home). Message me on [twitter](https://twitter.com/jesse_squires).*

## Credits

Created by [**@jesse_squires**](https://twitter.com/jesse_squires).

Maintained by [**@jesse_squires**](https://twitter.com/jesse_squires) and [**@harlanhaskins**](https://twitter.com/harlanhaskins).

* Assets extracted using [**@0xced**](https://github.com/0xced) / [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor).
* Originally inspired by [**@soffes**](https://github.com/soffes) / [SSMessagingViewController](https://github.com/soffes/ssmessagesviewcontroller).
* Many thanks to [**the contributors**](https://github.com/jessesquires/JSQMessagesViewController/graphs/contributors) of this project.

## About

I initially developed this library to use in [Hemoglobe](http://bit.ly/hmglb) for private messages between users.

As it turns out, messaging is something that iOS devs and users really want. Messaging of any kind has turned out to be an increasingly popular mobile app feature in all sorts of contexts and for all sorts of reasons. Thus, I am supporting this project in my free time and have added features way beyond what Hemoglobe ever needed.

Feel free to read [my blog](http://bit.ly/jsqsf) and check out my work at [Hexed Bits](http://bit.ly/0x29A).

## Apps using this library

According to [CocoaPods stats](https://cocoapods.org/pods/JSQMessagesViewController), over **4,000 apps** are using `JSQMessagesViewController`. [Here are the ones](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/apps_using_this_library.md) that we know about. Please submit a pull request to add your app! :smile:

## License

`JSQMessagesViewController` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2013-present Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[docsLink]:http://cocoadocs.org/docsets/JSQMessagesViewController/
[podLink]:https://cocoapods.org/pods/JSQMessagesViewController
[mitLink]:http://opensource.org/licenses/MIT
[playerLink]:https://github.com/jessesquires/JSQSystemSoundPlayer

[img0]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot0.png
[img1]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot1.png
[img2]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot2.png
[img3]:https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot3.png
