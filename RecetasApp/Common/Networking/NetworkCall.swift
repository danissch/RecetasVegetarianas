//
//  NetworkCall.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation
import Alamofire

protocol NetworkCallDelegate {
    func onSuccess()
    func onUnauthorizedRequest()
}

class NetworkCall:NSObject {
    
    var delegate: NetworkCallDelegate?
    
    var data: [String : Any] = [:]
    var service: EndpointList?
    var parameters: [String : Any] = Parameters()
    var headers: [String : String] = [:]
    var method: HTTPMethod!
    var url: String!
    var isJSONRequest: Bool?
    var encoding: ParameterEncoding! = JSONEncoding.default
    
    init(data: [String:Any] = [:],
         headers: [String:String] = [:],
         url: String? = nil,
         service: EndpointList? = nil,
         method: HTTPMethod = .get,
         isJSONRequest: Bool = true){
        
        super.init()
        
        self.data = data
        self.service = service
        self.data.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        self.url = EndpointList.buildAndSetURL(url: url, service: service)
        self.headers = headers.isEmpty ? APIHeaders.getHeaders() : headers
        self.isJSONRequest = isJSONRequest
        
        if !(self.isJSONRequest ?? true) {
            encoding = URLEncoding.default
        }
        
        self.method = method
    }
    
    func executeQuery<T>(completion: @escaping (Swift.Result<T, Error>, [String:Any]?, Int, DataResponse<Data>) -> Void) where T: Codable {
        
        Alamofire.request(url,method: method,parameters: parameters,encoding: encoding, headers: headers).responseData(completionHandler: { [self] response in
            switch response.result{
            case .success(let res):
                handleSuccessResponse(res: res, response: response,
                                      completion: completion)
                break
            case .failure(let error):
                
                completion(.failure(error), [:], response.response?.statusCode ?? 0, response)
                break
                
            }
        })
    }
    
}

extension NetworkCall {
    
    private func handleSuccessResponse<T>(res: (Data),
                                          response: DataResponse<Data>,
                                          completion: @escaping (
                                            Swift.Result<T, Error>,
                                            [String:Any]?,
                                            Int,
                                            DataResponse<Data>
                                          ) -> Void) where T: Codable {
        
                                              let jsonResponse: [String:Any] = ApiServiceHelper.getResponseAsJson(rawResponse: res) ?? [:]
                                              NetworkLog.paintLogs(url: url, method: method?.rawValue ?? "", request: parameters, response: jsonResponse, headers: headers)
                
        if let code = response.response?.statusCode {
            switch code {
            case 200...299:
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: res)
                    completion(.success(responseObject), jsonResponse, code, response)
                    
                } catch let error {
                    let responseError = "\(String(data: res, encoding: .utf8) ?? "nothing received")"
                    print("appflow::responseError.dictionary responseError BEGIN:: \(responseError) ::responseError END")
                    
                    let errorText = error.localizedDescription
                    print("appflow::: handleSuccessResponse error: \(errorText)")
                    
                    let errorToReport = buildError(text: errorText, code: code, response: response)
                    completion(.failure(errorToReport), jsonResponse, code, response)
                }
                break
            case 401:
                self.delegate?.onUnauthorizedRequest()
                
                let errorToReport = buildError(text: "No Autorized", code: code, response: response)
                completion(.failure(errorToReport), jsonResponse, code, response)
                break
            default:
                var error = buildError(text: response.debugDescription, code: code, response: response)
                print("appflow::: handleSuccessResponse default error: \(error)")
                if let httpStatusCode = HTTPStatusCode(rawValue: code) {
                    error = buildError(
                        text: ApiServiceHelper.buildErrorMessage(httpStatusCode: httpStatusCode, code: code),
                        code: code,
                        response: response
                    )
                    print("appflow::: handleSuccessResponse Friendly error: \(error)")
                }
                completion(.failure(error), jsonResponse, code, response)
                break
            }
        }
    }
    
    private func buildError(text: String, code: Int, response: DataResponse<Data>) -> NSError {
        let error = NSError(domain: text, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
        return error
    }
    
}







