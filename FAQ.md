# FAQ

*Frequently asked questions for JSQMessagesViewController*

------------------------------------

##### *Springy bubbles?*
````objective-c
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}
````

##### *Remove avatars?*
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

##### *Customize your cells?*
````objective-c
- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    // Customize the shit out of this cell
    // See the docs for JSQMessagesCollectionViewCell
    
    return cell;
}
````

##### *Customize your toolbar buttons?*
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
