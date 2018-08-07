//
//  CrcSwiftTests.swift
//  CrcSwiftTests
//
//  Created by Admin on 16.07.2018.
//  Copyright © 2018 Ivan Elioskin. All rights reserved.
//

import XCTest

@testable import CrcSwift

class CrcSwiftTests: XCTestCase {
    
    var crcCalc: CrcSwift!
    let data: [UInt8] = [0xA4, 0x01, 0x00, 0x0A, 0xFF, 0x06, 0x11, 0x01, 0x01, 0x13, 0x00, 0xD3] // A401000AFF061101011300D3
    
    override func setUp() {
        super.setUp()
        crcCalc = CrcSwift()
    }
    
    override func tearDown() {
        crcCalc = nil
        super.tearDown()
    }
    
    
    func testCrc8() {
        let rightCrc: UInt8 = 0x78
        let crc = crcCalc.calcCrc8(data, mode: .def)
        XCTAssertEqual(crc, rightCrc)
    }
    
    func testCrc16() {
        let rightCrc: UInt16 = 0x73AE
        let crc = crcCalc.calcCrc16(data, mode: .def)
        XCTAssertEqual(crc, rightCrc)
        
        /*let rightCrcCcittFalse: UInt16 = 0x2D7B
        let crcCcittFalse = crcCalc.calcCrc16(data, mode: .ccittFalse)
        XCTAssertEqual(crcCcittFalse, rightCrcCcittFalse)*/
        
        let rightCrcArc: UInt16 = 0x73AE
        let crcArc = crcCalc.calcCrc16(data, mode: .arc)
        XCTAssertEqual(crcArc, rightCrcArc)
        
        /*let rightCrcAugCcitt: UInt16 = 0x00e8
        let crcAugCcitt = crcCalc.calcCrc16(data, mode: .augCcitt)
        XCTAssertEqual(crcAugCcitt, rightCrcAugCcitt)*/
        
        let rightCrcBuypass: UInt16 = 0x80F1
        let crcBuypass = crcCalc.calcCrc16(data, mode: .buypass)
        XCTAssertEqual(crcBuypass, rightCrcBuypass)
        
        let rightCrcCdma2000: UInt16 = 0x4BCD
        let crcCdma2000 = crcCalc.calcCrc16(data, mode: .cdma2000)
        XCTAssertEqual(crcCdma2000, rightCrcCdma2000)
        
        let rightCrcDds100: UInt16 = 0x5571
        let crcDds100 = crcCalc.calcCrc16(data, mode: .dds110)
        XCTAssertEqual(crcDds100, rightCrcDds100)
        
        let rightCrcDectR: UInt16 = 0x3373
        let crcDectR = crcCalc.calcCrc16(data, mode: .dectR)
        XCTAssertEqual(crcDectR, rightCrcDectR)
        
        let rightCrcDectX: UInt16 = 0x3372
        let crcDectX = crcCalc.calcCrc16(data, mode: .dectX)
        XCTAssertEqual(crcDectX, rightCrcDectX)
        
        let rightCrcDnp: UInt16 = 0xEEF9
        let crcDnp = crcCalc.calcCrc16(data, mode: .dnp)
        XCTAssertEqual(crcDnp, rightCrcDnp)
        
        
        
        
        let rightCrcModbus: UInt16 = 0x71CA
        let crcModbus = crcCalc.calcCrc16(data, mode: .modbus)
        XCTAssertEqual(crcModbus, rightCrcModbus)
    }

    
}
