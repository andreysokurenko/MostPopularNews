//
//  WebViewController.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var titleUrl = ""
    var article: Result?
    var tasks: [Favorites] = []
    let webViews = WKWebView()
    private let managedContext = (
        UIApplication.shared.delegate as! AppDelegate
        )
        .persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.isEnabled = false
        webView.navigationDelegate = self
        webLoad(titleUrl: titleUrl)
        webView.addSubview(activityInd)
        activityInd.startAnimating()
        activityInd.hidesWhenStopped = true
    }
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        saveFavorites()
    }
    
    private func webLoad(titleUrl: String) {
        if let myUrl = URL(string: titleUrl) {
            let request = URLRequest(url: myUrl)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityInd.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityInd.stopAnimating()
        favoriteButton.isEnabled = true

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityInd.stopAnimating()
        favoriteButton.isEnabled = true

    }
    
}

extension WebViewController {
    
    private func saveFavorites() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Favorites
        taskObject.title = article?.title
        taskObject.url = titleUrl
        
        do {
            try context.save()
            tasks.append(taskObject)
            print("Saved! Good Job!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
