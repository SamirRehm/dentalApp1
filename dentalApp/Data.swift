//
//  Data.swift
//  dentalApp
//
//  Created by Sean Choi on 2017-12-09.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit

class Data {

    static func getDay(completion: @escaping (DayWeatherModel?) -> ()) {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let data = DayWeatherModel(dayName: "\(weekday)", longDate: "\(month) \(day), \(year)", city: "Whitehorse")
            
            DispatchQueue.main.async {
                completion(data)
            }
           
        }
        
        
    }
    

}




