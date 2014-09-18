//
//  VImagePicker.h
//  VoalteClientCommon
//
//  Created by Pierluigi Cifani on 16/6/14.
//  Copyright (c) 2014 Voalte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JSQPickerHandler)(UIImage *image, NSError *error);

@interface JSQImagePicker : NSObject

- (void) pickImageFromViewController:(UIViewController *)viewController
                             handler:(JSQPickerHandler)uploadHandler
                      dismissHandler:(dispatch_block_t)dismissHandler;

@end
