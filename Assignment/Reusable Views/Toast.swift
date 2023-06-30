//
//  Toast.swift
//  Assignment
//
//  Created by Sohaib Sajjad on 30/06/2023.
//


import Foundation
import SwiftUI


struct Toast: View {
    
    @Binding var isShowing : Bool
    let message : String
    
    var body: some View {
        
        VStack{
            Spacer()
            VStack(alignment:.leading){
                
                HStack{
                    
                    
                    Spacer()
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20,alignment:.center)
                        .foregroundColor(.red)
                        .onTapGesture(perform: {
                            isShowing = false
                        })
                }
                
                Text(self.message)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom,10)
                    .padding(.top , 5)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(10.0)
            .padding(.bottom , 20)
            .padding(.leading , 20)
            .padding(.trailing , 20)
            .shadow(radius: 10,  y: 10)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if(self.isShowing){
                    isShowing.toggle()
                }
            }
        })
    }
    
}
