//
//  Loopback.swift
//  Prism
//
//  Created by Tomoyuki Sahara on 9/13/15.
//  Copyright (c) 2015 Tomoyuki Sahara. All rights reserved.
//

import Foundation

// Link Layer Protocol of DLT_NULL

class LoopbackProtocol : BaseProtocol {
    override var name: String { get { return "Loopback" } }

    var af = 0
    
    override class func parse(_ context: ParseContext) -> Protocol {
        let p = LoopbackProtocol(context)

        let reader = context.reader
        if (context.endian == .littleEndian) {
            p.af = Int(reader.u32le())
        } else {
            p.af = Int(reader.read_u32be())
        }

        switch (Int32(p.af)) {
        case AF_INET:
            context.parser = IPv4.parse
        case AF_INET6:
            context.parser = IPv6.parse
        default:
            break
        }
        return p
    }
}
