//
//  Transfer+CoreDataClass.swift
//  WiredSwift
//
//  Created by Rafael Warnault on 22/02/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//
//

import Foundation
import CoreData


public class Transfer: NSManagedObject {
    public var connection: Connection!
    public var transferConnection: TransferConnection?
    public var file:File?
    public var error:String = ""
    
    public func transferStatus() -> String {
        return "\(state) \(error)"
    }
    
    public func isWorking() -> Bool {
        return (state == .Waiting || state == .Queued ||
                state == .Listing || state == .CreatingDirectories ||
                state == .Running)
    }

    public func isTerminating() -> Bool {
        return (state == .Pausing || state == .Stopping ||
                state == .Disconnecting || state == .Removing)
    }

    public func isStopped() -> Bool {
        return (state == .Paused || state == .Stopped ||
                state == .Disconnected || state == .Finished)
    }
}
