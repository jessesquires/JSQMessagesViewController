//
//  DemoModelData.swift
//  JSQMessages
//
//  Created by Raphaël Bellec on 11/08/2015.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

import Foundation


class DemoModelData {
    override init() {
        self = super.init()
        
        // "if (self)" skipped here. 
        
        if (NSUserDefaults.emptyMessagesSetting) {
            self.messages = []()
        }
        else {
            self.loadFakeMessages()
        }
        
    }
    
    
    // Load some fake messages for demo.
    func loadFakeMessages() {
        
        // Fake text messages
        messages = [
            JSQMessage(senderId: kJSQDemoAvatarIdSquires, senderDisplayName:kJSQDemoAvatarDisplayNameSquires, date: NSDate.distantPast, text:"Welcome to JSQMessages: A messaging UI framework for iOS."),
            JSQMessage(senderId: kJSQDemoAvatarIdWoz    , senderDisplayName:kJSQDemoAvatarDisplayNameWoz    , date: NSDate.distantPast, text:"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy."),
            JSQMessage(senderId: kJSQDemoAvatarIdSquires, senderDisplayName:kJSQDemoAvatarDisplayNameSquires, date: NSDate.distantPast, text:"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com."),
            JSQMessage(senderId: kJSQDemoAvatarIdJobs   , senderDisplayName:kJSQDemoAvatarDisplayNameJobs   , date: NSDate.distantPast, text:"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better."),
            JSQMessage(senderId: kJSQDemoAvatarIdCook   , senderDisplayName:kJSQDemoAvatarDisplayNameCook   , date: NSDate.distantPast, text:"It is unit-tested, free, open-source, and documented."),
            JSQMessage(senderId: kJSQDemoAvatarIdSquires, senderDisplayName:kJSQDemoAvatarDisplayNameSquires, date: NSDate.distantPast, text:"Now with media messages!"),
            
        ]
        
        self.addPhotoMediaMessage
        
        
        // Setting to load extra messages for testing/demo
        if (NSUserDefaults.extraMessagesSetting) {
            // take the first 4 messages and add them to the end of message array
            messages += messages[0...3]
        }
        
        
        
        // Setting to load REALLY long message for testing/demo
        // You should see "END" twice
        if (NSUserDefaults.longMessageSetting) {
            let long_text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END"
         
            let reallyLongMessage = JSQMessage(senderId: kJSQDemoAvatarIdSquires, senderDisplayName:kJSQDemoAvatarDisplayNameSquires, date: NSDate.distantPast, text:long_text)

            messages             += reallyLongMessage

        }
    }
    
    
    
    
    
    // ------------------------------------------------------------------------------
    
    func addPhotoMediaMessage() {
        let photoItem         = JSQPhotoMediaItem( image:UIImage.imageNamed("goldengate")  )
        let photoMessage      = JSQMessage.messageWithSenderId(kJSQDemoAvatarIdSquires, displayName:kJSQDemoAvatarDisplayNameSquires, media:photoItem)
        
        messages             += photoMessage
    }
    
    func addLocationMediaMessageCompletion(completion : JSQLocationMediaItemCompletionBlock)  {
        let ferryBuildingInSF = CLLocation(latitude: 37.795313, longitude:-122.393757)
        let locationItem      = JSQLocationMediaItem()
        
        locationItem.setLocation(ferryBuildingInSF, withCompletionHandler:completion)
        
        let locationMessage   = JSQMessage.messageWithSenderId(kJSQDemoAvatarIdSquires, displayName:kJSQDemoAvatarDisplayNameSquires, media:locationItem)
        messages             += locationMessage
    }
    
    func addVideoMediaMessage{
        // don't have a real video, just pretending
        let videoURL          = NSURL(string:"file://")
        let videoItem         = JSQVideoMediaItem(fileURL:videoURL, isReadyToPlay:YES)
        let videoMessage      = JSQMessage.messageWithSenderId(kJSQDemoAvatarIdSquires, displayName:kJSQDemoAvatarDisplayNameSquires, media:videoItem)
        messages             += videoMessage
    }

    
    
    
    
    // ------------------------------------------------------------------------------

}