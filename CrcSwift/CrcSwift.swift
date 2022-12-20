//
//  CrcSwift.swift
//  CrcSwift
//
//  Created by Ivan Elyoskin on 16.07.2018.
//  Copyright © 2020 Ivan Elyoskin. All rights reserved.
//

class CrcSwift {

    static private func reverseBits(_ data: UInt8) -> UInt8 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 8 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())

        return UInt8(revBinaryString, radix: 2) ?? 0
    }
    
    static private func reverseBits(_ data: UInt16) -> UInt16 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 16 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())

        return UInt16(revBinaryString, radix: 2) ?? 0
    }
    
    
    static private func reverseBits(_ data: UInt32) -> UInt32 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 32 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())

        return UInt32(revBinaryString, radix: 2) ?? 0
    }
    
    /**
     * Returns crc8 for standard CRC mode
     */
    static func calcCrc8(_ data: [UInt8], mode: CRC8_TYPE = .defaultCrc) -> UInt8 {
        var polynomial: UInt8 = 0x00
        var initial: UInt8 = 0x00
        let xor: UInt8 = mode == .itu ? 0x55 : 0x00
        let refIn: Bool = [.darc, .ebu, .maxim, .rohc, .wcdma].contains(mode)
        let refOut: Bool = [.darc, .ebu, .maxim, .rohc, .wcdma].contains(mode)
        
        if [.defaultCrc, .itu, .rohc].contains(mode) {
            polynomial = 0x07
        } else if [.cdma2000, .wcdma].contains(mode) {
            polynomial = 0x9B
        } else if mode == .darc {
            polynomial = 0x39
        } else if mode == .dvbS2 {
            polynomial = 0xd5
        } else if [.ebu, .iCode].contains(mode) {
            polynomial = 0x1d
        } else if mode == .maxim {
            polynomial = 0x31
        }
        
        if [.defaultCrc, .darc, .dvbS2, .itu, .maxim, .wcdma].contains(mode) {
            initial = 0x00
        } else if [.cdma2000, .ebu, .rohc].contains(mode) {
            initial = 0xFF
        } else if mode == .iCode {
            initial = 0xFD
        }
        
        return calcCrc8(
            data,
            initialCrc: initial,
            polynomial: polynomial,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    /**
     * Returns crc8 with manual setting
     */
    static func calcCrc8(
        _ data: [UInt8],
        initialCrc: UInt8 = 0x00,
        polynomial: UInt8 = 0x07,
        xor: UInt8 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt8 {
        var crc: UInt8 = initialCrc

        for byte in data {
            if refIn {
                crc = UInt8(CrcSwift.reverseBits(byte)) ^ crc
            } else {
                crc = byte ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x80
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynomial
                }
            }
        }

        if refOut {
            crc = CrcSwift.reverseBits(crc)
        }

        return crc ^ xor
    }
    
    /**
     * Crc16 calculation
     */
    static func calcCrc16(_ data: [UInt8], mode: CRC16_TYPE = .ccittFalse) -> UInt16 {
        var polynomial: UInt16 = 0x0000
        var crc: UInt16 = 0x0000
        var xor: UInt16 = 0x0000
        let refIn: Bool = [.arc, .dnp, .maxim, .mcrf4xx, .riello, .tms37157, .usb, .a, .kermit, .modbus, .x25].contains(mode)
        let refOut: Bool = refIn
        
        if [.ccittFalse, .genibus, .augCcitt, .xmodem, .mcrf4xx, .riello, .tms37157, .a, .kermit, .x25].contains(mode) {
            polynomial = 0x1021
        } else if [.buypass, .dds110, .arc, .maxim, .usb, .modbus].contains(mode) {
            polynomial = 0x8005
        } else if mode == .cdma2000 {
            polynomial = 0xc867
        } else if mode == .dectR || mode == .dectX {
            polynomial = 0x0589
        } else if mode == .en13757 || mode == .dnp {
            polynomial = 0x3d65
        }else if mode == .t10dif {
            polynomial = 0x8bb7
        } else if mode == .teledisk {
            polynomial = 0xa097
        }

        if [.ccittFalse, .cdma2000, .genibus, .mcrf4xx, .usb, .modbus, .x25].contains(mode) {
            crc = 0xFFFF
        } else if [.arc, .buypass, .dectR, .dectX, .dnp, .en13757, .maxim, .t10dif, .teledisk, .kermit, .xmodem].contains(mode) {
            crc = 0x0000
        } else if mode == .augCcitt {
            crc = 0x1d0f
        } else if mode == .dds110 {
            crc = 0x800d
        } else if mode == .riello {
            crc = 0xB2AA
        } else if mode == .tms37157 {
            crc = 0x89ec
        } else if mode == .a {
            crc = 0xc6c6
        }
        
        if [.dnp, .en13757, .genibus, .maxim, .usb, .x25].contains(mode) {
            xor = 0xFFFF
        } else if mode == .dectR {
            xor = 0x0001
        }
        
        return calcCrc16(
            data,
            initialCrc: crc,
            polynomial: polynomial,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    static func calcCrc16(
        _ data: [UInt8],
        initialCrc: UInt16 = 0xFFFF,
        polynomial: UInt16 = 0x1021,
        xor: UInt16 = 0x0000,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt16 {
        var crc: UInt16 = initialCrc
        
        for byte in data {
            if refIn {
                crc = (UInt16(CrcSwift.reverseBits(byte)) << 8) ^ crc
            } else {
                crc = (UInt16(byte) << 8) ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x8000
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynomial
                }
            }
        }

        if refOut {
            crc = CrcSwift.reverseBits(crc)
        }
        
        return crc ^ xor
    }
    
    
    /**
     * Crc32 calculation
     */
    static func calcCrc32(_ data: [UInt8], mode: CRC32_TYPE = .defaultCrc) -> UInt32 {
        var polynomial: UInt32 = 0x04C11DB7
        let crc: UInt32 = mode == .sata
            ? 0x52325032
            : [.posix, .q, .xfer].contains(mode)
                ? 0x00000000
                : 0xFFFFFFFF
        let xor: UInt32 = [.defaultCrc, .bzip2, .c, .d, .posix].contains(mode) ? 0xFFFFFFFF : 0x00000000
        let refIn: Bool = [.defaultCrc, .jamcrc, .c, .d].contains(mode)
        let refOut: Bool = [.defaultCrc, .jamcrc, .c, .d].contains(mode)
        
        if [.defaultCrc, .bzip2, .mpeg2, .posix, .sata, .jamcrc].contains(mode) {
            polynomial = 0x04C11DB7
        } else if mode == .c {
            polynomial = 0x1EDC6F41
        } else if mode == .d {
            polynomial = 0xA833982B
        } else if mode == .q {
            polynomial = 0x814141AB
        } else if mode == .xfer {
            polynomial = 0x000000AF
        }
        
        return calcCrc32(
            data,
            initialCrc: crc,
            polynomial: polynomial,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    static func calcCrc32(
        _ data: [UInt8],
        initialCrc: UInt32 = 0xFFFFFFFF,
        polynomial: UInt32 = 0x04C11DB7,
        xor: UInt32 = 0xFFFFFFFF,
        refIn: Bool = true,
        refOut: Bool = true
    ) -> UInt32 {
        var crc: UInt32 = initialCrc

        for byte in data {
            if refIn {
                crc = (UInt32(CrcSwift.reverseBits(byte)) << 24) ^ crc
            } else {
                crc = (UInt32(byte) << 24) ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x80000000
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynomial
                }
            }
        }

        if refOut {
            crc = CrcSwift.reverseBits(crc)
        }

        return crc ^ xor
    }
}
