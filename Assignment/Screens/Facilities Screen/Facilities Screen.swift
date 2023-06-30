//
//  Facilities Screen.swift
//  Assignment
//
//  Created by Sohaib Sajjad on 30/06/2023.
//


import SwiftUI




struct selectedFacilityModel {
    
    let facility_id: String
    let name: String
    let selectedOption: facilityOptionModel
    
}



struct Facilities_Screen: View {
    
    @StateObject var getFacilitiesApi = GetFacilitiesApi()
    
    @State var selectedFacilities: [selectedFacilityModel] = []
    
    @State var showOptionsPicker = false
    
    @State var showToast = false
    @State var toastMessage = ""
    
    var body: some View{
        
        ZStack{
            
            
            VStack{
                
                // top bar
                HStack{
                    
                    
                    
                    
                    Spacer()
                    
                    Text("Facilities")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    
                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,20)
                
                
                if(self.getFacilitiesApi.isLoading){
                    
                    VStack{
                        
                        Spacer()
                        
                        HStack{
                            
                            Spacer()
                            
                            ProgressView()
                                .padding()
                            
                            Spacer()
                            
                        }
                        
                        
                        Spacer()
                        
                        
                    }
                    
                }
                
                else if(getFacilitiesApi.isApiCallDone && getFacilitiesApi.isApiCallSuccessful){
                    
                    if(getFacilitiesApi.dataRetrievedSuccessfully){
                        
                        
                        
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack{
                                
                                
                                ForEach(self.getFacilitiesApi.apiResponse!.facilities, id:\.self){facility in
                                                                            
                                        
                                        
                                    Facilities_Screen_Facility_View(getFacilitiesApi: self.getFacilitiesApi, selectedFacilities: self.$selectedFacilities, facility: facility, showToast: self.$showToast, toastMessage: self.$toastMessage)
                                            .padding(.bottom,10)
                                        
                                        
                                    
                                }
                                
                                
                            }.padding(.top,20)
                                .padding(.leading,20)
                                .padding(.trailing,20)
                        }
                        
                        
                    }
                    
                    else{
                        VStack{
                            
                            
                            Spacer()
                            
                            Text("Unable to get facilities.")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            
                            Button(action: {
                                withAnimation{
                                    
                                    self.getFacilitiesApi.getFacilities()
                                    
                                }
                            }){
                                Text("Try Again")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                                
                            }
                            .padding(.top,30)
                            
                            Spacer()
                            
                        }
                    }

                    
                }
                
                
                else if(getFacilitiesApi.isApiCallDone && !(self.getFacilitiesApi.isApiCallSuccessful)){
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to access internet.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                
                                self.getFacilitiesApi.getFacilities()

                            }
                        }){
                            Text("Try Agin")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                            
                        }
                        .padding(.top,30)
                        
                        Spacer()
                        
                    }
                }
                
                
                else{
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to get facilities.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                
                                self.getFacilitiesApi.getFacilities()
                                
                            }
                        }){
                            Text("Try Again")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                            
                        }
                        .padding(.top,30)
                        
                        Spacer()
                        
                    }
                }

                
                        
            }
            
            
            if(self.showToast){
                
                Toast(isShowing: self.$showToast, message: self.toastMessage)
                
            }
            
        }
        .onAppear{
            
            self.getFacilitiesApi.getFacilities()
            
        }
        
    }
    
    
    
}




