//
//  DatabaseManager.swift
//  Albums
//
//  Created by Nivedita Angadi on 04/02/22.
//

import Foundation
import RealmSwift

protocol DatabaseOperations {
    static func write<T: Object>(_ object: T?, block: @escaping ((Realm, T?) -> Void))
    static func add(_ object: Object)
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    static func get<R: Object>(fromEntity entity: R.Type, withPredicate predicate: NSPredicate?, sortedByKey sortedKey: String?, inAscending isAscending: Bool) -> Results<R>
}

class DatabaseManager<T: Object>: DatabaseOperations {
    internal static func write<T: Object> (_ object: T? = nil, block: @escaping ((Realm, T?) -> Void)) {
        DispatchQueue(label: "database").sync {
            autoreleasepool {
                let currentRealm = realmInstance()

                if currentRealm.isInWriteTransaction {
                    return
                } else {
                    do {
                        try currentRealm.write {
                            block(currentRealm, object)
                        }
                    } catch {
                        return
                    }
                }
            }
        }
    }

    static func add(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }

    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }

    static func get<R: Object>(fromEntity entity : R.Type, withPredicate predicate: NSPredicate? = nil, sortedByKey sortKey: String? = nil, inAscending isAscending: Bool = true) -> Results<R> {
        var objects = realmInstance().objects(entity)
        if predicate != nil {
            objects = objects.filter(predicate!)
        }
        if sortKey != nil {
            objects = objects.sorted(byKeyPath: sortKey!, ascending: isAscending)
        }

        return objects
    }

    static func realmConfig() -> Realm.Configuration {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        let documentGroupPath = paths.first?.appendingPathComponent("Album.realm")

        let config = Realm.Configuration(fileURL: documentGroupPath, schemaVersion: 0)

        return config
    }

    private static func realmInstance() -> Realm {
        do {
            let realm = try Realm(configuration: realmConfig())
            return realm
        } catch {
            fatalError("Unable to create an instance of Realm")
        }
    }
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
