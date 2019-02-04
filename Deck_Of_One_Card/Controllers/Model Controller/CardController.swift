//
//  CardController.swift
//  Deck_Of_One_Card
//
//  Created by Deniz Tutuncu on 2/4/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class CardController {
    //CRUD
    //MARK: Create
    //BASE URL
    private static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func drawCard(numberOfCard: Int, completion: @escaping ((_ cards: [Card]) -> Void )) {
        //build my url
        guard let url = baseURL else { fatalError("URL optional is having issues") }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let countQueryItem = URLQueryItem(name: "count", value: "\(numberOfCard)")
        components?.queryItems = [countQueryItem]
        
        //Build my request
        guard let requestURL = components?.url else { return }
        print(requestURL)
        // Get my data
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            do {
                if let downloadError = error { throw downloadError }
                guard let data = data else { throw NSError() }
                
                //Decode
                let jsonDecoder = JSONDecoder()
                let deck = try! jsonDecoder.decode(TopLevelDictionary.self, from: data)
                completion(deck.cards)
                
            } catch {
                print("Error \(requestURL)")
                completion([])
                return
            }
        }
        dataTask.resume()
    }
    
    static func image(forURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        //create the URL
        guard let url = URL(string: urlString) else { return print("Error trying to create your umage URL")}
        
        //dataTask
        let imageDataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            //Handle the Error
            if let imageError = error {
                print("Error retriving image \(imageError.localizedDescription)")
                completion(nil)
            }
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        imageDataTask.resume()
    }
}
