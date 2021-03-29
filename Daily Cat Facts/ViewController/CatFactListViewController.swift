//
//  CatFactListViewController.swift
//  Daily Cat Facts
//
//  Created by Adriaan on 2020/02/25.
//  Copyright © 2020 Adriaan. All rights reserved.
//

import UIKit
import CoreData

class CatFactListViewController: UITableViewController {
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var factDB = [CatFact]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var catFactManager = CatFactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catFactManager.delegate = self
        self.loadCatFacts()
        self.navigationController?.navigationBar.topItem?.title = "Cat Facts"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactTableViewCell
        if let item = factDB[indexPath.row].fact {
            cell.factLabel?.text = "Fact \(indexPath.row + 1): \(item)"
        }
        return cell
    }
    
    //MARK: Private
    private func startLoadindAnimation() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func loadCatFacts() {
        let request : NSFetchRequest<CatFact> = CatFact.fetchRequest()
        do {
            factDB = try context.fetch(request)
            if factDB.count == 0 {
                catFactManager.performRequest()
                self.startLoadindAnimation()
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        } catch {
            print("Error loading fact \(error)")
        }
    }
}
extension CatFactListViewController: CatFactManagerDelegate {
    func saveCatFacts(_ CatFactManager: CatFactManager, catFacts: [CatFactResponseModel]) {
        for fact in catFacts {
            let newFacts = CatFact(context: self.context)
            newFacts.fact = fact.catFact
        }
        do {
            try context.save()
        } catch {
            print("Error saving fact \(error)")
        }
        self.loadCatFacts()
    }
}
