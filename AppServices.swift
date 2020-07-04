//
//  AppService.swift
//  SayanInAppPayment
//
//  Created by Amir on 8/21/1397 AP.
//  Copyright © 1397 Sayan. All rights reserved.
//

import Foundation


 protocol Repository{
    init()
    associatedtype T
    func FindByKe(key : AnyObject) -> T?
    func First(key : AnyObject?) -> T?
    func List(key : AnyObject?) -> [T]?
    func Save (key: AnyObject, entity : AnyObject)
    func Delete(key: AnyObject) -> Bool?
    func GetAll() -> [T]?
    func Store (key  : AnyObject , entity : [T])
    func Store (key  : AnyObject , entity : T)
    func Locate(key : AnyObject?) -> T?
    func LocateList(key : AnyObject?) -> [T]?
}



 class NSUserDefaultsRepositorySuper<Entity> : Repository {
     func Store(key: AnyObject,  entity : [Entity]) {
        
    }
    
     func Store(key: AnyObject, entity: Entity) {
        
    }
    
     func Locate(key: AnyObject?) -> Entity? {
        return nil
    }
    
     func LocateList(key: AnyObject?) -> [Entity]? {
        return nil
    }
    
      required init() {
        
    }
    
     typealias T = Entity
      func FindByKe(key: AnyObject) -> Entity? {
        return self.First(key: key)
    }
      func First(key: AnyObject?) -> Entity? {
        let arrayOfEvents = UserDefaults.standard.object(forKey: String(describing: key!))
        if(arrayOfEvents == nil)
        {
            return nil
        }
        if let ar = arrayOfEvents as? NSData
        {
            let ua = NSKeyedUnarchiver.unarchiveObject(with: ar as Data)
            return (ua as? Entity)!
            
        }
        return (arrayOfEvents as? Entity)!
        
    }
    
     func List(key: AnyObject?) -> [Entity]? {
        var r : [Entity] = Array()
        let el = UserDefaults.standard.array(forKey: key as? String ?? "default")
        if(el == nil)
        {
            return Array<Entity>()
        }
        
        for it in el! {
            let ua = NSKeyedUnarchiver.unarchiveObject(with: (it as! NSData) as Data)
            r.append(ua as! Entity)
        }
        return r;
    }
 func Save(key: AnyObject, entity: AnyObject) {
        if let t = entity as? Array<Entity>
        {
            self.Save(key : key, entity: t)
            return
        }
        let encoded = NSKeyedArchiver.archivedData( withRootObject: entity)
        UserDefaults.standard.set(encoded, forKey: String(describing: key))
        UserDefaults.standard.synchronize()
    }
    
      func Save(key: AnyObject, entity: [Entity]) {
        var e  : [AnyObject] = Array()
        for el in entity {
            let encoded = NSKeyedArchiver.archivedData( withRootObject: el)
            e.append(encoded as AnyObject)
            
        }
        UserDefaults.standard.set(e, forKey: key as! String)
        UserDefaults.standard.synchronize()
    }
      func Delete(key: AnyObject) -> Bool? {
        UserDefaults.standard.removeObject(forKey: String(describing: key))
        return true;
    }
       func GetAll() -> [T]? {
        let res : [T] = Array()
        return res
    }
}

 class StringRepository: NSUserDefaultsRepositorySuper<String> {
      required init()
    {
        super.init()
    }
    
    
    
}

protocol Service
{
    associatedtype T
    func FindByKey(key : AnyObject) -> T?
    func First(key : AnyObject?) -> T?
    func List(key : AnyObject?) -> [T]?
    func Save (key: AnyObject, entity : AnyObject)
    func Delete(key: AnyObject) -> Bool?
    
    func Store (key  : AnyObject , entity : [T])
    func Store (key  : AnyObject , entity : T)
    func Locate(key : AnyObject?) -> T?
    func LocateList(key : AnyObject?) -> [T]?
}






 class SuperService<Entity,TRepository:Repository> : Service where TRepository.T ==   Entity
{
    
    
    
     typealias T = Entity
      var reposity : TRepository
      init()
    {
        reposity = TRepository()
    }
    
      func FindByKey(key : AnyObject) -> Entity?
    {
        return self.reposity.FindByKe(key: key)
    }
    
       func First(key: AnyObject?) -> Entity? {
        
        return  self.reposity.First(key: key)
    }
       func List(key: AnyObject?) -> [Entity]? {
        
        return  self.reposity.List(key: key)
    }
       func Save(key: AnyObject, entity: AnyObject) {
        self.reposity.Save(key: key, entity: entity)
    }
    
    
       func Delete(key: AnyObject) -> Bool? {
        return   self.reposity.Delete(key: key)
    }
      func GetAll() -> [Entity]?
    {
        return self.reposity.GetAll()
    }
    
    func Store(key: AnyObject, entity : [Entity]) {
        self.reposity.Store(key: key, entity: entity)
    }
    
    func Store(key: AnyObject, entity: Entity) {
        self.reposity.Store(key: key, entity: entity)
    }
    
    func Locate(key: AnyObject?) -> Entity? {
        return self.reposity.Locate(key: key)
    }
    
    func LocateList(key: AnyObject?) -> [Entity]? {
        return self.reposity.LocateList(key: key)
    }
    
    
}


 class StringService: SuperService<String,StringRepository> {
    
     func setPhoneNo(value : String)
    {
        self.Save(key: "PhoneNo" as AnyObject, entity: value as AnyObject)
    }
     func getPhoneNo() -> String
    {
        return  self.First(key: "PhoneNo" as AnyObject) ?? ""
    }
    
     func setWorkingKey(value : String)
    {
        self.Save(key: "WorkingKey" as AnyObject, entity: value as AnyObject)
    }
     func getWorkingKey() -> String
    {
        return  self.First(key: "WorkingKey" as AnyObject) ?? ""
    }
     func getMasterKey() -> String
    {
        return "oMnPEUM+wJmzApS7Zh41MCbijU6JiGL5";
    }
     func getSdkInfo() -> String
    {
        return "a1cd3709-1afb-41e9-a953-fc606362767e";
    }
}




