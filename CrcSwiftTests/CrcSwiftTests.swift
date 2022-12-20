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
    
    // A401000AFF061101011300D3
    static let data: [UInt8] = [0xA4, 0x01, 0x00, 0x0A, 0xFF, 0x06, 0x11, 0x01, 0x01, 0x13, 0x00, 0xD3]

    let caseCrc8: [Check<CRC8_TYPE, UInt8>] = [
        Check(mode: .defaultCrc, data: data, result: 0x78),
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
    
    let caseCrc16: [Check<CRC16_TYPE, UInt16>] = [
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
    
    let caseCrc32: [Check<CRC32_TYPE, UInt32>] = [
        Check(mode: .defaultCrc, data: data, result: 0x5DF22E26),
        Check(mode: .bzip2, data: data, result: 0x8D18FA76),
        Check(mode: .c, data: data, result: 0x2DBDD765),
        Check(mode: .d, data: data, result: 0x73C1A102),
        Check(mode: .mpeg2, data: data, result: 0x72E70589),
        Check(mode: .posix, data: data, result: 0x8484AE57),
        Check(mode: .sata, data: data, result: 0xBD56103C),
        Check(mode: .q, data: data, result: 0xE65B47E4),
        Check(mode: .jamcrc, data: data, result: 0xA20DD1D9),
        Check(mode: .xfer, data: data, result: 0x3297F930)
    ]
    
    func testCrc8() {
        for check in caseCrc8 {
            let crc = CrcSwift.computeCrc8(check.data, mode: check.mode)
            XCTAssertEqual(crc, check.result)
        }
    }
    
    func testCrc16() {
        for check in caseCrc16 {
            let crc = CrcSwift.computeCrc16(check.data, mode: check.mode)
            XCTAssertEqual(crc, check.result)
        }
    }
    
    func testCrc32() {
        for check in caseCrc32 {
            let crc = CrcSwift.computeCrc32(check.data, mode: check.mode)
            XCTAssertEqual(crc, check.result)
        }
    }
}
