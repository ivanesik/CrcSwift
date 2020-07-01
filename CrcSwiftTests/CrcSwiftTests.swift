//
//  CrcSwiftTests.swift
//  CrcSwiftTests
//
//  Created by Ivan Elyoskin on 16.07.2018.
//  Copyright © 2020 Ivan Elyoskin. All rights reserved.
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
        let crc = CrcSwift.calcCrc8(data, mode: .def)
        XCTAssertEqual(crc, rightCrc)
        
        let rightCrcCdma2000: UInt8 = 0xbe
        let crcCdma2000 = CrcSwift.calcCrc8(data, mode: .cdma2000)
        XCTAssertEqual(crcCdma2000, rightCrcCdma2000)
        
        let rightCrcDarc: UInt8 = 0x59
        let crcDarc = CrcSwift.calcCrc8(data, mode: .darc)
        XCTAssertEqual(crcDarc, rightCrcDarc)
        
        let rightCrcDvbs2: UInt8 = 0xa5
        let crcDvbs2 = CrcSwift.calcCrc8(data, mode: .dvbS2)
        XCTAssertEqual(crcDvbs2, rightCrcDvbs2)
        
        let rightCrcEbu: UInt8 = 0xbc
        let crcEbu = CrcSwift.calcCrc8(data, mode: .ebu)
        XCTAssertEqual(crcEbu, rightCrcEbu)
        
        let rightICode: UInt8 = 0x1a
        let crcICode = CrcSwift.calcCrc8(data, mode: .iCode)
        XCTAssertEqual(crcICode, rightICode)
        
        let rightCrcItu: UInt8 = 0x2d
        let crcItu = CrcSwift.calcCrc8(data, mode: .itu)
        XCTAssertEqual(crcItu, rightCrcItu)
        
        let rightCrcMaxim: UInt8 = 0x55
        let crcMaxim = CrcSwift.calcCrc8(data, mode: .maxim)
        XCTAssertEqual(crcMaxim, rightCrcMaxim)
        
        let rightCrcRohc: UInt8 = 0xca
        let crcRohc = CrcSwift.calcCrc8(data, mode: .rohc)
        XCTAssertEqual(crcRohc, rightCrcRohc)
        
        let rightCrcWcdma: UInt8 = 0x9a
        let crcWcdma = CrcSwift.calcCrc8(data, mode: .wcdma)
        XCTAssertEqual(crcWcdma, rightCrcWcdma)
    }
    
    func test123() {
        let rightCrcArc: UInt16 = 0x73AE
        let crcArc = CrcSwift.calcCrc16(data, mode: .arc)
        XCTAssertEqual(crcArc, rightCrcArc)
    }
    
    func testCrc16() {
        let rightCrcCcittFalse: UInt16 = 0x2D7B
        let crcCcittFalse = CrcSwift.calcCrc16(data, mode: .ccittFalse)
        XCTAssertEqual(crcCcittFalse, rightCrcCcittFalse)
        
        let rightCrcArc: UInt16 = 0x73AE
        let crcArc = CrcSwift.calcCrc16(data, mode: .arc)
        XCTAssertEqual(crcArc, rightCrcArc)
        
        let rightCrcAugCcitt: UInt16 = 0x00e8
        let crcAugCcitt = CrcSwift.calcCrc16(data, mode: .augCcitt)
        XCTAssertEqual(crcAugCcitt, rightCrcAugCcitt)
        
        let rightCrcBuypass: UInt16 = 0x80F1
        let crcBuypass = CrcSwift.calcCrc16(data, mode: .buypass)
        XCTAssertEqual(crcBuypass, rightCrcBuypass)
        
        let rightCrcCdma2000: UInt16 = 0x4BCD
        let crcCdma2000 = CrcSwift.calcCrc16(data, mode: .cdma2000)
        XCTAssertEqual(crcCdma2000, rightCrcCdma2000)
        
        let rightCrcDds100: UInt16 = 0x5571
        let crcDds100 = CrcSwift.calcCrc16(data, mode: .dds110)
        XCTAssertEqual(crcDds100, rightCrcDds100)
        
        let rightCrcDectR: UInt16 = 0x3373
        let crcDectR = CrcSwift.calcCrc16(data, mode: .dectR)
        XCTAssertEqual(crcDectR, rightCrcDectR)
        
        let rightCrcDectX: UInt16 = 0x3372
        let crcDectX = CrcSwift.calcCrc16(data, mode: .dectX)
        XCTAssertEqual(crcDectX, rightCrcDectX)
        
        let rightCrcDnp: UInt16 = 0xEEF9
        let crcDnp = CrcSwift.calcCrc16(data, mode: .dnp)
        XCTAssertEqual(crcDnp, rightCrcDnp)
        
        let rightCrcEn13757: UInt16 = 0xED47
        let crcEn13757 = CrcSwift.calcCrc16(data, mode: .en13757)
        XCTAssertEqual(crcEn13757, rightCrcEn13757)
        
        let rightCrcGenibus: UInt16 = 0xD284
        let crcGenibus = CrcSwift.calcCrc16(data, mode: .genibus)
        XCTAssertEqual(crcGenibus, rightCrcGenibus)
        
        let rightCrcMaxim: UInt16 = 0x8C51
        let crcMaxim = CrcSwift.calcCrc16(data, mode: .maxim)
        XCTAssertEqual(crcMaxim, rightCrcMaxim)
        
        let rightCrcMcrf4xx: UInt16 = 0xDBE1
        let crcMcrf4xx = CrcSwift.calcCrc16(data, mode: .mcrf4xx)
        XCTAssertEqual(crcMcrf4xx, rightCrcMcrf4xx)
        
        let rightCrcRiello: UInt16 = 0x2EEB
        let crcRiello = CrcSwift.calcCrc16(data, mode: .riello)
        XCTAssertEqual(crcRiello, rightCrcRiello)
        
        let rightCrcT10dif: UInt16 = 0xFE08
        let crcT10dif = CrcSwift.calcCrc16(data, mode: .t10dif)
        XCTAssertEqual(crcT10dif, rightCrcT10dif)
        
        let rightCrcTeledisk: UInt16 = 0x6ECE
        let crcTeledisk = CrcSwift.calcCrc16(data, mode: .teledisk)
        XCTAssertEqual(crcTeledisk, rightCrcTeledisk)
        
        let rightCrcTms37157: UInt16 = 0x49A4
        let crcTms37157 = CrcSwift.calcCrc16(data, mode: .tms37157)
        XCTAssertEqual(crcTms37157, rightCrcTms37157)
        
        let rightCrcUsb: UInt16 = 0x8E35
        let crcUsb = CrcSwift.calcCrc16(data, mode: .usb)
        XCTAssertEqual(crcUsb, rightCrcUsb)
        
        let rightCrcA: UInt16 = 0x6EC2
        let crcA = CrcSwift.calcCrc16(data, mode: .a)
        XCTAssertEqual(crcA, rightCrcA)
        
        let rightCrcKermit: UInt16 = 0x44C0
        let crcKermit = CrcSwift.calcCrc16(data, mode: .kermit)
        XCTAssertEqual(crcKermit, rightCrcKermit)

        let rightCrcModbus: UInt16 = 0x71CA
        let crcModbus = CrcSwift.calcCrc16(data, mode: .modbus)
        XCTAssertEqual(crcModbus, rightCrcModbus)
        
        let rightCrcX25: UInt16 = 0x241E
        let crcX25 = CrcSwift.calcCrc16(data, mode: .x25)
        XCTAssertEqual(crcX25, rightCrcX25)
        
        let rightCrcXmodem: UInt16 = 0xA982
        let crcXmodem = CrcSwift.calcCrc16(data, mode: .xmodem)
        XCTAssertEqual(crcXmodem, rightCrcXmodem)
    }
    
    
    func testCrc32() {
        let rightCrc: UInt32 = 0x5DF22E26
        let crc = crcCalc.calcCrc32(data, mode: .def)
        XCTAssertEqual(crc, rightCrc)
        
        let rightCrcBzip2: UInt32 = 0x8D18FA76
        let crcBzip2 = crcCalc.calcCrc32(data, mode: .bzip2)
        XCTAssertEqual(crcBzip2, rightCrcBzip2)
        
        let rightCrcC: UInt32 = 0x2DBDD765
        let crcC = crcCalc.calcCrc32(data, mode: .c)
        XCTAssertEqual(crcC, rightCrcC)
        
        let rightCrcD: UInt32 = 0x73C1A102
        let crcD = crcCalc.calcCrc32(data, mode: .d)
        XCTAssertEqual(crcD, rightCrcD)
        
        let rightCrcMpeg2: UInt32 = 0x72E70589
        let crcMpeg2 = crcCalc.calcCrc32(data, mode: .mpeg2)
        XCTAssertEqual(crcMpeg2, rightCrcMpeg2)
        
        let rightCrcPosix: UInt32 = 0x8484AE57
        let crcPosix = crcCalc.calcCrc32(data, mode: .posix)
        XCTAssertEqual(crcPosix, rightCrcPosix)
        
        let rightCrcQ: UInt32 = 0xE65B47E4
        let crcQ = crcCalc.calcCrc32(data, mode: .q)
        XCTAssertEqual(crcQ, rightCrcQ)
        
        let rightCrcJamcrc: UInt32 = 0x3372
        let crcJamcrc = crcCalc.calcCrc32(data, mode: .jamcrc)
        XCTAssertEqual(crcJamcrc, rightCrcJamcrc)
        
        let rightCrcXfer: UInt32 = 0xEEF9
        let crcXfer = crcCalc.calcCrc32(data, mode: .xfer)
        XCTAssertEqual(crcXfer, rightCrcXfer)
        
    }
}
