//
//  Created by Bary Levy (2016).
//  barylevy@gmail.com
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
//  Copyright (c) 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//


#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface JSQMessagesContactView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@property (weak, nonatomic) IBOutlet UITextView *mainText;

@end
