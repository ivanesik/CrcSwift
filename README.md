# CrcSwift

[![Swift](https://img.shields.io/badge/Swift->5.0-orange.svg)](https://swift.org)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
[![Xcode](https://img.shields.io/badge/Xcode-14.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
____

## Summary

Helper to easily generate CRC checksum in Swift.
Validated by http://crccalc.com

## Installation

### Swift Package Manager

Once you have your Swift package set up, adding CrcSwift as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/ivanesik/CrcSwift.git", from: "0.0.2")
]
```

## Usage

```swift
// A401000AFF061101011300D3
var dataArray: [UInt8] = [0xA4, 0x01, 0x00, 0x0A, 0xFF, 0x06, 0x11, 0x01, 0x01, 0x13, 0x00, 0xD3]
var data = Data(dataArray)

// With Mode variables presets and `[UInt8]` input
CrcSwift.computeCrc8(data, mode: .cdma2000) // 0xbe
CrcSwift.computeCrc16(data, mode: .modbus) // 0x71CA
CrcSwift.computeCrc32(data, mode: .mpeg2) // 0x72E70589

// With Mode variables presets and `Data` input
CrcSwift.computeCrc8(dataArray, mode: .cdma2000) // 0xbe
CrcSwift.computeCrc16(dataArray, mode: .modbus) // 0x71CA
CrcSwift.computeCrc32(dataArray, mode: .mpeg2) // 0x72E70589

// Or you can manually set your CRC variables
let manualCrc16 = computeCrc16(
    data,
    initialCrc: 0x0000,
    polynomial: 0x8005,
    xor: 0x0000,
    refIn: true,
    refOut: true
)
```

## Features

CRC-8, CRC-16, CRC-32 calculation with manual setting and most popular variables presets.

CRC-8:
- default
- cdma2000
- darc
- dvbS2
- ebu
- iCode
- itu
- maxim
- rohc
- wcdma

CRC-16:
- ccitt-false
- arc
- aug-ccitt
- buypass
- cdma2000
- dds-110
- dect-r
- dect-x
- dnp
- en-13757
- genibus
- maxim
- mcrf4xx
- t10-dif
- teledisk
- usb
- kermit
- modbus
- x-25
- xmodem
- riello
- tms37157
- a

CRC-32:
- default
- bzip2
- c
- d
- mpeg2
- posix
- sata
- q
- jamcrc
- xfer

## TODO
- Table based calculation
- Tests in CI
- CocoaPods

## License

[MIT licensed.](LICENSE)
