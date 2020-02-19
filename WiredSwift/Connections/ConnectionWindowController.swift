//
//  ConnectionWindowController.swift
//  WiredSwift
//
//  Created by Rafael Warnault on 18/02/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//

import Cocoa

class ConnectionWindowController: NSWindowController {
    public var connection: Connection!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(windowWillClose(notification:)), name: NSWindow.willCloseNotification, object: self.window)
    }
    

    
    @objc func windowWillClose(notification: Notification) -> Void {
        if let w = notification.object as? NSWindow, w == self.window {
            self.safeCloseWindow()
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    override func close() {
        self.safeCloseWindow()
    
        super.close()
    }

    
    private func safeCloseWindow() {
        if self.connection != nil {
            ConnectionsController.shared.removeConnection(self.connection)
            self.connection.disconnect()
        }
    }
}