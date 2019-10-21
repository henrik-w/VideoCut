//
//  CuttingItemView.swift
//  VideoCut
//
//  Created by henrik on 15.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit


struct CutMarkListItemView : View {
    static let borderWidth: CGFloat = 2.0
    static let startTimeFormatter: Formatter = {
        var df = DateFormatter()
        df.timeStyle = .medium
        df.dateStyle = .none
        return df
    } ()
    static let durationFormatter: Formatter = {
        var dif = DateIntervalFormatter()
        dif.timeStyle = .medium
        dif.dateStyle = .none
        return dif
    } ()

    @State private var showLengthAsDuration: Bool = false

    var cutMark: CutMarkEntry

    var body: some View {
        HStack {
            ThumbnailView(image: cutMark.thumbnail)
                .padding(Self.borderWidth)
                .overlay(
                    RoundedRectangle(cornerRadius: 4.0)
                        .strokeBorder(Color.secondary, lineWidth: Self.borderWidth))
                .fixedSize()

            VStack(alignment: .leading) {
                Text("Start: \(Date(timeIntervalSinceReferenceDate: cutMark.interval.start.seconds), formatter: Self.startTimeFormatter)")
                if showLengthAsDuration {
                    Text("Duration: \(DateInterval(start: Date(timeIntervalSinceReferenceDate: cutMark.interval.start.seconds), duration: cutMark.interval.duration.seconds), formatter: Self.durationFormatter)")
                } else {
                    Text("Duration: \(Date(timeIntervalSinceReferenceDate: (cutMark.interval.end - cutMark.interval.start).seconds), formatter: Self.startTimeFormatter)")
                }
            }
            //.fixedSize()
            .lineLimit(1)
            .truncationMode(.tail)
        }
    }
}


struct ThumbnailView : NSViewRepresentable {
    static let ratio: CGFloat = 16.0 / 9.0    // 4.0 / 3.0

    var image: NSImage?

    func makeNSView(context: NSViewRepresentableContext<ThumbnailView>) -> NSImageView {
        if image != nil {
            return NSImageView(image: image!)
        }

        return NSImageView(image: NSImage(
            size: NSMakeSize(64, 64 / Self.ratio),
            flipped: false,
            drawingHandler: { (dstRect) -> Bool in
                /*let cornerRadius = dstRect.height * 0.02
                let path = NSBezierPath(roundedRect: dstRect,
                                        xRadius: cornerRadius,
                                        yRadius: cornerRadius)*/
                let path = NSBezierPath(rect: dstRect)
                path.fill()

                /*path.lineWidth = dstRect.height * 0.01
                path.stroke()*/

                return true
            }))
    }

    func updateNSView(_ nsView: NSImageView, context: NSViewRepresentableContext<ThumbnailView>) {
        // TODO: If the cutMark changed you have to update the thumb nail image
    }
}


#if DEBUG

struct CuttingItemView_Previews : PreviewProvider {

    static var previews: some View {
        CutMarkListItemView(cutMark: CutMarkEntry(start: CMTime(seconds: 0.0, preferredTimescale: 30), end: CMTime(seconds: 15.8, preferredTimescale: 30)))
    }

}

#endif
