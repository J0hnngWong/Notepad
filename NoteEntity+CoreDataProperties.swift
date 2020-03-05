//
//  NoteEntity+CoreDataProperties.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/5.
//  Copyright © 2020 王嘉宁. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}
