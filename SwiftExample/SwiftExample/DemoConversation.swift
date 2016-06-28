//
//  DemoConversation.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import JSQMessagesViewController

// Create Names to display
let DisplayNameSquires = "Jesse Squires"
let DisplayNameLeonard = "Dan Leonard"
let DisplayNameCook = "Tim Cook"
let DisplayNameJobs = "Steve Jobs"
let DisplayNameWoz = "Steve Wazniak"

// Create Unique IDs for avatars
let AvatarIDLeonard = "053496-4509-288"
let AvatarIDSquires = "053496-4509-289"
let AvatarIdCook = "468-768355-23123"
let AvatarIdJobs = "707-8956784-57"
let AvatarIdWoz = "309-41802-93823"

// INFO: Creating Static Demo Data. This is only for the exsample project to show the framework at work.
var conversationsList = [Conversation]()

var convo = Conversation(firstName: "Steave", lastName: "Jobs", preferredName:  "Stevie", smsNumber: "(987)987-9879", id: "33", latestMessage: "Holy Guacamole, JSQ in swift", isRead: false)

var conversation = [JSQMessage]()

let message = JSQMessage(senderId: AvatarIdCook, displayName: DisplayNameCook, text: "What is this Black Majic?")
let message2 = JSQMessage(senderId: AvatarIDSquires, displayName: DisplayNameSquires, text: "It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy")
let message3 = JSQMessage(senderId: AvatarIdWoz, displayName: DisplayNameWoz, text: "It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com.")
let message4 = JSQMessage(senderId: AvatarIdJobs, displayName: DisplayNameJobs, text: "JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better.")
let message5 = JSQMessage(senderId: AvatarIDLeonard, displayName: DisplayNameLeonard, text: "It is unit-tested, free, open-source, and documented.")


let message6 = JSQMessage(senderId: AvatarIDLeonard, displayName: DisplayNameLeonard, text: "This is incredible")
let message7 = JSQMessage(senderId: AvatarIdWoz, displayName: DisplayNameLeonard, text: "I would have to agree")
let message8 = JSQMessage(senderId: AvatarIDLeonard, displayName: DisplayNameLeonard, text: "It is unit-tested, free, open-source, and documented like a boss.")
let message9 = JSQMessage(senderId: AvatarIdWoz, displayName: DisplayNameLeonard, text: "You guys need an award for this, I'll talk to my people at Apple. 💯 💯 💯")

func makeGroupConversation()->[JSQMessage] {
    conversation = [message, message2,message3, message4, message5]
    return conversation
}

func makeNormalConversation() -> [JSQMessage] {
    conversation = [message6, message7, message8, message9]
    return conversation
}
