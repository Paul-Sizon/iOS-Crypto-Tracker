//
//  ApiService.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import Foundation

class ApiService {
    func getCryptoData(completion: @escaping (CryptoResponse) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,binancecoin,cardano,dogecoin,matic-network&vs_currencies=usd") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(CryptoResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        task.resume()
    }
}

