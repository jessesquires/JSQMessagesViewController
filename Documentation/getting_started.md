# Getting Started

*Getting started guide for JSQMessagesViewController*

-----------------------------

## For versions 6.x and 7.x

````objective-c
#import <JSQMessagesViewController/JSQMessages.h>    // import all the things
````

* **Tutorials and blogs**
  * Read the [blog post](http://www.jessesquires.com/introducing-jsqmessagesvc-6-0/) about the 6.0 release!
  * Ray Wenderlich has a [great tutorial](http://www.raywenderlich.com/122148/firebase-tutorial-real-time-chat), written by [David East](https://twitter.com/_davideast). (For 7.x releases)

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

## Previous versions

Sorry! Guides are not available for older versions of the library.
