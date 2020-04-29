//
//  BlockConnection.swift
//  Wired iOS
//
//  Created by Rafael Warnault on 29/04/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//

import Foundation

class BlockConnection: Connection {
    var transactionCounter:UInt32 = 0
    var progressBlocks:[UInt32:(P7Message) -> Void] = [:]
    var completionBlocks:[UInt32:(P7Message?) -> Void] = [:]
    
    public func send(message: P7Message, progressBlock: (P7Message) -> Void, completionBlock: (P7Message?) -> Void)  {
        self.transactionCounter += 1
        
        if self.socket.connected {
            message.addParameter(field: "wired.transaction", value: self.transactionCounter)
            
            if !self.socket.write(message) {
                completionBlock(nil)
            }
        } else {
            completionBlock(nil)
        }
    }
    
    
    override func handleMessage(_ message: P7Message) {
        guard let transaction = message.uint32(forField: "wired.transaction") else {
            return
        }
        
        switch message.name {
        case "wired.send_ping":
            super.pingReply()
            
        case "wired.error":
            if let completionBlock = completionBlocks[transaction] {
                completionBlock(message)
            }
                    
        default:
            if message.name == "wired.okay" {
                if let completionBlock = completionBlocks[transaction] {
                    completionBlock(message)
                }
            } else {
                if let progressBlock = progressBlocks[transaction] {
                    progressBlock(message)
                }
            }
        }
    }
}
