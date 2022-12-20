//
//  Config.swift
//  CrcSwift
//
//  Created by Ivan Eleskin on 20.12.2022.
//  Copyright © 2022 Ivan Elioskin. All rights reserved.
//

import Foundation

struct Config<T> {
    var initialCrc: T
    var polynom: T
    var xor: T
    var refIn: Bool
    var refOut: Bool
}


class ConfigHelper {
    static func getCrc8VariablesByMode(mode: CRC8_TYPE) -> Config<UInt8> {
        var polynom: UInt8 = 0x00
        var initial: UInt8 = 0x00
        let xor: UInt8 = mode == .itu ? 0x55 : 0x00
        let refIn: Bool = [.darc, .ebu, .maxim, .rohc, .wcdma].contains(mode)
        let refOut: Bool = [.darc, .ebu, .maxim, .rohc, .wcdma].contains(mode)
        
        if [.defaultCrc, .itu, .rohc].contains(mode) {
            polynom = 0x07
        } else if [.cdma2000, .wcdma].contains(mode) {
            polynom = 0x9B
        } else if mode == .darc {
            polynom = 0x39
        } else if mode == .dvbS2 {
            polynom = 0xd5
        } else if [.ebu, .iCode].contains(mode) {
            polynom = 0x1d
        } else if mode == .maxim {
            polynom = 0x31
        }
        
        if [.defaultCrc, .darc, .dvbS2, .itu, .maxim, .wcdma].contains(mode) {
            initial = 0x00
        } else if [.cdma2000, .ebu, .rohc].contains(mode) {
            initial = 0xFF
        } else if mode == .iCode {
            initial = 0xFD
        }
        
        return Config(
            initialCrc: initial,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    static func getCrc16VariablesByMode(mode: CRC16_TYPE) -> Config<UInt16> {
        var polynom: UInt16 = 0x0000
        var initial: UInt16 = 0x0000
        var xor: UInt16 = 0x0000
        let refIn: Bool = [
            .arc,
            .dnp,
            .maxim,
            .mcrf4xx,
            .riello,
            .tms37157,
            .usb,
            .a,
            .kermit,
            .modbus,
            .x25
        ].contains(mode)
        let refOut: Bool = refIn
        
        if [.ccittFalse, .genibus, .augCcitt, .xmodem, .mcrf4xx, .riello, .tms37157, .a, .kermit, .x25].contains(mode) {
            polynom = 0x1021
        } else if [.buypass, .dds110, .arc, .maxim, .usb, .modbus].contains(mode) {
            polynom = 0x8005
        } else if mode == .cdma2000 {
            polynom = 0xc867
        } else if mode == .dectR || mode == .dectX {
            polynom = 0x0589
        } else if mode == .en13757 || mode == .dnp {
            polynom = 0x3d65
        }else if mode == .t10dif {
            polynom = 0x8bb7
        } else if mode == .teledisk {
            polynom = 0xa097
        }

        if [.ccittFalse, .cdma2000, .genibus, .mcrf4xx, .usb, .modbus, .x25].contains(mode) {
            initial = 0xFFFF
        } else if [.arc, .buypass, .dectR, .dectX, .dnp, .en13757, .maxim, .t10dif, .teledisk, .kermit, .xmodem].contains(mode) {
            initial = 0x0000
        } else if mode == .augCcitt {
            initial = 0x1d0f
        } else if mode == .dds110 {
            initial = 0x800d
        } else if mode == .riello {
            initial = 0xB2AA
        } else if mode == .tms37157 {
            initial = 0x89ec
        } else if mode == .a {
            initial = 0xc6c6
        }
        
        if [.dnp, .en13757, .genibus, .maxim, .usb, .x25].contains(mode) {
            xor = 0xFFFF
        } else if mode == .dectR {
            xor = 0x0001
        }
        
        return Config(
            initialCrc: initial,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    static func getCrc32VariablesByMode(mode: CRC32_TYPE) -> Config<UInt32> {
        var polynom: UInt32 = 0x04C11DB7
        let initial: UInt32 = mode == .sata
            ? 0x52325032
            : [.posix, .q, .xfer].contains(mode)
                ? 0x00000000
                : 0xFFFFFFFF
        let xor: UInt32 = [.defaultCrc, .bzip2, .c, .d, .posix].contains(mode) ? 0xFFFFFFFF : 0x00000000
        let refIn: Bool = [.defaultCrc, .jamcrc, .c, .d].contains(mode)
        let refOut: Bool = [.defaultCrc, .jamcrc, .c, .d].contains(mode)
        
        if [.defaultCrc, .bzip2, .mpeg2, .posix, .sata, .jamcrc].contains(mode) {
            polynom = 0x04C11DB7
        } else if mode == .c {
            polynom = 0x1EDC6F41
        } else if mode == .d {
            polynom = 0xA833982B
        } else if mode == .q {
            polynom = 0x814141AB
        } else if mode == .xfer {
            polynom = 0x000000AF
        }
        
        return Config(
            initialCrc: initial,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
}
