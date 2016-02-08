//
//  Message.swift
//  LayerTest
//
//  Created by Haroon on 26/02/2015.
//  Copyright (c) 2015 MotionKitsasv. All rights reserved.
//

import Foundation

class Message : NSObject, JSQMessageData {
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    func senderId() -> String! {
       return sender_
    }
    
    func senderDisplayName() -> String! {
        return sender_
    }
    
    func date() -> NSDate! {
        return date_
    }
    
    func isMediaMessage() -> Bool {
        return false
    }
    func hash() -> UInt {
        var signed = rand()
        let unsigned = signed >= 0 ?
            UInt(signed) :
            UInt(signed  - Int.min) + UInt(Int.max) + 1
        return unsigned
    }
    
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
}