//
//  NewTaskItemView.swift
//  devote
//
//  Created by Thomas Mani on 25/09/23.
//

import SwiftUI

struct NewTaskItemView: View {
    
    
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isShowing:Bool
    
    @State private var task:String = ""
    
    private var isButtonDisabled:Bool {
        task.isEmpty
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24,weight: .bold,design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ?  Color(uiColor: .tertiarySystemBackground) : Color(uiColor: .secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24,weight: .bold,design: .rounded))
                    Spacer()
                    
                }
                .disabled(isButtonDisabled)
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? .blue :  .pink)
                .cornerRadius(10)
                
            }
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(uiColor: .secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640 )
        }
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
