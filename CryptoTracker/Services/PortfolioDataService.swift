//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 15/01/2024.
//

import Foundation
import CoreData

//Handle all Logic of  getting all our Portfolio Data
class PortFolioDataService {
    
    
    //Setup CoreData
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    //publisher container to save data from CoreData
    @Published var savedEntities: [ PortfolioEntity ] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        
        //loads  data our container into this file 👇
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error loading core Data \(error)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        //check if coin is in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                updateEntity(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: PRIVATE
    
    // fetch all data inside the container
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            //get Data from reuest
         savedEntities =   try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching portfolio entities \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    // incase we just want to update our entity and not add new entity
    private func updateEntity(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    //save context after adding
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to core data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}

