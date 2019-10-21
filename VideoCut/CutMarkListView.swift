//
//  CutMarkListView.swift
//  VideoCut
//
//  Created by henrik on 20.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import SwiftUI
import AVKit


struct CutMarkListView : View {
    private static let color1 = Color(NSColor.textColor)
    private static let color2 = Color(NSColor.red)
    private static let color3 = Color(NSColor.green)

    @EnvironmentObject var myMarks: CutMarkList

    @State private var selectedColor = 1

    var body: some View {
        List(myMarks.entries) { cutMark in
            CutMarkListItemView(cutMark: cutMark)
                .foregroundColor(self.selectedColor == 1 ? Self.color1 : self.selectedColor == 2 ? Self.color2 : Self.color3)
                .onTapGesture(count: 2) {
                    print("Tapped two times!")
                    withAnimation(.easeInOut) { self.selectedColor = self.selectedColor == 3 ? 1 : 3 }
                }
                .onTapGesture {
                    print("Tapped once!")
                    withAnimation(.linear) { self.selectedColor = 2 }
                }
        }
        //.listStyle(SidebarListStyle())
        .controlSize(ControlSize.small) // das hier hat keine Wirkung, wenn der ListStyle angegeben ist...
        /*.onReceive(CutMarkList.ObjectWillChangePublisher) { changedObject in

         }*/
    }
}


#if DEBUG

struct CutMarkListView_Previews : PreviewProvider {

    static var previews: some View {
        let retVal = CutMarkListView() .environmentObject(CutMarkList([
            CutMarkEntry(start: CMTime(seconds: 0.0, preferredTimescale: 30), end: CMTime(seconds: 15.8, preferredTimescale: 30)),
            CutMarkEntry(start: CMTime(seconds: 90.0, preferredTimescale: 30), end: CMTime(seconds: 105.4, preferredTimescale: 30))
        ]))
        return retVal
    }
    
}

#endif
