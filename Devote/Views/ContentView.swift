//
//  ContentView.swift
//  Devote
//
//  Created by Paul Onawola on 11/06/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showNewTaskItem: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Button {
                        withAnimation(.easeOut(duration: 0.05)) {
                            showNewTaskItem = true
                            playSound(sound: "sound-ding", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background {
                        LinearGradient(colors: [.pink, .blue], startPoint: .leading, endPoint: .trailing)
                    }
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.25), radius: 8, y:4)
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .modifier(ClearListModifier())
                    .frame(maxWidth: 640)
                }
                .blur(radius: showNewTaskItem ? 2.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: showNewTaskItem)
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5
                    )
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .background {
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 4.0 : 0, opaque: false)
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Devote")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .frame(minWidth: 70, minHeight: 24)
                        .background {
                            Capsule()
                                .stroke(.white, lineWidth: 2)
                        }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isDarkMode.toggle()
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                            .foregroundStyle(.white)
                    }

                }
            }
        }
        .navigationViewStyle(.stack)
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

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
