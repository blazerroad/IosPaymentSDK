//
//  Services.swift
//  KordPay
//
//  Created by Amir on 11/21/1396 AP.
//  Copyright © 1396 Yello. All rights reserved.
//

import Foundation

import UIKit
import Security


enum ServerAPI {
    case KeyChange
    case CardNos
    case PaymentRequest
    case PaymentEnquery
    
}




protocol ServiceDelegate {
    func serviceNoConnectionIsAvailable();
}

protocol ServiceProtocol
{
    func KeyChange(callback: @escaping (Int?) -> Void) ;
    
    
    
}

class Services {
    static let instance:ServiceProtocol = ServiceRestful(apiURLBase: "https://pas.shaparak.ir/api/")
}

class ServiceRestful: NSObject, ServiceProtocol {
 
    
    private var  s = StringService()
    private var sdkInfo :String;
    private var apiURLBase:String;
     var phoneNumber = "";
    private var AppID:String! = nil;
    private var basicAuthHeader:[String:Any?]? = nil;
    private var delegate:ServiceDelegate?;
    
    init(apiURLBase:String) {
        
        self.apiURLBase = apiURLBase
        self.phoneNumber = s.getPhoneNo();
        self.sdkInfo = s.getSdkInfo();
        super.init();
        
    }
    
    
    private func URL(For api:ServerAPI) -> String {
        
        var relativePath = "";
        
        switch api {
        case .KeyChange:
            relativePath = "KeyChange"
            break;
        case .CardNos:
            relativePath = "CardNos"
            break;
        case .PaymentRequest:
            relativePath = "PaymentRequest"
            break;
        case .PaymentEnquery:
            relativePath = "PaymentEnquery"
            break;
            
            
        }
        return apiURLBase.appendingFormat("%@", relativePath);
    }
    private func generateAppID() -> String {
        
        assert(phoneNumber.isEmpty==false);
        
        return "\(Int(Date().timeIntervalSince1970))\(phoneNumber)";
    }
    
    func generateBasicAuthentication(perfix : String) -> String {
        
        let semaphore = DispatchSemaphore(value: 0);
        var token = "";
        
        DispatchQueue.global().async {
            let ph = "\(NSDate()),\(self.phoneNumber)"
            let cypher = CypherSwift();
            var key = self.s.getWorkingKey()
            if (perfix == "skc")
            {
                key = self.s.getMasterKey()
            }
            let base64 = cypher.tripleDesEncrypt(pass: ph, base64Key: key)
            token =  cypher.base64String(input: "\(perfix),\(self.phoneNumber),\(base64),\(self.sdkInfo)") ?? ""
            semaphore.signal();
        }
        semaphore.wait();
        
        return token;
    }
    
    
    
    
    
    
    func extend(Params param:Dictionary<String,Any>) -> Dictionary<String,Any> {
        
        let cypher = CypherSwift();
        let phone =   self.phoneNumber ;
        var key = s.getWorkingKey()
        if(key == "")
        {
            key = s.getMasterKey()
        }
        let sign = cypher.tripleDesEncrypt(pass: phone, base64Key: key)
        
        var nparam = param;
        nparam["PhoneNo"] = phone;
        nparam["SdkInfo"] = self.sdkInfo;
        nparam["Sign"] = sign
        return nparam;
    }
    
    func checkForDisconnectionError(error:Error) {
        
        if let err = (error as NSError!) {
            if err.code == -1009 {
                delegate?.serviceNoConnectionIsAvailable();
            }
        }
        
    }
    
    func setDelegate(delegate: ServiceDelegate) {
        self.delegate = delegate;
    }
    
    func handleError(responseCode:Int!) -> Bool {
        
        
        if responseCode == 500 {
            return true;
        }
        //
        return false;
    }
    
    func httpHeader(withAuthentication auth:Bool = true, perfix :String) -> [String:String]? {
        if auth {
            return ["Authorization": "Basic \(generateBasicAuthentication(perfix: perfix))"];
        }
        else {
            return ["Authorization": "Basic No_Need_Authorization"];
        }
        
    }
    
    
    
    func KeyChange(callback: @escaping (Int?) -> Void) {
//        request(URL(For: .KeyChange),
//                method: .post,
//                parameters: extend(Params: [:]),
//                encoding: URLEncoding.default,
//                headers: httpHeader( perfix: "skc")).responseJSON { (res) in
//
//                    if self.handleError(responseCode: res.response?.statusCode) {
//                        callback(-200);
//                        return;
//                    }
//
//                    if res.result.error != nil {
//                        self.checkForDisconnectionError(error: res.result.error!);
//                        DispatchQueue.main.async {
//                            callback( -200);
//                        }
//                    }
//                    else {
//
//                        let json = (res.result.value as! NSDictionary);
//                        let model = Mapper<KeyChangeResult>().map(JSONObject: json)
//                        if (model?.ErrorCode == 0 && (model?.WorkingKey ?? "") != "" )
//                        {
//                            let cypher = CypherSwift();
//                            let wk = cypher.tripleDesDecrypt(pass: model!.WorkingKey!, base64Key: self.s.getMasterKey())
//                            self.s.setWorkingKey(value: wk)
//                        }
//                        DispatchQueue.main.async {
//
//                            callback(model?.ErrorCode);
//
//                        }
//                    }
//
//        }
//
//    }
//
//    func CardNos(callback: @escaping ([CardNoModel]) -> Void) {
//        request(URL(For: .CardNos),
//                method: .post,
//                parameters: extend(Params: [:]),
//                encoding: URLEncoding.default,
//                headers: httpHeader( perfix: "sdk")).responseJSON { (res) in
//
//                    if self.handleError(responseCode: res.response?.statusCode) {
//                        callback([]);
//                        return;
//                    }
//
//                    if res.result.error != nil {
//                        self.checkForDisconnectionError(error: res.result.error!);
//                        DispatchQueue.main.async {
//                            callback( []);
//                        }
//                    }
//                    else {
//
//                        let json = (res.result.value as! NSDictionary);
//                        let listArray = json["CardNos"] as? NSArray;
//                        let list = Mapper<CardNoModel>().mapArray(JSONObject: listArray)
//                        DispatchQueue.main.async {
//                            callback(list ?? []);
//
//                        }
//                    }
//
//        }
//
    }
    
//    func PaymentRequest(requestModel: PaymentRequestModel ,callback: @escaping (PaymentRequestResult?) -> Void) {
//        let paymentReqPlain = "\(String(describing: requestModel.CardNo)),\(String(describing: requestModel.Pin)),\(String(describing: requestModel.Cvv2)),\(String(describing: requestModel.Expiredate)),\(requestModel.OrderId),\(requestModel.Amount),\(self.phoneNumber)"
//           let cypher = CypherSwift();
//        let paymentReq = cypher.tripleDesEncrypt(pass: paymentReqPlain, base64Key: self.s.getWorkingKey())
//        request(URL(For: .CardNos),
//                method: .post,
//                parameters: extend(Params: ["PaymentInfo": paymentReq]),
//                encoding: URLEncoding.default,
//                headers: httpHeader( perfix: "sdk")).responseJSON { (res) in
//
//                    if self.handleError(responseCode: res.response?.statusCode) {
//                        callback(nil);
//                        return;
//                    }
//
//                    if res.result.error != nil {
//                        self.checkForDisconnectionError(error: res.result.error!);
//                        DispatchQueue.main.async {
//                            callback( nil);
//                        }
//                    }
//                    else {
//
//                        let json = (res.result.value as! NSDictionary);
//                        let pres = json["PaymentRequestResponse"] as?  NSDictionary;
//                        let model = Mapper<PaymentRequestResult>().map(JSONObject: pres)
//                        DispatchQueue.main.async {
//                            callback(model);
//
//                        }
//                    }
//
//        }
        
//    }
    
//    func PaymentEnquery(token : String ,callback: @escaping (PaymentEnqueryResult?) -> Void) {
    
//        let cypher = CypherSwift();
//        let tokenEnc = cypher.tripleDesEncrypt(pass: token, base64Key: self.s.getWorkingKey())
//        request(URL(For: .CardNos),
//                method: .post,
//                parameters: extend(Params: ["Token": tokenEnc]),
//                encoding: URLEncoding.default,
//                headers: httpHeader( perfix: "sdk")).responseJSON { (res) in
//
//                    if self.handleError(responseCode: res.response?.statusCode) {
//                        callback(nil);
//                        return;
//                    }
//
//                    if res.result.error != nil {
//                        self.checkForDisconnectionError(error: res.result.error!);
//                        DispatchQueue.main.async {
//                            callback( nil);
//                        }
//                    }
//                    else {
//
//                        let json = (res.result.value as! NSDictionary);
//                        let pres = json["PaymentReceiptModel"] as?  NSDictionary;
//                        let model = Mapper<PaymentEnqueryResult>().map(JSONObject: pres)
//                        DispatchQueue.main.async {
//                            callback(model);
//
//                        }
//                    }
//
//        }
        
//    }
    
    
}
