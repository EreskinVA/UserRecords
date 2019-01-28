//
//  Managers.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import Foundation
import SystemConfiguration

class Network {
    private init() {}
    static let shared = Network()
    
    private func post(methodAPI: String,
                      parametrs: String,
                      completion: @escaping (Data) -> ()) {
        
        guard let url = URL(string: "https://bnet.i-partner.ru/testAPI/") else { return }
        
        let postString = "a=\(methodAPI)" + parametrs
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("uUzLyQX-zA-4UqKP2F", forHTTPHeaderField: "token")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
            }.resume()
    }
    
    // Получение ID сессии устройства
    public func postSession(completion: @escaping(String) -> ()) {
        Network.shared.post(methodAPI: "new_session", parametrs: "") { (json) in
            do {
                print(json)
                let response = try JSONDecoder().decode(Session.self, from: json).data?.session
                completion(response!)
            } catch {
                print(error)
            }
        }
    }
    
    // Добавление записи на сервер
    public func postAppendRecord(parameters: String) {
        Network.shared.post(methodAPI: "add_entry", parametrs: parameters) { _ in }
    }
    
    // Получение массива записей с сервера
    public func postListRecords(parameters: String, completion: @escaping([DataRecord]) -> ()) {
        Network.shared.post(methodAPI: "get_entries", parametrs: parameters) { (json) in
            do {
                print(json)
                let response = try JSONDecoder().decode(Record.self, from: json).data[0]
                completion(response)
            } catch {
                print(error)
            }
        }
    }
    
    // Проверка есть ли подключение к интернету
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {return false}
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}

// конвертирование полученного TimeInterval с сервера в Дату
extension String {
    func stringToDate() -> String {
        let timeIntervalString = TimeInterval(self)
        
        let date = Date(timeIntervalSince1970: timeIntervalString!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

extension String {
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
}
