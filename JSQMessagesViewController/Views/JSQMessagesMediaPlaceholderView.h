//
//  Created by Jesse Squires
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

@import Foundation;
@import UIKit;


// TODO: docs


@interface JSQMessagesMediaPlaceholderView : UIView

@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, weak, readonly) UIImageView *imageView;

+ (instancetype)viewWithActivityIndicator;

+ (instancetype)viewWithAttachmentIcon;

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
        activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    imageView:(UIImageView *)imageView;

@end
