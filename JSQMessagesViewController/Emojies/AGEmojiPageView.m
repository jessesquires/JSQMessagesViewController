//
//  AGEmojiPageView.m
//  AGEmojiKeyboard
//
//  Created by Ayush on 09/05/13.
//  Copyright (c) 2013 Ayush. All rights reserved.
//

#import "AGEmojiPageView.h"

#define BACKSPACE_BUTTON_TAG 10
#define BUTTON_FONT_SIZE 32

@interface AGEmojiPageView ()

@property (nonatomic) CGSize buttonSize;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) NSUInteger columns;
@property (nonatomic) NSUInteger rows;
@property (nonatomic) UIImage *backSpaceButtonImage;


@end

@implementation AGEmojiPageView

- (void)setButtonTexts:(NSMutableArray *)buttonTexts {

  NSAssert(buttonTexts != nil, @"Array containing texts to be set on buttons is nil");

  if (([self.buttons count] - 1) == [buttonTexts count]) {
    // just reset text on each button
      if ([self.category isEqualToString:@"Custom"]) {
          [self setCustomEmojis:buttonTexts];
      } else {
          for (NSUInteger i = 0; i < [buttonTexts count]; ++i) {
              [self.buttons[i] setTitle:buttonTexts[i] forState:UIControlStateNormal];
          }
      }
  } else {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.buttons = nil;
    self.buttons = [NSMutableArray arrayWithCapacity:self.rows * self.columns];
      if ([self.category isEqualToString:@"Custom"]) {
          [self setCustomEmojis:buttonTexts];
      } else {
          for (NSUInteger i = 0; i < [buttonTexts count]; ++i) {
              UIButton *button = [self createButtonAtIndex:i];
              [button setTitle:buttonTexts[i] forState:UIControlStateNormal];
              [self addToViewButton:button];
          }
      }
//    UIButton *button = [self createButtonAtIndex:self.rows * self.columns - 1];
//    [button setImage:self.backSpaceButtonImage forState:UIControlStateNormal];
//    button.tag = BACKSPACE_BUTTON_TAG;
//    [self addToViewButton:button];
  }
}

- (void)setCustomEmojis:(NSMutableArray *)buttonTexts{
    for (NSUInteger i = 0; i < [buttonTexts count]; ++i) {
        UIButton *button = [self createButtonAtIndex:i];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", buttonTexts[i]]] forState:UIControlStateNormal];
        [self addToViewButton:button];
    }
}
- (void)addToViewButton:(UIButton *)button {

  NSAssert(button != nil, @"Button to be added is nil");

  [self.buttons addObject:button];
  [self addSubview:button];
}

// Padding is the expected space between two buttons.
// Thus, space of top button = padding / 2
// extra padding according to particular button's pos = pos * padding
// Margin includes, size of buttons in between = pos * buttonSize
// Thus, margin = padding / 2
//                + pos * padding
//                + pos * buttonSize

- (CGFloat)XMarginForButtonInColumn:(NSInteger)column {
  CGFloat padding = ((CGRectGetWidth(self.bounds) - self.columns * self.buttonSize.width) / self.columns);
  return (padding / 2 + column * (padding + self.buttonSize.width));
}

- (CGFloat)YMarginForButtonInRow:(NSInteger)rowNumber {
  CGFloat padding = ((CGRectGetHeight(self.bounds) - self.rows * self.buttonSize.height) / self.rows);
  return (padding / 2 + rowNumber * (padding + self.buttonSize.height));
}

- (UIButton *)createButtonAtIndex:(NSUInteger)index {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.titleLabel.font = [UIFont fontWithName:@"Apple color emoji" size:BUTTON_FONT_SIZE];
  NSInteger row = (NSInteger)(index / self.columns);
  NSInteger column = (NSInteger)(index % self.columns);
  button.frame = CGRectIntegral(CGRectMake([self XMarginForButtonInColumn:column],
                                           [self YMarginForButtonInRow:row],
                                           self.buttonSize.width,
                                           self.buttonSize.height));
  [button addTarget:self
             action:@selector(emojiButtonPressed:)
   forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (id)initWithFrame:(CGRect)frame
backSpaceButtonImage:(UIImage *)backSpaceButtonImage
         buttonSize:(CGSize)buttonSize
               rows:(NSUInteger)rows
            columns:(NSUInteger)columns {
  self = [super initWithFrame:frame];
  if (self) {
    _backSpaceButtonImage = backSpaceButtonImage;
    _buttonSize = buttonSize;
    _columns = columns;
    _rows = rows;
    _buttons = [[NSMutableArray alloc] initWithCapacity:rows * columns];
  }
  return self;
}

- (void)emojiButtonPressed:(UIButton *)button {
  if (button.tag == BACKSPACE_BUTTON_TAG) {
    [self.delegate emojiPageViewDidPressBackSpace:self];
    return;
  }
  [self.delegate emojiPageView:self didUseEmoji:button.titleLabel.text];
}

@end
