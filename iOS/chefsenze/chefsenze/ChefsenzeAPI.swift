//
//  ChefsenzeAPI.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/26/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ChefsenzeAPI {
    
    static func getNearestPlaylists(){
        let headers:HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "bearer IN2ktL7leLbSN1-gt0VDiuQ1WWOaSVlnS5CivkNhc8IL-Wl2MzdD_uqomXyxtCGuLkMXfwY0SsENCOSdDqOhk652NMKVfbY-32bnb6vPuzc6u5hTag1STFYvbEIgkvr72GR2gqhnOrWDxHUeWi6-wJRBGfh986JuJjC8nLCuhBe1Xi8-AgZfnmlX_xg0OuxooKf_L_pP-xnZlEuH9v3b6pK4y4zxNaJCPHpWa3Qz-RwqhJKDZqFdTRfqDYloTSm6QTHP-xRjDPd1zYdK2v9ak_BHO_8A9YPpdDRPvNYHZQeOvtNrYdzsXRaNvkTjZBe1GwE_fNTuUWh9ve_THazb8t3t1yPSm6aZgHjBdun2lGkrP7w8c4e56KCeH0aCBppzmHXXc--5cyXMrNwXdJNV9RaxTtoh_LRJGM_7FG1CBNyBax6_-WzWEJwMUEm2o8LjGfo9vQNtmcOf6n2AlKExLh9KZpCDgQo9hCv9eJPOxH0"
        ]
        
        let url = "http://finisimaapi20161011111903.azurewebsites.net/api/NearestPlaylists?Position=25.649775 -100.295446"
        
        Alamofire.request(url,method:.get, headers:headers)
            .validate()
            .responseJSON { response in
                print(response)
                switch response.result{
                case .success:
                    print("Im working")
                    break
                case .failure:
                    print("Cant load playlists")
                    break
                }
        }
    }
}
