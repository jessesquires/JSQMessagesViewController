//
//  JSMessagesTableView.m
//  LOLer
//
//  Created by Chiang Choyi on 11/17/13.
//  Copyright (c) 2013 Chiang Choyi. All rights reserved.
//

#import "JSMessagesTableView.h"

@implementation JSMessagesTableView

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    id<JSMessagesTableViewDelegate> delegate = (id<JSMessagesTableViewDelegate>)self.delegate;
    [delegate messagesTableView:self touchesBegan:touches withEvent:event];
}

@end
