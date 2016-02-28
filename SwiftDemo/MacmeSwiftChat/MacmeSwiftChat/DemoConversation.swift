//
//  DemoConversation.swift
//  MacmeSwiftChat
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import JSQMessagesViewController

// Tasks Crate a list of conversations to be displaed for demo
// create avatars



var conversationsList = [Conversation]()

var convo = Conversation(firstName: "Steave", lastName: "Jobs", preferredName:  "Stevie", smsNumber: "(987)987-9879", id: "33", latestMessage: "Wholy Gwackamolie batman Have you seen JSQMessagesViewController implimented in swift", isRead: false)





func getConversation()->[Conversation]{
    conversationsList.append(convo)
    return conversationsList
}
