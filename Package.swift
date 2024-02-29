// swift-tools-version:5.2
//
//  Package.swift
//  WiredSwift
//
//  Created by Rafael Warnault on 17/04/2020.
//  Copyright © 2020 Read-Write. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "WiredSwift",
    platforms: [
        // Add support for all platforms starting from a specific version.
        .macOS(.v10_13),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "WiredSwift",
            targets: ["WiredSwift"])
    ],
    dependencies: [
        .package(name: "AEXML", url: "https://github.com/tadija/AEXML.git", from: "4.7.0"),
        .package(name: "CryptoSwift", url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.1"),
        .package(name: "CryptorRSA", url: "https://github.com/IBM-Swift/BlueRSA", from: "1.0.201"),
        .package(name: "CZlib", url: "https://github.com/IBM-Swift/CZlib.git", from: "0.1.2"),
        .package(name: "Gzip", url: "https://github.com/1024jp/GzipSwift", from: "6.0.1"),
        .package(name: "SocketSwift", url: "https://github.com/BiAtoms/Socket.swift.git", from: "2.4.0"),
    ],
    targets: [
        .target(name: "WiredSwift", dependencies: [
            "AEXML",
            "CryptoSwift",
            "CryptorRSA",
            "CZlib",
            "Gzip",
            "SocketSwift"
        ])
    ]
)
