//
//  CatFactViewModel.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation
import CoreData

protocol CatFactViewModelDelegate {
    func didFetchFacts()
}

class CatFactViewModel {
    private var interactor: CatFactManagerBoundary
    private var delegate: CatFactViewModelDelegate
    private var context: NSManagedObjectContext
    private var catFactList: [CatFactResponseModel]?
    private(set) var factDB = [CatFact]()
    
    init(interactor: CatFactManagerBoundary,
         delegate: CatFactViewModelDelegate,
         context: NSManagedObjectContext) {
        self.interactor = interactor
        self.delegate = delegate
        self.context = context
    }
    
    func loadFacts() {
        let request : NSFetchRequest<CatFact> = CatFact.fetchRequest()
        do {
            factDB = try context.fetch(request)
            if factDB.count == 0 {
                self.fetchCatFacts()
            } else {
                self.delegate.didFetchFacts()
            }
        } catch {
            print("Error loading fact \(error)")
        }
    }
    
    private func fetchCatFacts() {
        interactor.fetchCatFacts { (response) in
            if let facts = response {
                self.catFactList = facts
                self.saveFacts()
            }
        } failure: { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func saveFacts() {
        if let catFactList = catFactList {
            for fact in catFactList {
                let newFacts = CatFact(context: self.context)
                newFacts.fact = fact.catFact
            }
            do {
                try context.save()
            } catch {
                print("Error saving fact \(error)")
            }
            self.loadFacts()
        }
    }
}
