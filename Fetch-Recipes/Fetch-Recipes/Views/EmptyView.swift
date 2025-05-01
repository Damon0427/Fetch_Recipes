//
//  EmptyView.swift
//  Fetch-Recipes
//
//  Created by Zicheng Tan on 4/30/25.
//

import SwiftUI

struct EmptyView: View {
    @Binding var searchName: String
    var body: some View {
        Text("We couln't find \(searchName)")
    }
}


