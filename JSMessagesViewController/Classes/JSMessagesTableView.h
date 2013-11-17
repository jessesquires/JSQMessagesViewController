//
//  JSMessagesTableView.h
//  LOLer
//
//  Created by Chiang Choyi on 11/17/13.
//  Copyright (c) 2013 Chiang Choyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSMessagesTableView;

@protocol JSMessagesTableViewDelegate <NSObject>
@optional
- (void) messagesTableView:(JSMessagesTableView *)tableView
              touchesBegan:(NSSet *)touches
                 withEvent:(UIEvent *)event;
@end

@interface JSMessagesTableView : UITableView

@end
