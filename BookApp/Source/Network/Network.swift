//
//  Network.swift
//  BookApp
//
//  Created by Julia on 2023/03/10.
//

import Foundation

final class Network: NetworkProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func request<T>(_ request: T) async throws -> T.Output where T : Request {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let urlRequest = try RequestFactory(request: request).makeURLRequest()
                let task = session.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        continuation.resume(with: .failure(error))
                        return
                    }
                    guard let data = data,
                            let httpResponse = response as? HTTPURLResponse,
                            (200..<400).contains(httpResponse.statusCode)
                    else {
                        continuation.resume(with: .failure(NetworkError.badHttpResponse))
                        return
                    }
                    do {
                        let output = try JSONDecoder().decode(T.Output.self, from: data)
                        continuation.resume(with: .success(output))
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                }
                task.resume()
            } catch {
                continuation.resume(with: .failure(error))
            }
        })
    }
    
}

final class RequestFactory<T: Request> {
    private let request: T
    private var urlComponents: URLComponents?
    
    init(request: T) {
        self.request = request
        if let url = URL(string: request.baseURL) {
            self.urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        if !request.query.isEmpty {
            urlComponents?.queryItems = request.query.map { queryItems in
                URLQueryItem(name: queryItems.key, value: "\(queryItems.value)")
            }
        }
        
        guard let url = urlComponents?.url else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(request.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
}
