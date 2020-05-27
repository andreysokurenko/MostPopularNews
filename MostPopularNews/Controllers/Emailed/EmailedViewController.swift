//
//  TableViewController.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import Alamofire


class EmailedViewController: UITableViewController {
    
    var titleUrl = ""
    let fetch = NetworkService()
    var resultArray: [Result]?
    var selectedTitle: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseData()
    }
    
    // MARK: responseData
  private func responseData() {
        self.resultArray = []
        fetch.getJsonData(dataType: URLComponent.keyPartUrl.emailed.rawValue) { (data) in
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
    // MARK: prepare emailedSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "emailedSegue") {
            guard let titleArticle = segue.destination as? WebViewController else { return }
            titleArticle.titleUrl = titleUrl
            titleArticle.article = selectedTitle
        }
    }
     // MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray?.count ?? 0
    }
     // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmailedViewCell
        let result = resultArray?[indexPath.row]
        cell.titleLabel.text = result?.title
        
        return cell
    }
    // MARK: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = resultArray?[indexPath.row].url else {
            return}
        titleUrl = url
        selectedTitle = resultArray?[indexPath.row]
        performSegue(withIdentifier: "emailedSegue", sender: self)
    }
    
    
}
