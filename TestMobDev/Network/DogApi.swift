//
//  DogApi.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import Foundation
import Moya

public enum DogApi {
    case dogBreedList
    case dogBreedDetail(String)
}

extension DogApi: TargetType {
    public var baseURL: URL {
        return URL(string: "https://dog.ceo/api")!
    }
    
    public var path: String {
        switch self {
        case .dogBreedList: return "/breeds/list"
        case .dogBreedDetail(let breedName): return "/breed/\(breedName)/images"
        }
    }
    
    public var method: Moya.Method {
        return .get
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

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
