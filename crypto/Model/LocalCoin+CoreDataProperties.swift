//
//  LocalCoin+CoreDataProperties.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//
//

import Foundation
import CoreData


extension LocalCoin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalCoin> {
        return NSFetchRequest<LocalCoin>(entityName: "LocalCoin")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var initialPrice: Double

}

extension LocalCoin : Identifiable {

}
