//
//  GroupView.swift
//  CombineTest
//
//  Created by Ko Seokjun on 2023/08/22.
//

import SwiftUI

struct GroupView: View {
    var body: some View {
        TabView{
            AsyncView(viewModel: CombineViewModel())
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("비동기")
                }
            SyncView(viewModel: SyncViewModel())
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("동기")
                }
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
