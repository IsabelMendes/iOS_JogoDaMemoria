//
//  ViewController.swift
//  JogoDaMemoria
//
//  Created by Isabel Francine Mendes on 12/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func toqueBotaoIniciar(_ sender: Any) {
        performSegue(withIdentifier: "SegueJogo", sender: nil)
    }
}


