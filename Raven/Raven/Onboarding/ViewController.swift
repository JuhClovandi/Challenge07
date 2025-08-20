//
//  UIViewController.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//
import UIKit

//Define um protocolo para enviar eventos do UIKit para SwiftUI
protocol UIViewControllerDelegate: AnyObject {
    //O que eu for por de interação devo por aqui dentro. como por exemplo: func botaoClicado()
    func botaoClicado() //metodo que sera chamado quando o botao for clicado
}

//UIViewController que será usado dentro do SwiftUI( Tela do UIKit)
class ViewController: UIViewController {
    
    //Delegate é quem vai receber os avisos ( normalmente o Coordinator)
    weak var delegate: UIViewControllerDelegate?
    
    //Metodo chamado quando a tela é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Criando botao em UIKit
        let botao = UIButton(type: .system)
        botao.setTitle("Botao UIKit", for: .normal)
        
        //Aqui diz para que quando clicar no botao ele chamar a funcao botaoClicado
        botao.addTarget(self, action: #selector(botaoClicado), for: .touchUpInside)
        
        // Ativando Auto Layout para posicionar o botao. usar os (Contraints)
        botao.translatesAutoresizingMaskIntoConstraints = false
        
        //Adiciona o botao a tela
        view.addSubview(botao)
        
        
        //Para posicionar o botao no meio da tela
        NSLayoutConstraint.activate([
            botao.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ancora de Eixo X
            botao.centerYAnchor.constraint(equalTo: view.centerYAnchor) //Ancora de Eixo Y
        ])
        
    }
    
    @objc func botaoClicado() {
        
        //Aqui ponho as açoes que o botao vai ter
        
        
        //Aqui avisamos o delegate (Coordinator) que o botao foi clicado
        delegate?.botaoClicado()
    }
}


