//
//  APIService.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation
import Alamofire

class APIService {
    static func request<T: Decodable>(
        router: APIEndpoint,
        thread: DispatchQoS.QoSClass? = nil,
        onSuccess: @escaping (T, String?) -> Void,
        onFailure: @escaping (String?, APIError) -> Void
    ) {
        switch thread {
        case .background:
            DispatchQueue.global(qos: .background).async {
                callRequest(
                    router: router,
                    onSuccess: onSuccess,
                    onFailure: onFailure
                )
            }
        default:
            callRequest(
                router: router,
                onSuccess: onSuccess,
                onFailure: onFailure
            )
        }
    }

    static private func callRequest<T: Decodable>(
        router: APIEndpoint,
        onSuccess: @escaping (T, String?) -> Void,
        onFailure: @escaping (String?, APIError) -> Void
    ) {
        AF.request(router).responseDecodable { (response: AFDataResponse<T>) in
            handleResponse(
                response: response,
                onSuccess: onSuccess,
                onFailure: onFailure
            )
        }
    }

    static private func handleResponse<T: Decodable>(
        response: AFDataResponse<T>,
        onSuccess: @escaping (T, String?) -> Void,
        onFailure: @escaping (String?, APIError
        ) -> Void) {
        printLog(response: response)
        guard let jsonString = String(
            bytes: response.data ?? Data(),
            encoding: .utf8
        ) else { return }
        let dict = jsonString.convertToDictionary()
        let consumerErrorMessage = dict?["error"] as? String

        switch response.result {
        case let .success(baseData):
            guard let validatedStatusCode = response.response?.statusCode else { return }
            switch validatedStatusCode {
            case 200..<300:
                onSuccess(baseData, consumerErrorMessage)
            default:
                onFailure(response.error?.errorDescription, .noConnection)
            }
        case .failure:
            if !Reachability.isConnectedToNetwork() {
                onFailure(consumerErrorMessage, .noConnection)
            } else {
                onFailure(consumerErrorMessage, .noConnection)
            }
        }
    }

    static private func printLog<T: Decodable>(response: AFDataResponse<T>) {
        print("\n\n\n")
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        debugPrint(response)
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("\n\n\n")
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ) as? [String: Any]
        }
        return nil
    }
}
