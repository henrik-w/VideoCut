//
//  VideoPlayerView.swift
//  VideoCut
//
//  Created by henrik on 25.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import SwiftUI
import AVKit


struct VideoPlayerView : NSViewRepresentable {
    typealias NSViewType = AVPlayerView

    private var url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeNSView(context: Context) -> NSViewType {
        let playerView = AVPlayerView()

        playerView.controlsStyle = AVPlayerViewControlsStyle.inline
        //retVal.showsFrameSteppingButtons = true
        playerView.showsFullScreenToggleButton = false
        playerView.showsSharingServiceButton = false
        playerView.showsTimecodes = true
        // TODO: custom navigation controls with: playerView.contentOverlayView?.addSubview(NSHostingView(rootView: CustomVideoControlView()))

        if playerView.player == nil {
            NSLog("creating new player")
            let p = AVPlayer(url: ContentView.url)
            if p.status != .readyToPlay {
                NSLog("Player-Status: \(p.status.rawValue)")
                if p.error != nil {
                    NSLog("Error creating new player: \(p.error!.localizedDescription)")
                    playerView.presentError(p.error!)
                }
            } else {
                playerView.player = p
            }
        } else {
            NSLog("replacing player item")
            playerView.player!.replaceCurrentItem(with: AVPlayerItem(url: ContentView.url))
        }
        
        return playerView
    }


    func updateNSView(_ nsView: NSViewType, context: Context) {
        //print(context.coordinator)
    }
}


struct CustomVideoControlView : View {
    var body: some View {
        Text("neue Control-Views hier her")
    }
}


#if DEBUG

struct VideoPlayerView_Previews : PreviewProvider {
    static var previews: some View {
        VideoPlayerView(URL(fileURLWithPath: "/Volumes/henrik/Downloads/sample.mp4", isDirectory: false))
    }
}

#endif
