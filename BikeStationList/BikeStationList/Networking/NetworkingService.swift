//
//  NetworkingService.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import Foundation
import RxSwift

final class NetworkingService {
    
    func requestData<T: Decodable>(_ url: URL, httpMethod: HTTPMethod = .get) -> Observable<T> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    observer.onError(NetworkError.invalidURL)
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
}
