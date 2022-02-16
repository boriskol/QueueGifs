//
//  ViewModel.swift
//  StackGif
//
//  Created by Borna Libertines on 14/02/22.
//

import Foundation
import Combine
import SwiftUI

public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0
  
  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    //let percentage = Double(head)/Double(array.count)
    //if array.count > 50 && percentage > 0.25 {
    if head > 2{
      array.removeFirst(head)
      head = 0
    }
    
    return element
  }
  
  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

// MARK: MainViewModel

class MainViewModel: ObservableObject {
    
    @Published private(set) var gifsStack = [GifCollectionViewCellViewModel]()
    @Published private(set) var giffront: GifCollectionViewCellViewModel?
    private var head = 0
    
    @Published private(set) var gifs = [GifCollectionViewCellViewModel]()
    
    // MARK:  Initializer Dependency injestion
    var appiCall: ApiLoader?
    
    init(appiCall: ApiLoader = ApiLoader()){
        self.appiCall = appiCall
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    public var count: Int {
        return gifsStack.count - head
    }
    public func enqueue(_ element: GifCollectionViewCellViewModel){
        gifsStack.append(element)
    }
    public func dequeue() -> GifCollectionViewCellViewModel?{
        
        let element1 = gifsStack[head]
        
        guard head < gifsStack.count else { return nil }
        
        gifsStack[head] = GifCollectionViewCellViewModel(id: nil, title: nil, rating: nil, Image: nil, url: nil)
        head += 1
        
        //let percentage = Double(head)/Double(gifsStack.count)
        //if gifsStack.count > 50 && percentage > 0.25 {
       
        if head > 2 {
            gifsStack.removeFirst(head)
            head = 0
        }
       
        return element1
    }
    public var front1: GifCollectionViewCellViewModel? {
        if isEmpty {
              return nil
        } else {
            return gifsStack[head]
        }
       
    }
    
    @MainActor func loadGift() async {
        
        Task(priority: .userInitiated, operation: {
            let fp: APIListResponse? = try? await appiCall?.fetchAPI(urlParams: [Constants.rating: Constants.rating, Constants.limit: Constants.limitNum], gifacces: Constants.trending)
            let d = fp?.data.map({ return GifCollectionViewCellViewModel(id: $0.id, title: $0.title, rating: $0.rating, Image: $0.images?.fixed_height?.url, url: $0.url)
            })
            self.gifs = d!
        })
    }
   

    deinit{
        
        debugPrint("MainViewModel deinit")
    }
}
