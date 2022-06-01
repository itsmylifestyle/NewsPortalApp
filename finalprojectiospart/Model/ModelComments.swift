//
//  ModelComments.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//
import Foundation

struct Comment: Identifiable {
    var id = UUID()
    let userName: String
    let comment: String
    let dateString: String
    let personImageName: String
}
