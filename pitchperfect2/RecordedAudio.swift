//
//  RecordedAudio.swift
//  pitchperfect2
//
//  Created by jasonazghani on 5/19/15.
//  Copyright (c) 2015 jasonazghani. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String?){
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}