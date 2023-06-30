//
//  ResponseModel.swift
//  Assignment
//
//  Created by Sohaib Sajjad on 30/06/2023.
//

import Foundation




struct ResponseModel : Codable, Hashable {
    
    
    let facilities : [facilityModel]
    let exclusions : [[exclusionModel]]
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        do{
            facilities = try container.decode([facilityModel]?.self, forKey: .facilities) ?? []
        } catch{
            facilities = []
        }
        
        do{
            exclusions = try container.decode([[exclusionModel]]?.self, forKey: .exclusions) ?? []
        } catch{
            exclusions = []
        }
        
    }
    
}



struct facilityModel : Codable, Hashable {
    
    let facility_id: String
    let name: String
    let options: [facilityOptionModel]
    
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            facility_id = try container.decode(String?.self, forKey: .facility_id) ?? ""
        } catch{
            facility_id = ""
        }
        
        
        do{
            name = try container.decode(String?.self, forKey: .name) ?? ""
        } catch{
            name = ""
        }
        
        do{
            options = try container.decode([facilityOptionModel]?.self, forKey: .options) ?? []
        } catch{
            options = []
        }
        
        
    }
    
}


struct facilityOptionModel : Codable, Hashable {
    
    
    let name: String
    let icon: String
    let id: String
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            id = try container.decode(String?.self, forKey: .id) ?? ""
        } catch{
            id = ""
        }
        
        
        do{
            name = try container.decode(String?.self, forKey: .name) ?? ""
        } catch{
            name = ""
        }
        
        
        
        do{
            icon = try container.decode(String?.self, forKey: .icon) ?? ""
        } catch{
            icon = ""
        }
        
    }
    
}



struct exclusionModel : Codable, Hashable {
    
    let facility_id: String
    let options_id: String
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            facility_id = try container.decode(String?.self, forKey: .facility_id) ?? ""
        } catch{
            facility_id = ""
        }
        
        
        do{
            options_id = try container.decode(String?.self, forKey: .options_id) ?? ""
        } catch{
            options_id = ""
        }
        
        
        
    }
    
}
