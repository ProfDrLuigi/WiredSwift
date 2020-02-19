//
//  ConnectionObject.swift
//  WiredSwift
//
//  Created by Rafael Warnault on 19/02/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//

import Cocoa

public class ConnectionObject: NSObject {
    public var connection: Connection!
    
    public init(_ connection: Connection) {
        self.connection = connection
    }
}
