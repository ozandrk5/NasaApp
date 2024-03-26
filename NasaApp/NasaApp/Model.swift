//
//  Model.swift
//  NasaApp
//
//  Created by Ozan  Doruk on 3.03.2024.
//

import Foundation
 
struct Model: Codable {
    var date: String
    var explanation: String
    var title: String
    var url: String // Bu alan URL tipinde olmalıdır
}
