//
//  Lotto+CoreDataProperties.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/18/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lotto {

    @NSManaged var session: String?
    @NSManaged var user: String?
    @NSManaged var payload: [String]!

}
