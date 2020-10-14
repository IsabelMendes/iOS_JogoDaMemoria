//
//  JogoDaMemoria.swift
//  JogoDaMemoria
//
//  Created by Isabel Francine Mendes on 12/10/20.
//

import Foundation

enum RespostaTentativa {
    case ACERTOU
    case ERROU
    case VENCEU
    case PERDEU
}

class JogoDaMemoria {
    private let maximoDeErros = 3
    private let maximoDeAcertos = 5
    let cards: [String:String]
    var tempCards = [String:String]()
    
    private var erros: Int = 0
    private var acertos: Int = 0
    
    func tentativa(card1:String, card2:String) -> RespostaTentativa {
        if card1 == card2 {
            acertos += 1
            if acertos >= maximoDeAcertos {
                return RespostaTentativa.VENCEU
            } else {
                return RespostaTentativa.ACERTOU
            }
        } else {
            erros += 1
            if erros >= maximoDeErros {
                return RespostaTentativa.PERDEU
            } else {
                return RespostaTentativa.ERROU
            }
        }
    }
    
    init(cards: [String: String]) {
        self.cards = cards
        for j in 0...9 {
            tempCards["\(j)"] = "Card"
        }
    }
}

let allCards = [
    "0": "Card Anão",
    "1": "Card Bruxa",
    "2": "Card Cavaleiro",
    "3": "Card Elfa",
    "4": "Card Mago",
    "5": "Card Anão",
    "6": "Card Bruxa",
    "7": "Card Cavaleiro",
    "8": "Card Elfa",
    "9": "Card Mago"
]

extension JogoDaMemoria {
    class func aleatorio() -> JogoDaMemoria {
        let keys = allCards.keys.shuffled()
        var newCards = [String:String]()

        for k in keys {
            newCards[k] = allCards[k]
        }
        return JogoDaMemoria(cards: newCards)
    }
}
