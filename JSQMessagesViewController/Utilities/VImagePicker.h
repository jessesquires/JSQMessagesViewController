//
//  VImagePicker.h
//  VoalteClientCommon
//
//  Created by Pierluigi Cifani on 16/6/14.
//  Copyright (c) 2014 Voalte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VPickerHandler)(UIImage *image, NSError *error);

@interface VImagePicker : NSObject

- (void) pickImageFromViewController:(UIViewController *)viewController
                             handler:(VPickerHandler)uploadHandler
                      dismissHandler:(dispatch_block_t)dismissHandler;

@end
