//
//  MostSharedTableViewController.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import Alamofire

class MostSharedTableViewController: UITableViewController {
    var titileUrl = ""
    let fetch = NetworkService()
    var resultArray: [Result]?
    var selectedTitle: Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        responseData()
        
    }
     // MARK: responseData
    func responseData() {
        self.resultArray = []
        fetch.getDataJsonShared(dataType: URLComponent.keyPartUrl.shared.rawValue) { (data) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let responseResult = try decoder.decode(Empty.self, from: data)
                for result in responseResult.results {
                    self.resultArray?.append(result)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
    }
     // MARK: prepare sharedSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sharedSegue") {
            guard let titleArticle = segue.destination as? WebViewController else { return }
            titleArticle.titleUrl = titileUrl
            titleArticle.article = selectedTitle
        }
    }
    // MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray?.count ?? 0
    }
    
    // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sharedId", for: indexPath) as! MostSharedTableViewCell
        
        let result = resultArray?[indexPath.row]
        cell.mostSharedLabel.text = result?.title
        
        return cell
    }
    // MARK: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = resultArray?[indexPath.row].url else {return}
        titileUrl = url
        selectedTitle = resultArray?[indexPath.row]
        performSegue(withIdentifier: "sharedSegue", sender: self)
    }
    
    
}
