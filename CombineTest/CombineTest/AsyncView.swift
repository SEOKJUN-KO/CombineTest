//
//  AsyncView.swift
//  CombineTest
//
//  Created by Ko Seokjun on 2023/08/23.
//

import SwiftUI

struct AsyncView: View {
    @ObservedObject var viewModel: CombineViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white
            VStack {
                HStack{
                    Text(viewModel.time)
                    Spacer()
                    Button(action: {
                        viewModel.clicked.send(true)
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
                Divider()
                    .padding(.bottom, 50)
                viewModel.imageTwo
                    .resizable()
                    .frame(width: 200, height: 200)
                
            }
            .padding()
        }
    }
}

struct AsyncView_Previews: PreviewProvider {
    static var previews: some View {
        let combineViewModel = CombineViewModel()
        AsyncView(viewModel: combineViewModel)
    }
}
