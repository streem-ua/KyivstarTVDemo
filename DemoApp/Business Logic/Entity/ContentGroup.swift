//
//  Group.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

enum GroupType: String, Hashable {
    case epg = "EPG"
    case no_diaplay = "NO_NEED_TO_DISPLAY"
    case series = "SERIES"
    case live = "LIVECHANNEL"
}

struct ContentGroup: Hashable {
    let id : String
    let name : String
    let type : [GroupType]
    let assets : [Asset]
    let hidden : Bool
    let canBeDeleted : Bool    
}
