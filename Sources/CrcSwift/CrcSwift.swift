import Foundation

class CrcSwift {
    /**
     * Compute CRC-8 for manual set of parameters
     */
    static func computeCrc8(
        _ data: [UInt8],
        initialCrc: UInt8 = 0x00,
        polynom: UInt8 = 0x07,
        xor: UInt8 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt8 {
        var crc: UInt8 = initialCrc
        
        for byte in data {
            if refIn {
                crc = UInt8(DataHelper.reverseBits(byte)) ^ crc
            } else {
                crc = byte ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x80
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynom
                }
            }
        }
        
        if refOut {
            crc = DataHelper.reverseBits(crc)
        }
        
        return crc ^ xor
    }
    
    /**
     * Compute CRC-8 for manual set of parameters
     */
    static func computeCrc8(
        _ data: Data,
        initialCrc: UInt8 = 0x00,
        polynom: UInt8 = 0x07,
        xor: UInt8 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt8 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc8(
            preparedData,
            initialCrc: initialCrc,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    
    
    /**
     * Compute CRC-16 for manual set of parameters
     */
    static func computeCrc16(
        _ data: [UInt8],
        initialCrc: UInt16 = 0xFFFF,
        polynom: UInt16 = 0x1021,
        xor: UInt16 = 0x0000,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt16 {
        var crc: UInt16 = initialCrc
        
        for byte in data {
            if refIn {
                crc = (UInt16(DataHelper.reverseBits(byte)) << 8) ^ crc
            } else {
                crc = (UInt16(byte) << 8) ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x8000
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynom
                }
            }
        }
        
        if refOut {
            crc = DataHelper.reverseBits(crc)
        }
        
        return crc ^ xor
    }
    
    /**
     * Compute CRC-16 for manual set of parameters
     */
    static func computeCrc16(
        _ data: Data,
        initialCrc: UInt16 = 0x00,
        polynom: UInt16 = 0x07,
        xor: UInt16 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt16 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc16(
            preparedData,
            initialCrc: initialCrc,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    /**
     * Compute CRC-32 for manual set of parameters
     */
    static func computeCrc32(
        _ data: [UInt8],
        initialCrc: UInt32 = 0xFFFFFFFF,
        polynom: UInt32 = 0x04C11DB7,
        xor: UInt32 = 0xFFFFFFFF,
        refIn: Bool = true,
        refOut: Bool = true
    ) -> UInt32 {
        var crc: UInt32 = initialCrc
        
        for byte in data {
            if refIn {
                crc = (UInt32(DataHelper.reverseBits(byte)) << 24) ^ crc
            } else {
                crc = (UInt32(byte) << 24) ^ crc
            }
            
            for _ in 0 ..< 8 {
                let check = crc & 0x80000000
                crc = crc << 1
                
                if check != 0 {
                    crc = crc ^ polynom
                }
            }
        }
        
        if refOut {
            crc = DataHelper.reverseBits(crc)
        }
        
        return crc ^ xor
    }
    
    /**
     * Compute CRC-32 for manual set of parameters
     */
    static func computeCrc32(
        _ data: Data,
        initialCrc: UInt32 = 0x00,
        polynom: UInt32 = 0x07,
        xor: UInt32 = 0x00,
        refIn: Bool = false,
        refOut: Bool = false
    ) -> UInt32 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc32(
            preparedData,
            initialCrc: initialCrc,
            polynom: polynom,
            xor: xor,
            refIn: refIn,
            refOut: refOut
        )
    }
    
    /**
     * Compute CRC-8 for mode preset
     */
    static func computeCrc8(_ data: [UInt8], mode: CRC8_TYPE = .defaultCrc) -> UInt8 {
        let config = ConfigHelper.getCrc8VariablesByMode(mode: mode)
        
        return computeCrc8(
            data,
            initialCrc: config.initialCrc,
            polynom: config.polynom,
            xor: config.xor,
            refIn: config.refIn,
            refOut: config.refOut
        )
    }
    
    /**
     * Compute CRC-8 for mode preset
     */
    static func computeCrc8(_ data: Data, mode: CRC8_TYPE = .defaultCrc) -> UInt8 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc8(preparedData, mode: mode)
    }
    
    /**
     * Compute CRC-16 for mode preset
     */
    static func computeCrc16(_ data: [UInt8], mode: CRC16_TYPE = .ccittFalse) -> UInt16 {
        let config = ConfigHelper.getCrc16VariablesByMode(mode: mode)
        
        return computeCrc16(
            data,
            initialCrc: config.initialCrc,
            polynom: config.polynom,
            xor: config.xor,
            refIn: config.refIn,
            refOut: config.refOut
        )
    }
    
    /**
     * Compute CRC-16 for mode preset
     */
    static func computeCrc16(_ data: Data, mode: CRC16_TYPE = .ccittFalse) -> UInt16 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc16(preparedData, mode: mode)
    }
    
    /**
     * Compute CRC-32 for mode preset
     */
    static func computeCrc32(_ data: [UInt8], mode: CRC32_TYPE = .defaultCrc) -> UInt32 {
        let config = ConfigHelper.getCrc32VariablesByMode(mode: mode)
        
        return computeCrc32(
            data,
            initialCrc: config.initialCrc,
            polynom: config.polynom,
            xor: config.xor,
            refIn: config.refIn,
            refOut: config.refOut
        )
    }
    
    /**
     * Compute CRC-32 for mode preset
     */
    static func computeCrc32(_ data: Data, mode: CRC32_TYPE = .defaultCrc) -> UInt32 {
        let preparedData = DataHelper.convertDataToByteArray(data);
        
        return computeCrc32(preparedData, mode: mode)
    }
}
