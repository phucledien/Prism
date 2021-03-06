//
//  UDP.swift
//  Prism
//
//  Created by Tomoyuki Sahara on 9/30/15.
//  Copyright © 2015 Tomoyuki Sahara. All rights reserved.
//

import Foundation

class UDP : BaseProtocol {
    override var name: String { get { return "UDP" } }

    override class func parse(_ context: ParseContext) -> Protocol {
        let p = UDP(context)
        let reader = context.reader
        if (reader.length < 8) {
            p.broken = true
            return p
        }
        return p
    }
    
    var dstport: Int? {
        get {
            return Int(DataReader(data).get16be(at: 2))
        }
    }
    
    var srcport: Int? {
        get {
            return Int(DataReader(data).get16be(at: 0))
        }
    }

}
