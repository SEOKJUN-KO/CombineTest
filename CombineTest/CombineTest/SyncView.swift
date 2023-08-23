//
//  SyncView.swift
//  CombineTest
//
//  Created by Ko Seokjun on 2023/08/22.
//

import SwiftUI

struct SyncView: View {
    @ObservedObject var viewModel: SyncViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white
            VStack {
                HStack{
                    Text(viewModel.time)
                    Spacer()
                    Button(action: {
                            viewModel.loadImage()       
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 30)
                            Text("Load")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 50)
                viewModel.imageOne
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50)
            }
            .padding()
        }
    }
}

struct SyncView_Previews: PreviewProvider {
    static var previews: some View {
        let syncViewModel = SyncViewModel()
        SyncView(viewModel: syncViewModel)
    }
}
