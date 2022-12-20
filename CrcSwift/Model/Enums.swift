//
//  Enums.swift
//  CrcSwift
//
//  Created by Ivan Elyoskin on 27.07.2018.
//  Copyright © 2018 Ivan Elyoskin. All rights reserved.
//

import Foundation

enum MODE {
    case crc8
    case crc16
    case crc32
}

enum CRC8_TYPE {
    case defaultCrc
    case cdma2000
    case darc
    case dvbS2
    case ebu
    case iCode
    case itu
    case maxim
    case rohc
    case wcdma
}

enum CRC16_TYPE {
    case ccittFalse
    case arc
    case augCcitt
    case buypass
    case cdma2000
    case dds110
    case dectR
    case dectX
    case dnp
    case en13757
    case genibus
    case maxim
    case mcrf4xx
    case riello
    case t10dif
    case teledisk
    case tms37157
    case usb
    case a
    case kermit
    case modbus
    case x25
    case xmodem
}

enum CRC32_TYPE {
    case defaultCrc
    case bzip2
    case c
    case d
    case mpeg2
    case posix
    case sata
    case q
    case jamcrc
    case xfer
}
