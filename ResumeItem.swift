//
//  ResumeItem.swift
//  ProjectTAC432
//
//  Created by Samantha Reap on 4/10/26.
//

import SwiftUI
struct ResumeItem: Identifiable {
    let id: UUID = UUID()
    var title: String
    var date: String
    var summary: String
}
