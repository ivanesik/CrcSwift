//
//  CrcSwift.swift
//  CrcSwift
//
//  Created by Ivan Elyoskin on 16.07.2018.
//  Copyright © 2020 Ivan Elyoskin. All rights reserved.
//

class CrcSwift {
    
    private let CRC_TABLE_SIZE = 256
    
    private var crc8Table: [UInt8] = Array.init(repeating: UInt8(0), count: 256)
    private var crc16Table: [UInt16] = []
    private var crc32Table: [UInt32] = []
    
    static private func reverseBites(_ data: UInt16) -> UInt16 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 16 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())

        return UInt16(revBinaryString, radix: 2) ?? 0
    }
    
    static private func reverseBites(_ data: UInt8) -> UInt8 {
        var binaryString = String(data, radix: 2)
        binaryString = String(repeating: "0", count: 8 - binaryString.count) + binaryString
        
        let revBinaryString = String(binaryString.reversed())

        return UInt8(revBinaryString, radix: 2) ?? 0
    }
    
    static func crc8_table(_ data: [UInt8]) -> UInt8 {
        let table = generateCrc8Table()
        
        var crc8:UInt8 = 0x00
        for i in 0..<data.count {
            crc8 = table[ Int(crc8 ^ data[i]) ]
        }
        return crc8
    }
    
    /**
     Crc8 caluculator
     */
    static func calcCrc8(_ data: [UInt8], mode: CRC8_TYPE = .def) -> UInt8 {
        var polynomial: UInt8 = 0x00
        var initial: UInt8 = 0x00
        var xor: UInt8 = 0x00
        let refIn: Bool = (mode == .darc || mode == .ebu || mode == .maxim || mode == .rohc || mode == .wcdma)
        let refOut: Bool = (mode == .darc || mode == .ebu || mode == .maxim || mode == .rohc || mode == .wcdma)
        
        if mode == .def || mode == .itu || mode == .rohc {
            polynomial = 0x07 // 0xe0
        } else if mode == .cdma2000 || mode == .wcdma {
            polynomial = 0x9B // 0xd9
        } else if mode == .darc {
            polynomial = 0x39 // 0x9c
        } else if mode == .dvbS2 {
            polynomial = 0xd5
        } else if mode == .ebu || mode == .iCode {
            polynomial = 0x1d // 0xb8
        } else if mode == .maxim {
            polynomial = 0x31 // 0x8c
        }
        
        if mode == .def || mode == .darc || mode == .dvbS2 || mode == .itu || mode == .maxim || mode == .wcdma {
            initial = 0x00
        } else if mode == .cdma2000 || mode == .ebu || mode == .rohc {
            initial = 0xFF
        } else if mode == .iCode {
            initial = 0xFD
        }
        
        if mode == .itu {
            xor = 0x55
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
    
    static func calcCrc8(
        _ data: [UInt8],
        initialCrc: UInt8 = 0x00,
        polynomial: UInt8 = 0x07,
        xor: UInt8 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt8 {
        var crc: UInt8 = initialCrc;
        let polynom = refOut ? reverseBites(polynomial) : polynomial;
        
        for var byte in data {
            for _ in 0 ..< 8 {
                let mix = (crc ^ byte) & 0x01
                crc >>= 1
                
                if mix != 0 {
                     crc ^= polynom // 0x8C
                }
                
                byte >>= 1
            }
        }

        return crc ^ xor;
    }
    
    /**
     Crc16 calculation
     */
    static func calcCrc16(_ data: [UInt8], mode: CRC16_TYPE = .ccittFalse) -> UInt16 {
        var polynomial: UInt16 = 0x0000
        var crc: UInt16 = 0x0000
        var xor: UInt16 = 0x0000
        let refIn: Bool = (mode == .arc || mode == .dnp || mode == .maxim || mode == .mcrf4xx || mode == .riello || mode == .tms37157 || mode == .usb || mode == .a || mode == .kermit || mode == .modbus || mode == .x25)
        let refOut: Bool = refIn
        
        if mode == .ccittFalse || mode == .genibus || mode == .augCcitt || mode == .xmodem || mode == .mcrf4xx || mode == .riello || mode == .tms37157 || mode == .a || mode == .kermit || mode == .x25 {
            polynomial = 0x1021
        } else if mode == .buypass || mode == .dds110 || mode == .arc || mode == .maxim || mode == .usb || mode == .modbus {
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

        if mode == .ccittFalse || mode == .cdma2000 || mode == .genibus || mode == .mcrf4xx || mode == .usb || mode == .modbus || mode == .x25 {
            crc = 0xFFFF
        } else if mode == .arc || mode == .buypass || mode == .dectR || mode == .dectX || mode == .dnp || mode == .en13757 || mode == .maxim || mode == .t10dif || mode == .teledisk || mode == .kermit || mode == .xmodem {
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
        
        if mode == .dnp || mode == .en13757 || mode == .genibus || mode == .maxim || mode == .usb || mode == .x25 {
            xor = 0xFFFF
        } else if mode == .dectR {
            xor = 0x0001
        }
        
        return calcCrc16(
            data,
            startCrc: crc,
            polynomial: polynomial,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    public static func calcCrc16(
        _ data: [UInt8] = [],
        startCrc: UInt16 = 0xFFFF,
        polynomial: UInt16 = 0x1021,
        xor: UInt16 = 0x1021,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt16 {
        var crc = startCrc;
        let polynom = refOut ? reverseBites(polynomial) : polynomial;
        
        for byte in data {
            var tempByte = UInt16(byte)
            if !refIn {
                crc ^= tempByte << 8;
            }
            for _ in 0 ..< 8 {
                if refIn {
                    let temp1 = crc & 0x0001
                    crc = crc >> 1
                    let temp2 = tempByte & 0x0001
                    tempByte = tempByte >> 1
                    if (temp1 ^ temp2) == 1 {
                        crc = crc ^ polynom
                    }
                } else {
                    crc = (crc & UInt16(0x8000)) != 0 ? (crc << 1) ^ polynom : crc << 1
                }
            }
        }
        return crc ^ xor
    }
    
    
    /**
     Crc32 calculation
     */
    func calcCrc32(_ data: [UInt8], mode: CRC32_TYPE = .def) -> UInt32 {
        var polynomial: UInt32 = 0x04C11DB7
        var crc: UInt32 = (mode == .posix || mode == .q || mode == .xfer) ? 0x00000000 : 0xFFFFFFFF
        let xor: UInt32 = (mode == .def || mode == .bzip2 || mode == .c || mode == .d || mode == .posix) ? 0xFFFFFFFF : 0x00000000
        
        if mode == .def || mode == .bzip2 || mode == .mpeg2 || mode == .posix || mode == .jamcrc {
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

        crc = ~crc
        for byte in data {
            crc ^= UInt32(byte)
            for _ in 0 ..< 8 {
                if crc & 1 != 0 {
                    crc = crc >> 1 ^ polynomial
                } else {
                    crc = crc >> 1
                }
            }
        }
        let result = crc ^ xor
        return result
    }
    
    
    
    
    static func generateCrc8Table(poly: Int = 0x07, mask: Int = 0xff) -> [UInt8] {
        var table: [UInt8] = Array.init(repeating: UInt8(0), count: 256)
        
        for i in 0..<table.count {
            var c = i
            for _ in 0..<8 {
                if c & 0x80 != 0 {
                    c = (((c << 1) & mask) ^ poly)
                } else {
                    c <<= 1
                }
            }
            table[i] = UInt8(c)
        }
        
        return table
    }
    
}
