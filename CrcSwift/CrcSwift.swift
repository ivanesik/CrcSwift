//
//  CrcSwift.swift
//  CrcSwift
//
//  Created by Admin on 16.07.2018.
//  Copyright © 2018 Ivan Elioskin. All rights reserved.
//

class CrcSwift {
    
    private let CRC_TABLE_SIZE = 256
    
    private var crc8Table: [UInt8] = Array(repeating: 0, count: 256)
    private var crc16Table: [UInt16] = []
    private var crc32Table: [UInt32] = []
    
    

    /**
     Crc8 caluculator
     */
    func calcCrc8(_ data: [UInt8], mode: CRC8_TYPE = .def) -> UInt8 {
        
        var polynomial: UInt8 = 0x00
        var crc: UInt8 = 0x00
        let refIn: Bool = (mode == .darc || mode == .ebu || mode == .maxim || mode == .rohc || mode == .wcdma)
        let refOut: Bool = (mode == .darc || mode == .ebu || mode == .maxim || mode == .rohc || mode == .wcdma)
        let xor: UInt8 = mode == .itu ? 0x55 : 0x00
        
        if mode == .def || mode == .itu {
            polynomial = 0x07
        } else if mode == .cdma2000 {
            polynomial = 0x9B
        } else if mode == .darc {
            polynomial = 0x9c // reversed 0x39
        } else if mode == .dvbS2 {
            polynomial = 0xd5
        } else if mode == .ebu {
            polynomial = 0xb8 // reversed 0x1d
        } else if mode == .iCode {
            polynomial = 0x1d
        } else if mode == .maxim {
            polynomial = 0x8c // reversed 0x31
        } else if mode == .rohc {
            polynomial = 0xe0// reversed 0x07
        } else if mode == .wcdma {
            polynomial = 0xd9 // reversed 0x9b
        }
        
        if mode == .def || mode == .darc || mode == .dvbS2 || mode == .itu || mode == .maxim || mode == .wcdma {
            crc = 0x00
        } else if mode == .cdma2000 || mode == .ebu || mode == .rohc {
            crc = 0xFF
        } else if mode == .iCode {
            crc = 0xFD
        }
        
        for byte in data {
            /*let temp: UInt8 = UInt8((UInt16(crc) + UInt16(byte)) & 0xFF)
            crc = temp & polynomial
            var tempByte = UInt8(byte)
            for _ in 0 ..< 8 {
                let temp1 = crc & 0x01
                crc = crc >> 1
                let temp2 = tempByte & 0x01
                tempByte = tempByte >> 1
                if (temp1 ^ temp2) == 1 {
                    crc ^= polynomial
                }
            }*/
            /*var tempByte = UInt8(byte)
            if !refIn {
                crc ^= tempByte << 8;
            }
            for _ in 0 ..< 8 {
                //if refIn {
                    let temp1 = crc & 0x0001
                    crc = crc >> 1
                    let temp2 = tempByte & 0x0001
                    tempByte = tempByte >> 1
                    if (temp1 ^ temp2) == 1 {
                        crc = crc ^ polynomial
                    }
                /*} else {
                    crc = (crc & UInt8(0x80)) != 0 ? (crc << 1) ^ polynomial : crc << 1
                }*/
            }*/
            var buffer: UInt8 = 0x00
            crc = crc << 8
            for _ in 0 ..< 8 {
                buffer = buffer << 1
                buffer += crc & 0x01
                
            }
        }
        return crc ^ xor
    }
    
    /**
     Crc16 calculation
     */
    func calcCrc16(_ data: [UInt8], mode: CRC16_TYPE = .ccittFalse) -> UInt16 {
        
        var polynomial: UInt16 = 0xA001 // A001 is the bit reverse of 8005
        var crc: UInt16 = 0x0000
        var xor: UInt16 = 0x0000
        let refIn: Bool = (mode == .arc || mode == .dnp || mode == .maxim || mode == .mcrf4xx || mode == .riello || mode == .tms37157 || mode == .usb || mode == .a || mode == .kermit || mode == .modbus || mode == .x25)
        
        if mode == .ccittFalse || mode == .genibus || mode == .augCcitt || mode == .xmodem {
            polynomial = 0x1021
        } else if mode == .arc || mode == .maxim || mode == .usb || mode == .modbus {
            polynomial = 0xA001 // is the bit reverse of 8005
        } else if mode == .buypass || mode == .dds110 {
            polynomial = 0x8005
        } else if mode == .cdma2000 {
            polynomial = 0xc867
        } else if mode == .dectR || mode == .dectX {
            polynomial = 0x0589
        } else if mode == .dnp {
            polynomial = 0xa6bc // is the bit reverse of 0x3d65
        } else if mode == .en13757 {
            polynomial = 0x3d65
        } else if mode == .mcrf4xx || mode == .riello || mode == .tms37157 || mode == .a || mode == .kermit || mode == .x25 {
            polynomial = 0x8408 // is the bit reverse of 0x1021
        } else if mode == .t10dif {
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
                        crc = crc ^ polynomial
                    }
                } else {
                    crc = (crc & UInt16(0x8000)) != 0 ? (crc << 1) ^ polynomial : crc << 1
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
        var crc: UInt32 = (mode == .def || mode == .bzip2 || mode == .c || mode == .d || mode == .mpeg2 || mode == .jamcrc) ? 0xFFFFFFFF : 0x00
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
    
    
    
    
    func generateCrc8Table(poly: UInt8) -> [UInt8] {
        var i = 1
        var t: UInt8 = 0x80
        while i < CRC_TABLE_SIZE {
            t = (t << 1) ^ (t & 0x80 > 0 ? poly : 0)
            for j in 0...i {
                crc8Table[i+j] = crc8Table[j] ^ t
            }
            i *= 2
        }
        return crc8Table
    }
    
}
