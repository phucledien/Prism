//
//  Protocol.swift
//  Prism
//
//  Created by Tomoyuki Sahara on 9/15/15.
//  Copyright (c) 2015 Tomoyuki Sahara. All rights reserved.
//

import Foundation

protocol Protocol {
    var broken: Bool { get }
    var fields: [ProtocolField] { get }
    var header_length: Int { get }
    var name: String { get }
    var isNetworkProtocol: Bool { get }

    static func parse(_ context: ParseContext) -> Protocol
}

class BaseProtocol: NSObject, Protocol {
    var broken = false
    var header_length = 0
    var name: String { get { return "(base)" } }
    var isNetworkProtocol: Bool { get { return false } }
    
    var data: Data
    var offset: Int

    var fields: [ProtocolField] = []
    
    init(_ context: ParseContext) {
        self.data = context.reader.data as Data
        self.offset = context.reader.offset
    }

    class func parse(_ context: ParseContext) -> Protocol {
        context.parser = nil
        return UnknownProtocol(context)
    }
}
