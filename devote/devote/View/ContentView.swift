 //
//  ContentView.swift
//  devote
//
//  Created by Thomas Mani on 21/09/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var task : String = ""
    @State private var showNewTaskItem: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    
                    HStack(spacing:10) {
                        Text("Devote")
                            .font(.system(.largeTitle,design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16,weight: .semibold,design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 70,minHeight: 24)
                            .background(
                                Capsule()
                                    .stroke(Color.white,lineWidth: 2)
                            )
                        
                        Button {
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName:  isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24,height: 24)
                                .font(.system(.title,design: .rounded))
                        }

                        
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    Button {
                        showNewTaskItem = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(colors: [.pink,.blue], startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                    
                    if !items.isEmpty {
                        List {
                            ForEach(items) { item in
                                ListRowItemView(item: item)
                            }
                            .onDelete(perform: deleteItems)
                            
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.insetGrouped)
                        .shadow(color: .black.opacity(0.3), radius: 12)
                        .padding(.vertical,0)
                        .frame(maxWidth: 640)
                    }else{
                        Color.clear
                    }
                    
                }
                .blur(radius: showNewTaskItem ? 8 : 0,opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: showNewTaskItem)
                
                if showNewTaskItem{
                    BlankView(backgroundColor: isDarkMode ? .black : .gray, baclgroundopacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8 : 0,opaque: false)
            )
            .background(backgroundGradient.ignoresSafeArea(.all))
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
