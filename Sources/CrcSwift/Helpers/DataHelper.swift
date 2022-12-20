//
//  File.swift
//  
//
//  Created by Ivan Eleskin on 20.12.2022.
//

import Foundation

class DataHelper {
    static func convertDataToByteArray(_ data: Data) -> [UInt8] {
        var array = [UInt8]()
        array.append(contentsOf: data)
        
        return array
    }
    
    static func reverseBits(_ data: UInt8) -> UInt8 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 8 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())
        
        return UInt8(revBinaryString, radix: 2) ?? 0
    }
    
    static func reverseBits(_ data: UInt16) -> UInt16 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 16 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())
        
        return UInt16(revBinaryString, radix: 2) ?? 0
    }
    
    static func reverseBits(_ data: UInt32) -> UInt32 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 32 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())
        
        return UInt32(revBinaryString, radix: 2) ?? 0
    }
    
}
