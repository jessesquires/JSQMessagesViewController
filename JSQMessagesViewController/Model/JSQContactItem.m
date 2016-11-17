//  Created by Bary Levy
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
//  Copyright (c) 2016 Bary Levy
//  Released under an MIT license: http://opensource.org/licenses/MIT
//


#import "JSQContactItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "JSQMessagesContactView.h"
#import <Contacts/CNContactFormatter.h>
#import "UIColor+JSQMessages.h"

@interface JSQContactItem ()

@property (strong, nonatomic) UIView *cachedContactView;

@end


@implementation JSQContactItem

#pragma mark - Initialization

- (instancetype)initWithContact:(CNContact *)contact
{
    self = [super init];
    if (self) {
        _contact = [contact copy];
        _cachedContactView = nil;
    }
    return self;
}

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedContactView = nil;
}

- (CGSize)mediaViewDisplaySize
{
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        return CGSizeMake(315.0f, 225.0f);
//    }
    
    return CGSizeMake(250.0f, 77.0f);
}
#pragma mark - Setters

- (void)setContact:(CNContact *)contact
{
    _contact = [contact copy];
    _cachedContactView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedContactView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.contact == nil) {
        return nil;
    }
    
    if (self.cachedContactView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        
        JSQMessagesContactView *contactView = [[[NSBundle bundleForClass:[JSQMessagesContactView class]] loadNibNamed:@"JSQMessagesContactView" owner:self options:nil] objectAtIndex:0];

        contactView.backgroundColor = [UIColor jsq_messageBubbleLightGrayColor];

        //Default
        NSString* address = nil;
        NSString* detailsText = nil;
        
        NSString* name = [[CNContactFormatter new] stringFromContact:self.contact];
        
        // PHONE NUMBER
        NSArray<CNLabeledValue<CNPhoneNumber*>*>* arrPN = self.contact.phoneNumbers;
        if(arrPN != nil &&  arrPN.count > 0)
        {
            CNPhoneNumber* pn = arrPN[0].value;
            detailsText = pn.stringValue;
        }
        
        // ADDRESS
        if( [self.contact isKeyAvailable:CNContactPostalAddressesKey])//postalAddresses!=nil)
        {            
            NSArray<CNLabeledValue<CNPostalAddress*>*>* arrAddr = self.contact.postalAddresses;
            if(arrAddr != nil &&  arrAddr.count > 0)
            {
                CNPostalAddress* pa = arrAddr[0].value;
                address = [CNPostalAddressFormatter stringFromPostalAddress:pa style:CNPostalAddressFormatterStyleMailingAddress];
            }
        }
        if (self.contact.imageData!=nil) {
            
            UIImage *image=[UIImage imageWithData:self.contact.imageData];
            
            contactView.contactImage.image = image;
            [self circleImage:contactView.contactImage];
        }
        else
        {
//            [contactView.contactImage setImageWithString:name color:[UIColor grayColor] circular:true textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0f], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }
        contactView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);

        [self circleImage:contactView.contactImage];

        contactView.mainText.text = name;
        
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:contactView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedContactView = contactView;
    }
    
    return self.cachedContactView;
}

-(void) circleImage:(UIImageView*)imageView
{
 
//        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
//        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.layer.masksToBounds = true;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size,false, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if( context!=nil)
    {
        [imageView.layer renderInContext:context];
        UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
}
    
- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.contact.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.contact, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contact = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(contact))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.contact forKey:NSStringFromSelector(@selector(contact))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQContactItem *copy = [[JSQContactItem allocWithZone:zone] initWithContact:self.contact];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}
-(void) deleteMedia
{
    
}

@end


