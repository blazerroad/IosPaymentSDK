//
//  CypherSwift.swift
//  Created by Sofia Swidarowicz on 01/11/15.
//  Copyright © 2015 Sofia Swidarowicz. All rights reserved.
//

import UIKit
import Security

class CypherSwift: NSObject {
    
    func printData(data:Data) {
        let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
        print(string1)
    }
    
    func base64String(input : String) -> String?
    {
        
        let utf8str = input.data(using: String.Encoding.utf8);
       
        return  utf8str?.base64EncodedString()
        
    }
    
    func tripleDesEncrypt(pass: String, base64Key: String) -> String{
        if base64Key == ""
        {
            return ""
        }
        let keyData : NSData! = Data(base64Encoded: base64Key, options: .init(rawValue: UInt(0))) as NSData!;
        
        let message       = pass
        let data: NSData! = (message as NSString).data(using: String.Encoding.utf8.rawValue) as NSData!
        
        let cryptData    = NSMutableData(length: Int(data.length) + kCCBlockSize3DES)!
        
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  keyData.bytes, keyLength,
                                  nil,
                                  data.bytes, data.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            
            // Not all data is a UTF-8 string so Base64 is used
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            
            return base64cryptString;
            
        } else {
            print("Error: \(cryptStatus)")
        }
        return ""
    }
    
    func tripleDesDecrypt(pass: String, base64Key: String) -> String{
        //help from this thread
        //http://stackoverflow.com/questions/25754147/issue-using-cccrypt-commoncrypt-in-swift
        
        let keyData : NSData! = Data(base64Encoded: base64Key, options: .init(rawValue: UInt(0))) as NSData!;
        
        let data       = Data(base64Encoded: pass, options: .init(rawValue: UInt(0))) as NSData?
        
        let cryptData    = NSMutableData(length: Int((data?.length)!) + kCCBlockSize3DES)!
        
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(kCCDecrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  keyData.bytes, keyLength,
                                  nil,
                                  data?.bytes, (data?.length)!,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            
            return String(data: cryptData as Data, encoding: .utf8)!
            
            // Not all data is a UTF-8 string so Base64 is used
            //var base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            
            //print("base64cryptString = \(base64cryptString)")
            //base64cryptString = base64cryptString + "\n"
            //return encodeString(str: base64cryptString)
            
        } else {
            print("Error: \(cryptStatus)")
        }
        return ""
    }
    
    func encodeString(str: String) -> String{
        let customAllowedSet =  NSCharacterSet(charactersIn:"==\n").inverted
        let escapedString = str.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        print("escapedString: \(String(describing: escapedString))")
        return escapedString!
        
    }
}
