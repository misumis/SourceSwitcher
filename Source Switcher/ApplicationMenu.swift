//
//  ApplicationMenu.swift
//  Source Switcher
//
//  Created by Michał Nowak on 7/25/22.
//

import Foundation
import SwiftUI

class ApplicationMenu: NSObject {
    let menu = NSMenu()
    
    func createMenu() -> NSMenu {
        let view = ContentView()
        let topView = NSHostingController(rootView: view)
        topView.view.frame.size = CGSize(width: 160, height: 140)
        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view
        menu.addItem(customMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem(title:"Quit",
                                      action: #selector(quit),
                                      keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        return menu
    }
    
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
