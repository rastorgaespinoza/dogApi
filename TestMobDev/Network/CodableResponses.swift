//
//  DogApi.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import Foundation

struct DogApiResponse<T: Codable>: Codable {
    let status: String
    let message: [T]
}

//struct DogApiResults<T: Codable>: Codable {
//    let Breed: [T]
//}

//struct DogApiResponse<T: Codable>: Codable {
//    let message: DogApiResults<T>
//}
//
//struct DogApiResults<T: Codable>: Codable {
//    let results: [T]
//}

//struct ImgurResponse<T: Codable>: Codable {
//    let data: T
//}
