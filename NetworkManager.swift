//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation



enum NetworkEnvironment {
    case qa
    case production
    case staging
}

 enum SdkApi {
    case KeyChange
    case CardNos
    case PaymentRequest(payment:String)
    case PaymentEnquery(token:String)
}

extension SdkApi: EndPointType {
    var service : ServiceRestful {
        return ServiceRestful(apiURLBase: "https://pas.shaparak.ir/api/")
    }
    
    
    
    var environmentBaseURL : String {
        return "https://pas.shaparak.ir/api/";
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .KeyChange:
            return "KeyChange"
        case .CardNos:
            return "CardNos"
        case .PaymentRequest:
            return "PaymentRequest"
        case .PaymentEnquery:
            return "PaymentEnquery"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .KeyChange:
            return .requestParametersAndHeaders(bodyParameters: service.extend(Params: [:]),
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: [:], additionHeaders: service.httpHeader( perfix: "skc"))
        case .PaymentRequest(let paymentReq):
            return .requestParametersAndHeaders(bodyParameters: service.extend(Params: ["PaymentInfo": paymentReq]),
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: [:], additionHeaders: service.httpHeader( perfix: "sdk"))
            
        case .PaymentEnquery(let token):
            return .requestParametersAndHeaders(bodyParameters: service.extend(Params: ["Token": token]),
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: [:], additionHeaders: service.httpHeader( perfix: "sdk"))
        default:
            return .requestParametersAndHeaders(bodyParameters: service.extend(Params: [:]),
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: [:], additionHeaders: service.httpHeader( perfix: "sdk"))
        }
    }
    
    var headers: HTTPHeaders? {
        return service.httpHeader( perfix: "skc")
    }
}



enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

class NetworkManagers {
    static let instance:NetworkManager = NetworkManager()
}

struct NetworkManager {
    
    private var  s = StringService()
    
    static let MovieAPIKey = ""
    let router = Router<SdkApi>()
    
    func KeyChange(callback: @escaping (Int?) -> Void){
        router.request(.KeyChange) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    callback(nil)
                }
                
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(KeyChangeApiResponse.self, from: responseData)
                        
                        if (apiResponse.ErrorCode == 0 && apiResponse.WorkingKey  != "" )
                        {
                            let cypher = CypherSwift();
                            let wk = cypher.tripleDesDecrypt(pass: apiResponse.WorkingKey, base64Key: self.s.getMasterKey())
                            self.s.setWorkingKey(value: wk)
                        }
                        DispatchQueue.main.async {
                            callback(apiResponse.ErrorCode)
                        }
                        
                    }catch {
                        print(error)
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        callback(nil)
                    }
                }
            }
        }
    }
    
    
    func CardNos(callback: @escaping ([CardNo]) -> Void){
        router.request(.CardNos) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    callback([])
                }
                
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            callback([])
                        }
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(CardNosApiResponse.self, from: responseData)
                        DispatchQueue.main.async {
                            
                            
                            callback(apiResponse.CardNos)
                        }
                    }catch {
                        print(error)
                        DispatchQueue.main.async {
                            callback([])
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        callback([])
                    }
                }
            }
        }
    }
    
    
    func PaymentRequest(requestModel: PaymentRequestModel ,callback: @escaping (PaymentRequestRes?) -> Void){
        let paymentReqPlain = "\(String(describing: requestModel.CardNo!)),\(String(describing: requestModel.Pin!)),\(String(describing: requestModel.Cvv2!)),\(String(describing: requestModel.Expiredate!)),\(requestModel.OrderId),\(requestModel.Amount),\(self.s.getPhoneNo())"
        let cypher = CypherSwift();
        let paymentReq = cypher.tripleDesEncrypt(pass: paymentReqPlain, base64Key: self.s.getWorkingKey())
        
        router.request(.PaymentRequest(payment: paymentReq)) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    callback(nil)
                }
                
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PaymentRequestApiResponse.self, from: responseData)
                        DispatchQueue.main.async {
                            
                            
                            callback(apiResponse.PaymentRequestResponse)
                        }
                    }catch {
                        print(error)
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        callback(nil)
                    }
                }
            }
        }
    }
    
    func PaymentEnquery(token : String ,callback: @escaping (PaymentEnqueryApiResponse?) -> Void){
        let cypher = CypherSwift();
        let car = "\(token),\(self.s.getPhoneNo())"
        let tokenEnc = cypher.tripleDesEncrypt(pass: car, base64Key: self.s.getWorkingKey())
        
        router.request(.PaymentEnquery(token: tokenEnc)) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    callback(nil)
                }
                
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PaymentEnqueryApiResponse.self, from: responseData)
                        DispatchQueue.main.async {
                            
                            callback(apiResponse)
                        }
                    }catch {
                        print(error)
                        DispatchQueue.main.async {
                            callback(nil)
                        }
                    }
                case .failure(let networkFailureError):
                    DispatchQueue.main.async {
                        callback(nil)
                    }
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
