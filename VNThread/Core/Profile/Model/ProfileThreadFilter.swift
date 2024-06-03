//
//  ProfileThreadModel.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case likes
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .likes: return "Likes"
        }
    }
    
    var id: Int { return self.rawValue }
}
