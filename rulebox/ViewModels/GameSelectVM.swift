//
//  GameSelectVM.swift
//  rulebox
//
//  Created by POS on 6/4/25.
//

import Foundation
import SwiftData
import Combine

class GameSelectVM: ObservableObject {
    @Published var selectedGenre: String = "전체"
    
    
    func filterGames(from games: [GameName]) -> [GameName] {
        selectedGenre == "전체" ? games : games.filter { $0.genres.contains(selectedGenre) }
    }
}
