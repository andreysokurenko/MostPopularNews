//
//  FavoritesTableViewController.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
    var favouriteTitle = [Favorites]()
    var titleUrl = ""
    let fetch = NetworkService()
    var resultArray: [Result]?
    var selectedTitle: Result?
    
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            favouriteTitle = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: prepare favSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favSegue") {
            guard let titleArticle = segue.destination as? WebViewController else { return }
            titleArticle.titleUrl = titleUrl
            titleArticle.article = selectedTitle
        }
    }
    
    // MARK: setupCell
      private func setupCell() {
           let nib = UINib(nibName: "TitleLabelCell", bundle: nil)
           tableView.register(nib, forCellReuseIdentifier: TitleLabelCell.reuseId)
       }
    
    // MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteTitle.count
    }
    // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleLabelCell.reuseId, for: indexPath) as! TitleLabelCell
        cell.titleLabel.text = favouriteTitle[indexPath.row].title
        
        return cell
    }
    
    // MARK: heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // MARK: editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            managedContext.delete(favouriteTitle[indexPath.row])
            do {
                try managedContext.save()
                favouriteTitle.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            catch let error {
                print(error)
            }
        }
    }
    // MARK: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = favouriteTitle[indexPath.row].url else {return}
        titleUrl = url
        selectedTitle = resultArray?[indexPath.row]
        performSegue(withIdentifier: "favSegue", sender: self)
    }
    
}
