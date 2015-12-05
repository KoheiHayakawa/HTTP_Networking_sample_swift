//
//  Common.swift
//  HTTP_Networking_sample_ios_swift
//
//  Created by Kohei Hayakawa on 4/11/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import ObjectMapper

class Common: Mappable, CustomStringConvertible {
    
    var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
    
    required init(){}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {

    }
    
}
