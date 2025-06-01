////
////  Loader.swift
////  rulebox
////
////  Created by POS on 6/1/25.
////
//
//import Foundation
//import SwiftData
//
//struct Loader {
//    static func loadInitialDataIfNeeded(modelContext: ModelContext) {
//        let fetchDescriptor = FetchDescriptor<GameName>()
//        if let result = try? modelContext.fetch(fetchDescriptor), !result.isEmpty {
//            print("Data already exist")
//            return
//        }
//
//        let folderPath = "rulebox/Data/Resource"
//
//        do {
//            let fileURLs = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: folderPath), includingPropertiesForKeys: nil)
//            
//            for fileURL in fileURLs where fileURL.pathExtension.lowercased() == "json" {
//                print("Parsing file: \(fileURL.lastPathComponent)")
//                let data = try Data(contentsOf: fileURL)
//                try Parser.parseBasicRule(from: data, context: modelContext)
//            }
//        } catch {
//            print("Loader 에러: \(error)")
//        }
//    }
//}
