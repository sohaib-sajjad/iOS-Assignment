//
//  Facility Option View.swift
//  Assignment
//
//  Created by Sohaib Sajjad on 30/06/2023.
//

import Foundation
import SwiftUI


struct Facilities_Screen_Facility_View: View {
    
    @ObservedObject var getFacilitiesApi : GetFacilitiesApi

    
    @Binding var selectedFacilities: [selectedFacilityModel]
    
    @State var showOptionsPicker = false
    
    @State var facility: facilityModel
    
    
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    
    var body: some View{
        
        ZStack{
            
            
            
            
            VStack{
                
                HStack{
                    
                    Text(facility.name)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                }
                
                
                
                VStack( alignment : .leading , spacing:0){
                    
                    
                    
                    HStack(alignment:.center){
                        
                        Text((!self.selectedFacilities.contains{$0.facility_id == facility.facility_id} ? "Select" : (self.selectedFacilities.first{$0.facility_id == facility.facility_id})!.selectedOption.name))
                            .font(.system(size: 14))
                            .foregroundColor((self.selectedFacilities.contains{$0.facility_id == facility.facility_id}) ? .black : .black.opacity(0.8))
                        
                        Spacer()
                        
                        
                        Button(action: {
                            withAnimation{
                                self.showOptionsPicker.toggle()
                            }
                        }){
                            Image(systemName: self.showOptionsPicker ? "chevron.up" : "chevron.down")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.gray.opacity(0.7))
                                .padding(.leading,5)
                        }
                        
                        
                        
                        
                    }
                    .padding()
                    
                    
                    if(self.showOptionsPicker){
                        
                        Divider()
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        ForEach(self.facility.options, id:\.self) { option in
                            
                            
                            Button{
                                withAnimation{
                                    
                                        if(self.selectedFacilities.contains{$0.facility_id == self.facility.facility_id}){
                                            
                                            self.selectedFacilities.removeAll{$0.facility_id == self.facility.facility_id}
                                            
                                        }
                                        
                                        self.selectedFacilities.append(selectedFacilityModel(facility_id: self.facility.facility_id, name: self.facility.name, selectedOption:option))
                                        
                                        
                                    
                                    for exclusions in self.getFacilitiesApi.apiResponse!.exclusions{
                                        
                                        if(self.selectedFacilities.contains{$0.facility_id == exclusions[0].facility_id && $0.selectedOption.id == exclusions[0].options_id} && self.selectedFacilities.contains{$0.facility_id == exclusions[1].facility_id && $0.selectedOption.id == exclusions[1].options_id} ){
                                            
                                            self.selectedFacilities.removeAll{$0.facility_id == exclusions[0].facility_id}
                                            
                                            self.selectedFacilities.removeAll{$0.facility_id == exclusions[1].facility_id}

                                            self.toastMessage = "These two options cannot be selected together."
                                            self.showToast = true
                                            
                                            
                                        }
                                           
                                        
                                    }
                                    
                                    
                                    self.showOptionsPicker.toggle()

                                    
                                }
                                
                            } label:{
                                
                                Text(option.name)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .padding()
                                
                                
                                Spacer()
                                
                                
                                Image(option.icon)
                                    .padding()
                                
                            }
                            
                        }
                        
                    }
                }
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
                
                
            }.padding(.top,10)
            
            
        }
        
        
    }
    
}
