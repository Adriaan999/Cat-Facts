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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var viewModel = CatFactViewModel(interactor: CatFactManagerInteractor(),
                                                  delegate: self,
                                                  context: context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        self.startLoadindAnimation()
        viewModel.loadFacts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.factDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactTableViewCell", for: indexPath) as! FactTableViewCell
        if let item = viewModel.factDB[indexPath.row].fact {
            cell.factLabelTitle.text = "Fact \(indexPath.row + 1):"
            cell.factLabelBody?.text = item
        }
        return cell
    }
    
    private func startLoadindAnimation() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupTableViewCell() {
        self.tableView.register(UINib(nibName: "FactTableViewCell", bundle: Bundle.main),
                                forCellReuseIdentifier: "FactTableViewCell")
    }
}


extension CatFactListViewController: CatFactViewModelDelegate {
    func didFetchFacts() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}
