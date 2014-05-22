//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/**
 *  An object that adopts the `JSQMessagesImageViewSource` protocol is responsible for configuring an
 *  entrusted `UIImageView` with image data.
 *  A typical usage is to display an image which is retrieved asynchronously.
 *  Presentation code configures geometry according to the `imageSize` provided by
 *  this object and binds a `UIImageView` instance to it. When image is finally retrieved,
 *  the object updates the bound image view.
 */
@protocol JSQMessagesImageViewSource <NSObject>

@required

/**
 *  Asks the receiver for the size of image to be presented.
 *
 *  @return A size of the image to be presented in the bound image view.
 */
- (CGSize)imageSize;

/**
 *  Binds an image view to the receiver.
 *
 *  @param imageView    Image view to be used for displaying images.
 *
 *  @discussion When provided images are not needed anymore, this method must be called
 *  with `nil` parameter, so the implementation has the opportunity to cancel any
 *  asynchronous request
 */
- (void)bindImageView:(UIImageView *)imageView;

@end
