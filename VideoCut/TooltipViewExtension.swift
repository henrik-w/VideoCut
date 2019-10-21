//
//  TooltipViewExtension.swift
//  VideoCut
//
//  Created by henrik on 19.10.19.
//  Copyright © 2019 hackmac. All rights reserved.
//

import SwiftUI


public extension View {
    /// Overlays this view with a view that provides a toolTip with the given string.
    func toolTip(_ toolTip: String?) -> some View {
        self.overlay(TooltipView(toolTip))
    }
}


private struct TooltipView: NSViewRepresentable {
    typealias NSViewType = NSView

    let toolTip: String?

    init(_ toolTip: String?) {
        self.toolTip = toolTip
    }

    func makeNSView(context: NSViewRepresentableContext<TooltipView>) -> NSView {
        let view = NSView()
        view.toolTip = self.toolTip
        return view
    }

    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<TooltipView>) {
    }
}
