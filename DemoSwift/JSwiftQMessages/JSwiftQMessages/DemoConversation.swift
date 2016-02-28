//
//  DemoConversation.swift
//  JSwiftQMessages
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import Foundation
import JSQMessagesViewController

// Tasks Crate a list of conversations to be displaed for demo
// create avatars



var conversationsList = [Conversation]()

var convo = Conversation(firstName: "first_name", lastName: "last_name", preferredName:  "preferred_name", smsNumber: "9879879879", patientId: "patient_id", latestMessage: "text", isRead: false)

func getConversation()->[Conversation]{
        conversationsList.append(convo)
        return conversationsList
    }
