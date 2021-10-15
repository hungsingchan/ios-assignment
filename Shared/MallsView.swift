//
//  MallsView.swift
//  ios assignment
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI

struct MallsView: View {
    //        @FetchRequest(entity: Event.entity(), sortDescriptors: []， NSPredicate(format: "dept_id == %@", dept_id))
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Mall.entity(), sortDescriptors: [])
    var events: FetchedResults<Mall>

    
    //        @FetchRequest var Mall: FetchedResults<Mall>
    
    
    
    var body: some View {
        List(events) { event in
            HStack{
                Text(event.mall ?? "No Title")
            }.contextMenu {
//                Button("Add To itinerary") {
//                    viewContext.performAndWait {
//                        event.saved = true
//                        try? viewContext.save()
//                    }
//                }
            }
            
        }
//        .navigationTitle(dept_id)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MallsView()
        }
    }
}
