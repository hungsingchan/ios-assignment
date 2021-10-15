//
//  ios_assignmentApp.swift
//  Shared
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI
import CoreData

@main
struct ios_assignmentApp: App {
    @AppStorage("shouldSeedData") var shouldSeedData: Bool = true
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: seedData)
        }
    }
}

extension ios_assignmentApp {
    
    private func seedData() {
        
        if !shouldSeedData { return }
        
        let events: [[String : Any]] = [
            [
                "id": "1",
                "mall": "IFC Mall",
                "latitude": 22.2849,
                "longitude": 114.158917
            ],
            [
                "id": "2",
                "mall": "Pacific Place",
                "latitude": 22.2774985,
                "longitude": 114.1663225
            ],
            [
                "id": "3",
                "mall": "Times Square",
                "latitude": 22.2782079,
                "longitude": 114.1822994
            ],
            [
                "id": "4",
                "mall": "Elements",
                "latitude": 22.3048708,
                "longitude": 114.1615219
            ],
            [
                "id": "5",
                "mall": "Harbour City",
                "latitude": 22.2950689,
                "longitude": 114.1668661
            ],
            [
                "id": "6",
                "mall": "Festival Walk",
                "latitude": 22.3372971,
                "longitude": 114.1745273
            ],
            [
                "id": "7",
                "mall": "MegaBox",
                "latitude": 22.319857,
                "longitude": 114.208168
            ],
            [
                "id": "8",
                "mall": "APM",
                "latitude": 22.3121738,
                "longitude": 114.22513219999996
            ],
            [
                "id": "9",
                "mall": "Tsuen Wan Plaza",
                "latitude": 22.370735,
                "longitude": 114.111309
            ],
            [
                "id": "10",
                "mall": "New Town Plaza",
                "latitude": 22.3814592,
                "longitude": 114.1889307
            ]
        ]
        
        let viewContext = persistenceController.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        
        viewContext.performAndWait {
            let insertRequest = NSBatchInsertRequest(entity: Mall.entity(), objects: events)
            
            let result = try? viewContext.execute(insertRequest) as? NSBatchInsertResult
            
            if let status = result?.result as? Int, status == 1 {
                print("Data Seeded")
                shouldSeedData = false
            }
        }
    }
}
