//
//  BoardGameController.swift
//  Cards
//
//  Created by ALEKSEY SUSLOV on 03.11.2022.
//

import UIKit

class BoardGameController: UIViewController {
    
    // количество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
}
