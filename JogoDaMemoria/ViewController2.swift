//
//  ViewController2.swift
//  JogoDaMemoria
//
//  Created by Isabel Francine Mendes on 12/10/20.
//

import UIKit

class ViewController2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var jogo: JogoDaMemoria = JogoDaMemoria.aleatorio()
    private var isTempCards = false
    private var cardTentativa1 = ""
    private var cardTentativa2 = ""
    private var indexTentativa1 = -1
    private var indexTentativa2 = -1
    private var numeroTentativas = 0
    
    @IBAction func toqueBotaoRecomecar(_ sender: Any) {
        novoJogo()
    }
        
    @IBOutlet weak var reiniciar: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        novoJogo()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell

        let cardsValues = Array(isTempCards ? jogo.tempCards.values : jogo.cards.values)
        cell.imagem.image = UIImage(named: cardsValues[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cardsValues = Array(jogo.cards.values)
        let selectedValue = cardsValues[indexPath.item]
                
        let tempCardsKeys = Array(jogo.tempCards.keys)
        

        if cardTentativa1.isEmpty {
            cardTentativa1 = selectedValue
            indexTentativa1 = indexPath.item
            jogo.tempCards[tempCardsKeys[indexPath.item]] = cardTentativa1
            
            self.collectionView.reloadData()
            
            print("Tentativa 1 ok")
            
        } else  {
            self.numeroTentativas += 1
            cardTentativa2 = selectedValue
            indexTentativa2 = indexPath.item
            jogo.tempCards[tempCardsKeys[indexPath.item]] = cardTentativa2
            
            self.collectionView.reloadData()
            
            print("Tentativa 2 ok")
            
            let resultado = jogo.tentativa(card1: cardTentativa1, card2: cardTentativa2)
            print(resultado)
            
            if resultado == RespostaTentativa.ERROU {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                    self.jogo.tempCards[tempCardsKeys[self.indexTentativa1]] = "Card"
                    self.jogo.tempCards[tempCardsKeys[self.indexTentativa2]] = "Card"
                    self.novaTentativa()
                    self.collectionView.reloadData()
                }
            } else if (resultado == RespostaTentativa.ACERTOU) {
                self.novaTentativa()
            } else if (resultado == RespostaTentativa.VENCEU) {
                self.avisarVencedor()
            } else if (resultado == RespostaTentativa.PERDEU){
                self.avisarPerdedor()
            }
            
        }
    }

}

extension ViewController2 {
    
    private func atualizarTela() {
        atualizarImagem()
    }
    
    private func avisarPerdedor() {
        let alerta = UIAlertController(title: "Game over", message: "Exercite sua memória", preferredStyle: .alert)
        alerta.addAction(acao)
        present(alerta, animated: true, completion: nil)
    }
    
    private func avisarVencedor() {
        let alerta = UIAlertController(title: "Boa, você terminou o jogo!", message: "Você precisou de \(self.numeroTentativas) tentativas para finalizar o jogo da memória", preferredStyle: .alert)
        alerta.addAction(acao)
        present(alerta, animated: true, completion: nil)
    }
    
    var acao: UIAlertAction {
        UIAlertAction(title: "Jogar novamente?", style: .default) { _ in
            self.novoJogo()}
    }
    
    private func novaTentativa() {
        self.cardTentativa1 = ""
        self.cardTentativa2 = ""
        self.indexTentativa1 = -1
        self.indexTentativa2 = -1
    }
    
    private func novoJogo() {
        jogo = JogoDaMemoria.aleatorio()
        self.numeroTentativas = 0
        novaTentativa()
        self.isTempCards = true
        self.collectionView.reloadData()

        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            self.isTempCards = false
            self.collectionView.reloadData()
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            self.isTempCards = true
            self.collectionView.reloadData()
        }

        atualizarTela()
    }
    
    private func atualizarImagem () {
        
    }
}
