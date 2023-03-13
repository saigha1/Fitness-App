//
//  JSONManager.swift
//  Fitness_App
//
//  Created by Xavier on 2/16/23.
//

import Foundation

// Read data from JSON

func load<T: Decodable>(filename: String, location: FileLocation) -> T? {
    var data: Data?
    var file: URL
    switch location {
    case .bundle:
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        file = fileURL
    default:
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
    }

    guard data != nil else { return nil }
    
    do {
        let decoder = JSONDecoder()
        print("Reading...  📖: \(file.description)")
        return try decoder.decode(T.self, from: data!)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// Write data to JSON
func add<T: Codable>(newEntry: T, filename: String, location: FileLocation) {
    var entities: [T] = load(filename: filename, location: location) ?? []
    entities.append(newEntry)
    var file: URL
    switch location {
    case .bundle:
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        file = fileURL
    default:
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
        print("Saving...  📖: \(file.description)")
        try encoder.encode(entities).write(to: file)
    } catch {
        print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
    }
}

// Delete data from JSON

func remove<T: Codable & Equatable>(entry: T, filename: String, location: FileLocation) {
    var entities: [T] = load(filename: filename, location: location) ?? []
    //entities.append(entry)
    entities.removeAll { $0 == entry }
    var file: URL
    switch location {
    case .bundle:
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        file = fileURL
    default:
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
    }
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        print("Saving...  📖: \(file.description)")
        try encoder.encode(entities).write(to: file)
    } catch {
        print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
    }
}

// Update data in JSON
func update<T: Codable & Equatable>(old: T, new: T, filename: String, location: FileLocation) {
    var entities: [T] = load(filename: filename, location: location) ?? []
    entities.removeAll { $0 == old }
    entities.append(new)
    var file: URL
    switch location {
    case .bundle:
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        file = fileURL
    default:
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
    }
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        print("Saving...  📖: \(file.description)")
        try encoder.encode(entities).write(to: file)
    } catch {
        print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
    }
}

