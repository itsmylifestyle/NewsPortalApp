//
//  SwiftUIViewMap.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import Alamofire
import Foundation
import Combine
import SwiftUI

class SwiftUIViewMap: ObservableObject{
    let baseUrl: String = "http://jsonplaceholder.typicode.com/"
    var task: Cancellable? = nil
    
    @Published var presenters: [ModelPostPresenter] = []
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        self.task = AF.request(self.baseUrl + "posts", method: .get, parameters: nil)
            .publishDecodable(type: [ModelPost].self)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (responce) in
                switch responce.result {
                case .success(let model):
                    self?.presenters = model.map {ModelPostPresenter (with:$0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}


