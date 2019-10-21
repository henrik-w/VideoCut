//
//  ContentView.swift
//  VideoCut
//
//  Created by henrik on 15.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import SwiftUI
import Combine

import AVKit


struct DocumentView : View {
    @State private var sideBarVisible: Bool = UserDefaults.standard.bool(forKey:"ShowCutList")

    var body: some View {
        HSplitView {
            if sideBarVisible {
                CutMarkListView()
            }

            ContentView(sideBarVisible: $sideBarVisible)
        }
    }
}


struct ContentView : View {
    @Binding var sideBarVisible: Bool
    @EnvironmentObject var myMarks: CutMarkList

    static let url = URL(fileURLWithPath: "/Volumes/henrik/Downloads/sample.mp4", isDirectory: false)
    //static let url = URL(fileURLWithPath: "/Volumes/henrik/Downloads/main.m4v", isDirectory: false)
    //static let url = URL(fileURLWithPath: "/Volumes/henrik/Downloads/SampleCode/ViewController/adam.mov", isDirectory: false)

    var body: some View {
        VStack {
            VideoPlayerView(ContentView.url)
                .aspectRatio(ThumbnailView.ratio, contentMode: .fit)

            ZStack(alignment: .leading) {
                Toggle(isOn: $sideBarVisible) {
                    Text("Side Bar")
                }
                //.accessibility(hint: "Press to \(sideBarVisible ? "hide" : "show") the side bar")

                HStack {
                    Button(action: addNewEntry) {
                        Text("X")
                    }
                    .toolTip("Adds a new entry")
                    Button(action: {}) {
                        Text("Y")
                    }
                    .disabled(true)
                    Button(action: {}) {
                        Text("Z")
                    }
                    .disabled(true)
                }
                .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: 0.0)
            }
            .controlSize(ControlSize.small)
            .padding(.all)
            .padding(.top, -12.0)
        }
    }


    func addNewEntry() {
        myMarks.entries.append(
            CutMarkEntry(start: CMTime(seconds: 300.0, preferredTimescale: 30), end: CMTime(seconds: 315.8, preferredTimescale: 30))
        )
    }
}


#if DEBUG

struct DocumentView_Previews : PreviewProvider {

    static var previews: some View {
        //UserDefaults.standard.set(true, forKey:"ShowCutList")
        DocumentView().environmentObject(CutMarkList([
            CutMarkEntry(start: CMTime(seconds: 0.0, preferredTimescale: 30), end: CMTime(seconds: 15.8, preferredTimescale: 30)),
            CutMarkEntry(start: CMTime(seconds: 90.0, preferredTimescale: 30), end: CMTime(seconds: 105.4, preferredTimescale: 30))
        ]))
    }

}

#endif
