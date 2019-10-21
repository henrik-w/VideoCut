//
//  Document.swift
//  VideoCut
//
//  Created by henrik on 15.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import Cocoa
import SwiftUI
import AVKit


class Document : NSDocument {

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }


    override class var autosavesInPlace: Bool {
        return true
    }


    override func makeWindowControllers() {
        // Create the SwiftUI view that provides the window contents.
        let documentView = DocumentView()
            .environmentObject(CutMarkList([
                CutMarkEntry(start: CMTime(seconds: 0.0, preferredTimescale: 30), end: CMTime(seconds: 15.8, preferredTimescale: 30)),
                CutMarkEntry(start: CMTime(seconds: 90.0, preferredTimescale: 30), end: CMTime(seconds: 105.4, preferredTimescale: 30))
            ]))

        // Create the window and set the content view.
        let window = NSWindow(
            contentRect: NSZeroRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.contentAspectRatio = NSMakeSize(16.0, 9.0)
        window.contentView = NSHostingView(rootView: documentView)
        window.setContentSize(NSMakeSize(640, 0))
        window.center()
        let windowController = NSWindowController(window: window)
        self.addWindowController(windowController)
    }


    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.
        // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

}

