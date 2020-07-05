//
//  CrcSwiftTests.swift
//  CrcSwiftTests
//
//  Created by Ivan Elyoskin on 16.07.2018.
//  Copyright © 2020 Ivan Elyoskin. All rights reserved.
//

import XCTest

struct Check<T, Y> {
    var mode: T
    var data: [UInt8]
    var result: Y
}

@testable import CrcSwift

class CrcSwiftTests: XCTestCase {
    
    static let data: [UInt8] = [0xA4, 0x01, 0x00, 0x0A, 0xFF, 0x06, 0x11, 0x01, 0x01, 0x13, 0x00, 0xD3] // A401000AFF061101011300D3
    let checks8: [Check<CRC8_TYPE, UInt8>] = [
        Check(mode: .def, data: data, result: 0x78),
        Check(mode: .cdma2000, data: data, result: 0xbe),
        Check(mode: .darc, data: data, result: 0x59),
        Check(mode: .dvbS2, data: data, result: 0xa5),
        Check(mode: .ebu, data: data, result: 0xbc),
        Check(mode: .iCode, data: data, result: 0x1a),
        Check(mode: .itu, data: data, result: 0x2d),
        Check(mode: .maxim, data: data, result: 0x55),
        Check(mode: .rohc, data: data, result: 0xca),
        Check(mode: .wcdma, data: data, result: 0x9a),
    ]
    
    let checks16: [Check<CRC16_TYPE, UInt16>] = [
        // refIn | refOut = true
        Check(mode: .ccittFalse, data: data, result: 0x2D7B),
        Check(mode: .augCcitt, data: data, result: 0x00e8),
        Check(mode: .buypass, data: data, result: 0x80F1),
        Check(mode: .cdma2000, data: data, result: 0x4BCD),
        Check(mode: .dds110, data: data, result: 0x5571),
        Check(mode: .dectR, data: data, result: 0x3373),
        Check(mode: .dectX, data: data, result: 0x3372),
        Check(mode: .en13757, data: data, result: 0xED47),
        Check(mode: .genibus, data: data, result: 0xD284),
        Check(mode: .t10dif, data: data, result: 0xFE08),
        Check(mode: .teledisk, data: data, result: 0x6ECE),
        Check(mode: .xmodem, data: data, result: 0xA982),
        
        // refIn | refOut = false
        Check(mode: .arc, data: data, result: 0x73AE),
        Check(mode: .dnp, data: data, result: 0xEEF9),
        Check(mode: .maxim, data: data, result: 0x8C51),
        Check(mode: .mcrf4xx, data: data, result: 0xDBE1),
        Check(mode: .riello, data: data, result: 0x2EEB),
        Check(mode: .tms37157, data: data, result: 0x49A4),
        Check(mode: .usb, data: data, result: 0x8E35),
        Check(mode: .a, data: data, result: 0x6EC2),
        Check(mode: .kermit, data: data, result: 0x44C0),
        Check(mode: .modbus, data: data, result: 0x71CA),
        Check(mode: .x25, data: data, result: 0x241E),
    ]
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCrc8() {
        for check in checks8 {
            let crc = CrcSwift.calcCrc8(check.data, mode: check.mode)
            XCTAssertEqual(crc, check.result)
        }
    }
    
    func testCrc16() {
        for check in checks16 {
            let crc = CrcSwift.calcCrc16(check.data, mode: check.mode)
            XCTAssertEqual(crc, check.result)
        }
    }
    
//    func testCrc162() {
//        let rightCrcA_2: UInt16 = 0x2EEB
//        let crcA_2 = CrcSwift.calcCrc16(
//            data,// [0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17],
//            initialCrc: 0x89EC,
//            polynomial: 0x1021,
//            xor: 0x0000,
//            refIn: true,
//            refOut: true
//        )
//        print(String(crcA_2, radix: 16))
//        XCTAssertEqual(crcA_2, rightCrcA_2)
//    }
//
//
//    func testCrc32() {
//        let rightCrc: UInt32 = 0x5DF22E26
//        let crc = CrcSwift.calcCrc32(data, mode: .def)
//        XCTAssertEqual(crc, rightCrc)
//
//        let rightCrcBzip2: UInt32 = 0x8D18FA76
//        let crcBzip2 = CrcSwift.calcCrc32(data, mode: .bzip2)
//        XCTAssertEqual(crcBzip2, rightCrcBzip2)
//
//        let rightCrcC: UInt32 = 0x2DBDD765
//        let crcC = CrcSwift.calcCrc32(data, mode: .c)
//        XCTAssertEqual(crcC, rightCrcC)
//
//        let rightCrcD: UInt32 = 0x73C1A102
//        let crcD = CrcSwift.calcCrc32(data, mode: .d)
//        XCTAssertEqual(crcD, rightCrcD)
//
//        let rightCrcMpeg2: UInt32 = 0x72E70589
//        let crcMpeg2 = CrcSwift.calcCrc32(data, mode: .mpeg2)
//        XCTAssertEqual(crcMpeg2, rightCrcMpeg2)
//
//        let rightCrcPosix: UInt32 = 0x8484AE57
//        let crcPosix = CrcSwift.calcCrc32(data, mode: .posix)
//        XCTAssertEqual(crcPosix, rightCrcPosix)
//
//        let rightCrcQ: UInt32 = 0xE65B47E4
//        let crcQ = CrcSwift.calcCrc32(data, mode: .q)
//        XCTAssertEqual(crcQ, rightCrcQ)
//
//        let rightCrcJamcrc: UInt32 = 0x3372
//        let crcJamcrc = CrcSwift.calcCrc32(data, mode: .jamcrc)
//        XCTAssertEqual(crcJamcrc, rightCrcJamcrc)
//
//        let rightCrcXfer: UInt32 = 0xEEF9
//        let crcXfer = CrcSwift.calcCrc32(data, mode: .xfer)
//        XCTAssertEqual(crcXfer, rightCrcXfer)
//
//    }
}
