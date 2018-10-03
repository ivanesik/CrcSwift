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
        let rightCrcCcittFalse: UInt16 = 0x2D7B
        let crcCcittFalse = crcCalc.calcCrc16(data, mode: .ccittFalse)
        XCTAssertEqual(crcCcittFalse, rightCrcCcittFalse)
        
        let rightCrcArc: UInt16 = 0x73AE
        let crcArc = crcCalc.calcCrc16(data, mode: .arc)
        XCTAssertEqual(crcArc, rightCrcArc)
        
        let rightCrcAugCcitt: UInt16 = 0x00e8
        let crcAugCcitt = crcCalc.calcCrc16(data, mode: .augCcitt)
        XCTAssertEqual(crcAugCcitt, rightCrcAugCcitt)
        
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
        
        let rightCrcEn13757: UInt16 = 0xED47
        let crcEn13757 = crcCalc.calcCrc16(data, mode: .en13757)
        XCTAssertEqual(crcEn13757, rightCrcEn13757)
        
        let rightCrcGenibus: UInt16 = 0xD284
        let crcGenibus = crcCalc.calcCrc16(data, mode: .genibus)
        XCTAssertEqual(crcGenibus, rightCrcGenibus)
        
        let rightCrcMaxim: UInt16 = 0x8C51
        let crcMaxim = crcCalc.calcCrc16(data, mode: .maxim)
        XCTAssertEqual(crcMaxim, rightCrcMaxim)
        
        let rightCrcMcrf4xx: UInt16 = 0xDBE1
        let crcMcrf4xx = crcCalc.calcCrc16(data, mode: .mcrf4xx)
        XCTAssertEqual(crcMcrf4xx, rightCrcMcrf4xx)
        
        let rightCrcRiello: UInt16 = 0x2EEB
        let crcRiello = crcCalc.calcCrc16(data, mode: .riello)
        XCTAssertEqual(crcRiello, rightCrcRiello)
        
        let rightCrcT10dif: UInt16 = 0xFE08
        let crcT10dif = crcCalc.calcCrc16(data, mode: .t10dif)
        XCTAssertEqual(crcT10dif, rightCrcT10dif)
        
        let rightCrcTeledisk: UInt16 = 0x6ECE
        let crcTeledisk = crcCalc.calcCrc16(data, mode: .teledisk)
        XCTAssertEqual(crcTeledisk, rightCrcTeledisk)
        
        let rightCrcTms37157: UInt16 = 0x49A4
        let crcTms37157 = crcCalc.calcCrc16(data, mode: .tms37157)
        XCTAssertEqual(crcTms37157, rightCrcTms37157)
        
        let rightCrcUsb: UInt16 = 0x8E35
        let crcUsb = crcCalc.calcCrc16(data, mode: .usb)
        XCTAssertEqual(crcUsb, rightCrcUsb)
        
        let rightCrcA: UInt16 = 0x6EC2
        let crcA = crcCalc.calcCrc16(data, mode: .a)
        XCTAssertEqual(crcA, rightCrcA)
        
        let rightCrcKermit: UInt16 = 0x44C0
        let crcKermit = crcCalc.calcCrc16(data, mode: .kermit)
        XCTAssertEqual(crcKermit, rightCrcKermit)

        let rightCrcModbus: UInt16 = 0x71CA
        let crcModbus = crcCalc.calcCrc16(data, mode: .modbus)
        XCTAssertEqual(crcModbus, rightCrcModbus)
        
        let rightCrcX25: UInt16 = 0x241E
        let crcX25 = crcCalc.calcCrc16(data, mode: .x25)
        XCTAssertEqual(crcX25, rightCrcX25)
        
        let rightCrcXmodem: UInt16 = 0xA982
        let crcXmodem = crcCalc.calcCrc16(data, mode: .xmodem)
        XCTAssertEqual(crcXmodem, rightCrcXmodem)
    }

    
}
