//
//  LoadMoreButton.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

/// 加载更多按钮组件
struct LoadMoreButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("加载更多")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        }
    }
}

// #Preview {
//     LoadMoreButton {
//         print("加载更多")
//     }
// }
