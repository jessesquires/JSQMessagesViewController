//
//  JSQMessagesMedia.m
//  JSQMessages
//
//  Created by Pierluigi Cifani on 17/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesMediaHandler.h"
#import "JSQMessagesCollectionViewCell.h"

@interface JSQMessagesMediaHandler ()

@property (nonatomic, weak) JSQMessagesCollectionViewCell *cell;

@end

@implementation JSQMessagesMediaHandler

+ (instancetype)mediaHandlerWithCell:(id)cell
{
    JSQMessagesMediaHandler *instance = [self new];
    instance.cell = cell;
    return instance;
}

-(void)setCell:(JSQMessagesCollectionViewCell *)cell
{
    _cell = cell;
    
    cell.mediaImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void) setMediaFromImage:(UIImage *)image;
{
    self.cell.mediaImageView.image = image;
    [self maskImageViewWithBallon];
}

- (void) setMediaFromURL:(NSURL *)imageURL;
{

}

#pragma mark Private

- (void) maskImageViewWithBallon
{
    CALayer *layer = self.cell.messageBubbleImageView.layer;
    layer.frame    = (CGRect){{0,0},self.cell.messageBubbleImageView.layer.frame.size};
    self.cell.mediaImageView.layer.mask = layer;
    [self.cell.mediaImageView setNeedsDisplay];
}

@end
