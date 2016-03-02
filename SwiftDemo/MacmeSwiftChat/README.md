
## JSQMessagesViewController in a Swift Project

## Requirements

* iOS 8.0+
* Xcode 7.2+

##Communication

- If you **need help** the best place is [Stack Overflow](http://stackoverflow.com/questions/tagged/jsqmessagesViewController) tag[jsqmessagesviewcontroller, swift]
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/jsqmessagesViewController).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


Data Detectors are a default Feature

![gifLink](https://github.com/MacMeDan/JSQMessagesViewController/blob/SwiftExampleAndAwesomeDocumentation/SwiftDemo/MacmeSwiftChat/ReadmeAssets/DataDetectors.gif)


## Examples

- Check out the exsample project written in swift using JSQMessagesViewController under [SwiftDemo](https://github.com/MacMeDan/JSQMessagesViewController/tree/SwiftExampleAndAwesomeDocumentation/SwiftDemo/MacmeSwiftChat)


##Cell Customization

If you dont want the labels to be where apple likes to put them you can easily create your own cell and use that as your message view.

`
override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView?.dequeueReusableCellWithReuseIdentifier("[YOURCUSTOMCELLIDENTIFYER]", forIndexPath: indexPath)

        //Configure your cell here

    return cell
}
`
