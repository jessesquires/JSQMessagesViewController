//
//  AGEmojiPageView.h
//  AGEmojiKeyboard
//
//  Created by Ayush on 09/05/13.
//  Copyright (c) 2013 Ayush. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AGEmojiPageViewDelegate;

@interface AGEmojiPageView : UIView

@property (nonatomic, assign) id<AGEmojiPageViewDelegate> delegate;
@property (nonatomic, strong) NSString *category;

/**
 Creates and returns an EmojiPageView

 @param backSpaceButtonImage Imge to be used to present the back space button.
 @param buttonsSize Size for the button representing a single emoji
 @param rows Number of rows in a single EmojiPageView
 @param columns Number of columns in a single EmojiPageView. Also represents the number of emojis shown in a row.

 @return An instance of EmojiPageView
 */
- (id)initWithFrame:(CGRect)frame
backSpaceButtonImage:(UIImage *)backSpaceButtonImage
         buttonSize:(CGSize)buttonSize
               rows:(NSUInteger)rows
            columns:(NSUInteger)columns;

/**
 Sets texts on buttons in the EmojiPageView.

 @param buttonTexts An array of texts to be set on buttons in EmojiPageView
 */
- (void)setButtonTexts:(NSMutableArray *)buttonTexts;

@end

@protocol AGEmojiPageViewDelegate <NSObject>

/**
 Delegate method called when user taps an emoji button
 @param emojiPageView EmojiPageView object on which user has tapped.
 @param emoji Emoji pressed by user
 */
- (void)emojiPageView:(AGEmojiPageView *)emojiPageView didUseEmoji:(NSString *)emoji;

/**
 Delegate method called when user taps on the backspace button
 @param emojiPageView EmojiPageView object on which user has tapped.
 */
- (void)emojiPageViewDidPressBackSpace:(AGEmojiPageView *)emojiPageView;

@end
