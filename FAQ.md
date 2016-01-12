# FAQ

*Frequently asked questions for JSQMessagesViewController.* 

Contributions are welcome! Please submit a [pull request](https://github.com/jessesquires/JSQMessagesViewController/compare).

------------------------------------

## For 7.x.x

#### Using `UITabBar` ?

Is the library compatible with `UITabBarController` and `UITabBar`? Yes and no. For the history on this issue, see [#179](https://github.com/jessesquires/JSQMessagesViewController/issues/179) and [#94](https://github.com/jessesquires/JSQMessagesViewController/issues/94). This seems to be the best workaround:

````objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
````

#### *Springy bubbles?*

:warning: Note: this feature is still experimental.

````objective-c
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}
````

#### *Remove avatars?*
````objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
````

#### *Need customize your collection view cells?*

There are 2 approaches to this, which one you choose depends on your needs.

1. Customize appearance and behavior of existing cells. (Easy)
2. Provide your own completely custom cell prototypes. (Hard)

> Also see [previous issues](https://github.com/jessesquires/JSQMessagesViewController/issues?utf8=✓&q=%5BCustomize+cells%5D+in%3Atitle+).

##### (1) Customizing existing cells

If you only need to make minor changes to the existing cells (colors, data detectors, etc.), then you simply need to override the following method. You have access to all properties on the cell. ([docs](http://cocoadocs.org/docsets/JSQMessagesViewController/7.2.0/Classes/JSQMessagesCollectionViewCell.html))

````objective-c
- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    // Customize the shit out of this cell
    // See the docs for JSQMessagesCollectionViewCell
    
    return cell;
}
````

##### (2) Providing your own cell prototypes

This approach is more involved, but gives you greater flexibility. If you need to add or modify subviews of the cell, use this approach. ([docs](http://cocoadocs.org/docsets/JSQMessagesViewController/7.2.0/Classes/JSQMessagesViewController.html))

1. You need to provide your own cell subclasses, similar to the library's `JSQMessagesCollectionViewCell`, `JSQMessagesCollectionViewCellIncoming`, `JSQMessagesCollectionViewCellOutgoing`.
2. On your `JSQMessagesViewController` subclass, set the following properties according to your classes:
    - `outgoingCellIdentifier`
    - `outgoingMediaCellIdentifier`
    - `incomingCellIdentifier`
    - `incomingMediaCellIdentifier`
3. Register your cell classes/nibs with the collection view and the identifiers above
4. Override `-collectionView: cellForItemAtIndexPath:`. Do not call `super`. Since you are providing your own cells, calling `super` will perform a bunch of unnecessary work.
5. (Optional) For your model objects, implement `JSQMessageData` or subclass `JSQMessage` and extend to your needs.

#### *Customize your toolbar buttons?*
````objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // This button will call the `didPressAccessoryButton:` selector on your JSQMessagesViewController subclass
    self.inputToolbar.contentView.leftBarButtonItem = /* custom button or nil to remove */
    
    // This button will call the `didPressSendButton:` selector on your JSQMessagesViewController subclass
    self.inputToolbar.contentView.rightBarButtonItem = /* custom button or nil to remove */
    
    // Swap buttons, move send button to the LEFT side and the attachment button to the RIGHT
    // For RTL language support
    self.inputToolbar.contentView.leftBarButtonItem = [JSQMessagesToolbarButtonFactory defaultSendButtonItem];
    self.inputToolbar.contentView.rightBarButtonItem = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    
    // The library will call the correct selector for each button, based on this value
    self.inputToolbar.sendButtonOnRight = NO;
}
````
