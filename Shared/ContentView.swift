//
//  ContentView.swift
//  Shared
//
//  Created by Borna Libertines on 15/02/22.
//
/*
 ///A queue is a list where you can only insert new items at the back and remove items from the front.
    This ensures that the first item you enqueue is also the first item you dequeue. First come, first serve!

 ///Why would you need this? Well, in many algorithms you want to add objects to a temporary list and pull them off this list later. Often the order in which you add and remove these objects matters.

 //A queue gives you a FIFO or first-in, first-out order. The element you inserted first is the first one to come out. It is only fair! (A similar data structure, the stack, is LIFO or last-in first-out.)
 */
import SwiftUI

struct ContentView: View {
   
    
    @ObservedObject private var gifs = MainViewModel()
    
    var body: some View {
        NavigationView{
                GeometryReader { geometry in
                   
                    VStack(alignment: .leading, spacing: 0, content: {
                        // MARK: Stack
                        
                        //if let front = self.gifs.front1{
                            Section(header: VStack(alignment: .leading, spacing: 8){
                                HStack(){
                                    
                                    Spacer()
                                    Button(action: {
                                        self.gifs.dequeue()
                                        }) {
                                            HStack {
                                                Image(systemName: "minus")
                                                Text("dequeue")
                                            }.padding(10.0)
                                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 2.0))
                                        }
                                }
                               
                            }, content: {
                                VStack{
                                    if self.gifs.giffront != nil{
                                        GifCell(gif: self.gifs.giffront!, geometry: geometry)
                                    }
                                }.listStyle(.plain)
                            })
                        //}
                        if !self.gifs.isEmpty{
                        Section(header: VStack(alignment: .leading, spacing: 8){
                            Text("Gifs Stack").font(.body).foregroundColor(.purple).fontWeight(.bold).padding(.leading)
                        }, content: {
                            Text("count: \(self.gifs.count)")
                            
                            List{
                                ForEach(self.gifs.gifsStack, id: \.id) { gif in
                                    GifCell(gif: gif, geometry: geometry)
                                }
                            }.listStyle(.plain)
                        })
                        }
                        // MARK: Gifs
                        Section(header: VStack(alignment: .leading, spacing: 8){
                            Text("Gifs Traiding").font(.body).foregroundColor(.purple).fontWeight(.bold).padding(.leading).onAppear{
                            }
                        }, content: {
                            List{
                                ForEach(self.gifs.gifs, id: \.id) { gif in
                                    GifCell(gif: gif, geometry: geometry)
                                        .onTapGesture {
                                            self.gifs.enqueue(gif)
                                        }
                                }
                            }.listStyle(.plain)
                        })
                    })
                    .task{
                        await gifs.loadGift()
                        }
                    .refreshable {
                        await gifs.loadGift()
                    }
                }//gio
            
            
            .hideNavigationBar()
        }//nav
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
