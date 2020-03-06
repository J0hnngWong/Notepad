//
//  DataBaseManager.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/5.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import CoreData

class DataBaseManager {
    
    private var dbContext: NSManagedObjectContext?
    
    public static let sharedManager = DataBaseManager()
    
    init() {
        self.createSqlite()
    }
    
    private func createSqlite() {
        //1.创建数据模型
        //创建模型路径 momd为系统自动生成
        guard let modelUrl = Bundle.main.url(forResource: "Note", withExtension: "momd") else { return }
        //根据模型文件创建模型对象
        guard let model = NSManagedObjectModel(contentsOf: modelUrl) else { return }
        
        //2.创建持久化存储助理：数据库
        //利用模型对象创建助理对象
        let store = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        //数据库的名称和路径
        let dbStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        guard let dbPath = dbStr?.appending("NoteDataBase.sqlite") else { return }
        print("data base path is : \(dbPath)")
        let dbUrl = URL(fileURLWithPath: dbPath)
        
//        let error = NSError()
        //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径， NSSQLiteStoreType： SQLite作为存储库
        do {
            try store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbUrl, options: nil)
        } catch {
            print("data base add persistent store error: fail to add a database")
        }
        
        //3. 创建上下文 保存信息 操作数据库
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        //关联持久化助理
        context.persistentStoreCoordinator = store
        
        dbContext = context
    }
    
    public func insertNote(note: Note, complete: ((Array<NoteEntity>) -> (Void))?) {
        guard let context = dbContext else { return }
        // 1.根据entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Note
        guard let noteEntity: NoteEntity = NSEntityDescription.insertNewObject(forEntityName: "NoteEntity", into: context) as? NoteEntity else { return }
        
        // 2.根据Note中的键值 给NSManagedObject对象赋值
        noteEntity.title = note.title
        noteEntity.detail = note.detail
        noteEntity.date = note.date
        noteEntity.id = UUID()
        
        // 查询所有数据请求
//        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
//        let resultArray = try? context.fetch(request) as? Array<NoteEntity>
        
        // 保存插入的数据
        do {
            try context.save()
        } catch {
            print("insert data fail")
        }
        
    }
    
    public func deleteNote(by id: UUID, complete: ((Array<NoteEntity>) -> (Void))?) {
        guard let context = dbContext else { return }
        // 创建删除请求
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        // 删除条件
        let deletePredicate = NSPredicate(format: "id = %@", id.uuidString)
        deleteRequest.predicate = deletePredicate
        
        // 返回要删除的对象数组
        let deleteArray = try? context.fetch(deleteRequest) as? Array<NSManagedObject>
        
        // 从数据库中删除
        guard let requestDeleteArray = deleteArray else {
            // 没有需要删除的
            return
        }
        for note in requestDeleteArray {
            context.delete(note)
        }
        
        // 没有任何条件就是读取所有的数据
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
//        let resultArray = try? context.execute(request)
        // 可能需要刷新数据
        
        // 记住保存
        do {
            try context.save()
        } catch {
            print("save delete action fail")
        }
    }
    
    public func updateNote(by id: UUID, title: String, detail: String, date: Date) {
        guard let context = dbContext else { return }
        // 创建查询请求
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        let updatePredicate = NSPredicate(format: "id = %@", id.uuidString)
        request.predicate = updatePredicate
        
        // 发送请求
        guard let resultArray = try? context.fetch(request) as? Array<NoteEntity> else { return } //否则就是没有查询到相应记录
        
        // 修改
        for noteEntity in resultArray {
            noteEntity.title = title
            noteEntity.detail = detail
            noteEntity.date = date
        }
        
        //可能需要刷新数据
        
        //保存操作
        do {
            try context.save()
        } catch {
            print("update note fail")
        }
    }
    
    public func testFunc() -> String {
        return "context content: \(String(describing: dbContext))"
    }
}
