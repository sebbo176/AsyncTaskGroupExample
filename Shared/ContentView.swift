//
//  ContentView.swift
//  Shared
//
//  Created by Sebastian Bolling on 2022-04-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, task group!")
            .padding()
            .onAppear(perform: waitForAllVoidExample)
//            .onAppear(perform: waitForIntExample)
    }

    func waitForAllVoidExample() {
        Task {
            try await withThrowingTaskGroup(of: (Void).self) { group in
                for _ in 1...5 {
                    group.addTask {
                        try await asyncVoidFunction()
                    }
                }

                NSLog("This will be printed before all tasks are done")
                try await group.waitForAll()
                NSLog("This will be printed when all tasks are done")
            }
        }
    }

    func asyncVoidFunction() async throws {
        let id = Int.random(in: 1...1000)
        NSLog("\(id) start")

        try await Task.sleep(nanoseconds: 2_000_000_000)
        NSLog("\(id) end")
    }













    
    func waitForIntExample() {
        Task {
            try await withThrowingTaskGroup(of: (Int).self) { group in
                for _ in 1...5 {
                    group.addTask {
                        try await asyncReturningFunction()
                    }
                }

                NSLog("This will be printed before all tasks are done")

                for try await (int) in group {
                   print(int)
                }
                NSLog("This will be printed when all tasks are done")
            }
        }
    }

    func asyncReturningFunction() async throws -> Int {
        let id = Int.random(in: 1...1000)
        NSLog("\(id) start")

        try await Task.sleep(nanoseconds: 2_000_000_000)
        NSLog("\(id) end")
        return id
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

