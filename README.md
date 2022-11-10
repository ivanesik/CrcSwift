# CrcSwift
In development statement


[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
____

## Summary
Easy generate Crc checksum in Swift. Validated by http://crccalc.com

## Features 

CRC8
-  def
- cdma2000
- darc
- dvbS2
- ebu
- iCode
- itu
- maxim
- rohc
- wcdma

CRC16 calculation
-  CCITT-False
- ARC
- AUG-CCITT
- BUYPASS
- CDMA2000
- DDS-110
- DECT-R
- DECT-X
- DNP
- EN-13757
- GENIBUS
- MAXIM
- MCRF4XX
- T10-DIF
- TELEDISK
- USB
- KERMIT
- MODBUS
- X-25
- XMODEM
- RIELLO
- TMS37157
- A

## Installation
Download repository and add CrcSwift folder in your project 

## Usage

Crc generation
```swift
var data: [UInt8] = [0xA4, 0x01, 0x00, 0x0A, 0xFF, 0x06, 0x11, 0x01, 0x01, 0x13, 0x00, 0xD3] // A401000AFF061101011300D3
let crcModbus = CrcSwift.calcCrc16(data, mode: .modbus)
print(crcModbus) //0x71CA

let crcUsb = CrcSwift.calcCrc16(data, mode: .usb)
print(crcUsb) //0x8E35
```

## TODO
- CRC32

## License

[MIT licensed.](LICENSE)
