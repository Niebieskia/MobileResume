//
//  ResumeStore.swift
//  ProjectTAC432
//
//  Created by Samantha Reap on 4/19/26.
//

import SwiftUI
import Combine

class ResumeStore: ObservableObject {
    @Published var items: [ResumeItem] = []
    init() {}
    
}
