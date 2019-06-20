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
