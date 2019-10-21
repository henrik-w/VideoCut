//
//  CutMark.swift
//  VideoCut
//
//  Created by henrik on 15.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import Cocoa
import Combine
import CoreMedia


class CutMarkList : ObservableObject /*& Codable*/ {
    var mediaFileURL : URL?
    @Published var entries: [CutMarkEntry]

    init(_ entries: [CutMarkEntry]) {
        self.entries = entries
    }
}


class CutMarkEntry : Identifiable /*& Codable*/ {
    var id = UUID()

    var interval: CMTimeRange

    var thumbnail: NSImage? {
        get {
            nil
        }
    }


    init(interval: CMTimeRange) {
        self.interval = interval
    }


    init(start: CMTime, end :CMTime) {
        self.interval = CMTimeRange(start: start, end: end)
    }
}
