//
//  ContentView.swift
//  Source Switcher
//
//  Created by Michał Nowak on 7/22/22.
//

import SwiftUI



struct ContentView: View {
    @State var isRunning = false
    @State var selectedSource = 18
    
    func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated
        task.standardInput = nil

        try task.run() //<--updated
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    var body: some View {
        VStack {
            Text("Switch the source of the screen!")
            Button (action: {
                try! safeShell("/usr/local/bin/ddcctl -d 1 -i 15");
                selectedSource = 15
            },
                    label: {
                Text("Display Port").frame(width: 120)
            }).disabled(selectedSource == 15)
            Button (
                action: {try! safeShell("/usr/local/bin/ddcctl -d 1 -i 17"); selectedSource = 17
                },
                label: {Text("HDMI 1").frame(width: 120)}
            ).disabled(selectedSource == 17)
            Button (
                action: {try! safeShell("/usr/local/bin/ddcctl -d 1 -i 18");
                    selectedSource = 18
                },
                label: {Text("HDMI 2").frame(width: 120)}
            ).disabled(selectedSource == 18)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 130, height: 120)
    }
}
