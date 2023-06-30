//
//  Api Call.swift
//  Assignment
//
//  Created by Sohaib Sajjad on 30/06/2023.
//

import Foundation




class GetFacilitiesApi : ObservableObject{
    //MARK: - Published Variables
    @Published var isLoading = false
    @Published var isApiCallDone = false
    @Published var isApiCallSuccessful = false
    @Published var dataRetrievedSuccessfully = false
    @Published var apiResponse :  ResponseModel?
    
    
    
    
    //MARK: - Get Customer Orders History
    func getFacilities(){
        
        self.isLoading = true
        self.isApiCallSuccessful = true
        self.dataRetrievedSuccessfully = false
        self.isApiCallDone = false
        
        //Create url
        guard let url = URL(string: NetworkConfig.baseUrl + NetworkConfig.endPoint ) else {return}
        
                
        
        //Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        
        //:end
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                    self.isApiCallSuccessful=false
                    self.isLoading = false
                }
                return
            }
            //If sucess
            
            
            do{
                print("Got response succesfully.....")
                DispatchQueue.main.async {
                    self.isApiCallDone = true
                }
                let main = try JSONDecoder().decode(ResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.apiResponse = main
                    self.isApiCallSuccessful  = true
                    
                    if(!main.facilities.isEmpty){
                        
                        self.dataRetrievedSuccessfully = true
                        
                    }
                    
                    else{
                        self.dataRetrievedSuccessfully = false
                    }
                    self.isLoading = false
                }
            }catch{  // if error
                print(error)
                DispatchQueue.main.async {
                    print(error)
                    self.isApiCallDone = true
                    self.apiResponse = nil
                    self.isApiCallSuccessful  = true
                    self.dataRetrievedSuccessfully = false
                    self.isLoading = false
                }
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
        }
        
        task.resume()
    }
    
    
    
}
