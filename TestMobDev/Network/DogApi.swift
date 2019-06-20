//
//  DogApi.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import Foundation
import Moya

let breed_name = "BREED_NAME"

public enum DogApi {
//    static private let privateKey = "YOUR PRIVATE KEY"
//    static private let publicKey = "YOUR PUBLIC KEY"
    
    case dogBreedList
    case dogBreedDetail
}

extension DogApi: TargetType {
    public var baseURL: URL {
        return URL(string: "https://dog.ceo/api")!
    }
    
    public var path: String {
        switch self {
        case .dogBreedList: return "/breeds/list"
        case .dogBreedDetail: return "/breed/{\(breed_name)}/images"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .dogBreedList: return .get
        case .dogBreedDetail: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
