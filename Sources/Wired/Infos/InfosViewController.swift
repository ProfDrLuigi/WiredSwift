//
//  InfoViewController.swift
//  WiredSwift
//
//  Created by Rafael Warnault on 19/02/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//

import Cocoa

class InfosViewController: ConnectionViewController, ConnectionDelegate {
    
    @IBOutlet weak var bannerImage: NSImageView!
    @IBOutlet weak var serverNameLabel: NSTextField!
    @IBOutlet weak var serverDescriptionLabel: NSTextField!
    @IBOutlet weak var uptimeLabel: NSTextField!
    @IBOutlet weak var urlLabel: NSTextField!
    @IBOutlet weak var filesLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var protocolLabel: NSTextField!
    @IBOutlet weak var cipherLabel: NSTextField!
    @IBOutlet weak var compressionLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    override var representedObject: Any? {
        didSet {
            if let c = self.representedObject as? ServerConnection {
                self.connection = c
                                
                c.delegates.append(self)
                
                self.updateView()
            }
        }
    }
    
    
    private func updateView() {
        guard let connection = self.connection,
              let serverInfo = connection.serverInfo else { return }

        self.serverNameLabel.stringValue = serverInfo.serverName
        self.serverDescriptionLabel.stringValue = serverInfo.serverDescription

        if let appName = serverInfo.applicationName,
           let appVersion = serverInfo.applicationVersion,
           let osName = serverInfo.osName,
           let osVersion = serverInfo.osVersion,
           let arch = serverInfo.arch {
            self.versionLabel.stringValue = "\(appName) \(appVersion) on \(osName) \(osVersion) (\(arch))"
        } else {
            self.versionLabel.stringValue = "-"
        }

        if let remoteName = connection.socket.remoteName,
           let remoteVersion = connection.socket.remoteVersion {
            self.protocolLabel.stringValue = "\(remoteName) \(remoteVersion)"
        } else {
            self.protocolLabel.stringValue = "-"
        }

        self.cipherLabel.stringValue = "\(P7Socket.CipherType.pretty(connection.socket.cipherType))"
        self.urlLabel.stringValue = "wiredp7://\(connection.url.hostname):\(connection.url.port)"
        let unsupported = NSLocalizedString("Unsupported (yet)", comment: "")
        self.compressionLabel.stringValue = unsupported

        if let bannerData = serverInfo.serverBanner,
           let image = NSImage(data: bannerData) {
            self.bannerImage.image = image
        } else {
            self.bannerImage.image = nil
        }

        if let startTime = serverInfo.startTime {
            let interval = Date().timeIntervalSince(startTime)
            self.uptimeLabel.stringValue = AppDelegate.timeIntervalFormatter.string(from: interval) ?? "-"
        } else {
            self.uptimeLabel.stringValue = "-"
        }

        if let filesCount = serverInfo.filesCount {
            self.filesLabel.stringValue = "\(filesCount)"
        } else {
            self.filesLabel.stringValue = "-"
        }

        self.sizeLabel.stringValue = AppDelegate.byteCountFormatter.string(fromByteCount: Int64(serverInfo.filesSize))
    }
    
    
    
    // MARK: Connection Delegate -
    
    func connectionDidConnect(connection: Connection) {
        
    }
    
    func connectionDidFailToConnect(connection: Connection, error: Error) {
        
    }
    
    func connectionDisconnected(connection: Connection, error: Error?) {
        
    }
    
    func connectionDidReceiveMessage(connection: Connection, message: P7Message) {
        
    }
    
    func connectionDidReceiveError(connection: Connection, message: P7Message) {
        
    }
}

