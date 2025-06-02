////
////  Loader.swift
////  rulebox
////
////  Created by POS on 6/1/25.
////
//
//import Foundation
//
//func loadJSONData(from fileName: String) -> Data? {
//    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
//        print("Loader Error:: file not found : \(fileName).json")
//        return nil
//    }
//
//    do {
//        let data = try Data(contentsOf: url)
//        return data
//    } catch {
//        print("Loader Error:: can't load data : \(error)")
//        return nil
//    }
//}
