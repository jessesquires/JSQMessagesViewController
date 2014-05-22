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

#import "JSQMessagesSimpleImageViewSource.h"


@interface JSQMessagesSimpleImageViewSource()

@property (assign, nonatomic) CGSize imageSize;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *highlightedImage;

@end


@implementation JSQMessagesSimpleImageViewSource

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.imageSize = image.size;
        self.image = image;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super init];
    if (self) {
        self.imageSize = image.size;
        self.image = image;
        self.highlightedImage = highlightedImage;
    }
    return self;
}

- (void)bindImageView:(UIImageView *)view
{
    view.image = self.image;
    view.highlightedImage = self.highlightedImage;
}

@end
