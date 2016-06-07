//
//  DemoConversation.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import JSQMessagesViewController

// User Enum to make it easyier to work with.
enum User: String {
    case Leonard    = "053496-4509-288"
    case Squires    = "053496-4509-289"
    case Jobs       = "707-8956784-57"
    case Cook       = "468-768355-23123"
    case Wazniak    = "309-41802-93823"
}

// Helper Function to get usernames for a secific User.
func getName(user: User) -> String{
    switch user {
    case .Leonard:
        return "Dan Leonard"
    case .Squires:
        return "Jesse Squires"
    case .Cook:
        return "Tim Cook"
    case .Wazniak:
        return "Steve Wazniak"
    case .Jobs:
        return "Steve Jobs"
    }
}

// Create Avatars Once for performance
//
// Create an avatar with Image

let AvatarLeonard = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("DL", backgroundColor: UIColor.jsq_messageBubbleGreenColor(), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

// Create avatar with Initals and no Image
let AvatarCook = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("TC", backgroundColor: UIColor.grayColor(), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

// Create avatar with Placeholder Image
let AvatarJobs = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("SJ", backgroundColor: UIColor.jsq_messageBubbleGreenColor(), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

let AvatarWaz = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("SW", backgroundColor: UIColor.jsq_messageBubbleGreenColor(), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

let AvatarSquires = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("JSQ", backgroundColor: UIColor.grayColor(), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

// Helper Method for getting an avatar for a specific User.
func getAvatar(id: String) -> JSQMessagesAvatarImage{
    switch id {
    case "053496-4509-288":
        return AvatarLeonard
    case "053496-4509-289":
        return AvatarSquires
    case "468-768355-23123":
        return AvatarCook
    case "309-41802-93823":
        return AvatarWaz
    case "707-8956784-57":
        return AvatarJobs
    default:
        return JSQMessagesAvatarImage()
    }
}


// INFO: Creating Static Demo Data. This is only for the exsample project to show the framework at work.
var conversationsList = [Conversation]()

var convo = Conversation(firstName: "Steave", lastName: "Jobs", preferredName:  "Stevie", smsNumber: "(987)987-9879", id: "33", latestMessage: "Holy Guacamole, JSQ in swift", isRead: false)

var conversation = [JSQMessage]()

let message = JSQMessage(senderId: User.Cook.rawValue, displayName: getName(User.Cook), text: "What is this Black Majic?")
let message2 = JSQMessage(senderId: User.Squires.rawValue, displayName: getName(User.Squires), text: "It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy")
let message3 = JSQMessage(senderId: User.Wazniak.rawValue, displayName: getName(User.Wazniak), text: "It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com.")
let message4 = JSQMessage(senderId: User.Jobs.rawValue, displayName: getName(User.Jobs), text: "JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better.😏")
let message5 = JSQMessage(senderId: User.Leonard.rawValue, displayName: getName(User.Leonard), text: "It is unit-tested, free, open-source, and documented.")

func makeConversation()->[JSQMessage]{
    conversation = [message, message2,message3, message4, message5]
    return conversation
}

func getConversation()->[Conversation]{
    return [convo]
}