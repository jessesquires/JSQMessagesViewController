//
//  Created by Jesse Squires
//  http://www.jessesquires.com
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

#import "UIViewController+JSQMessages.h"
#import <objc/runtime.h>

@implementation UIViewController (JSQMessages)

/**
 *  Swizzles the presentViewController:animated:completion: with jsq_presentViewController:animated:completion:
 *  Our implementation allows the category to override the view controller presentation to fix the known issue
 *  of the UITextView link long press bug in a modal UINavigationController stack.
 *
 *  See https://github.com/jessesquires/JSQMessagesViewController/issues/1247 for details.
 */
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(jsq_presentViewController:animated:completion:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

/**
 *  @brief Presents the view controller, recursively finding the best presenting view controller if the current is `nil`
 *  
 *  @see [UIViewController presentViewController: animated: completion:]
 *
 *  @param viewControllerToPresent The view controller to display over the current view controller’s content.
 *  @param flag                    Pass YES to animate the presentation; otherwise, pass NO.
 *  @param completion              The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
- (void)jsq_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    UIViewController *presentingViewController = self;
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        while (presentingViewController.presentedViewController) {
            presentingViewController = presentingViewController.presentedViewController;
        }
    }
    [presentingViewController jsq_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
