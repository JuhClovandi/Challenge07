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
    
    //Delegate é quem vai receber os avisos ( normalmente o Coordinator). Necessario apenas quando preciso se comunicar 
    //weak var delegate: UIViewControllerDelegate?
    
    //
    
    
    //Titulo para da pagina de Onboarding
    var TitleText: String = "Titulo da tela"
    var labelTitle: UILabel!
    
    //Imagem do centro que representa
    var imageString: String = "person.3.fill"
    var image: UIImageView!
    
    //Texto de intrucao
    var instructionText: String = "Instrução"
    var labelInstruction: UILabel!
    
    //Botao
    let botao = UIButton(type: .system)
    
    //Page Control
    var pageControl: UIPageControl!
    
    //Conteudo das telas
    let onboardingPages = [
        (title: "Bem-vindo", image: "person.3.fill", instruction: "Descubra como usar nosso app."),
        (title: "Organize", image: "tray.fill", instruction: "Guarde tudo em um só lugar."),
        (title: "Aproveite", image: "star.fill", instruction: "Curta a experiência completa!"),
        (title: "Bem-vindo", image: "person.3.fill", instruction: "Descubra como usar nosso app."),
        (title: "Organize", image: "tray.fill", instruction: "Guarde tudo em um só lugar.")
    ]
    
    //Aqui vai dizer para o PageControl onde ele esta
    var currentPage = 0
    
    
    //Metodo chamado quando a tela é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Titulo para da pagina de Onboarding (Linkado na imagem de centro da tela)
        labelTitle = UILabel()
        labelTitle.text = TitleText
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelTitle)
        
        
        //Imagem do centro da tela (Ficara no centro da tela como base)
        image = UIImageView()
        image.image = UIImage(systemName: imageString)
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        
        //Texto de instrução (Linkado na parte de baixo da imagem de referencia)
        labelInstruction = UILabel()
        labelInstruction.text = instructionText
        labelInstruction.textAlignment = .center
        labelInstruction.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelInstruction)
        
        
        //Criando botao em UIKit
       
        botao.setTitle("Próximo", for: .normal)
        
        //Aqui diz para que quando clicar no botao ele chamar a funcao botaoClicado
        botao.addTarget(self, action: #selector(botaoClicado), for: .touchUpInside)
        
        // Ativando Auto Layout para posicionar o botao. usar os (Contraints)
        botao.translatesAutoresizingMaskIntoConstraints = false
        
        //Adiciona o botao a tela
        view.addSubview(botao)
        
        
        //PageControl
        pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = currentPage
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .secondaryLabel
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        //O PageControl tem açoes de toque que vem de forma padrao
        //Target para fazer funcionar
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        view.addSubview(pageControl)
        
        
        //Posicionar itens na tela
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ancora de Eixo X
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor), //Ancora de Eixo Y
            
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ancora no centro horizontal da tela
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32), //Ancora no topo da tela
            
            labelInstruction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelInstruction.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 24),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            botao.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botao.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            
        ])
        
        updateContent()
        
        
    }
    
    //Atualiza os conteudo da tela de acordo com a posiçao do vetor de conteudos da tela
    func updateContent(){
        let data = onboardingPages[currentPage]
        labelTitle.text = data.title
        image.image = UIImage(systemName: data.image)
        labelInstruction.text = data.instruction
        pageControl.currentPage = currentPage
        
        //Para quando trocar e chegar no final do PageControl ele mudar o text 
        if currentPage == onboardingPages.count - 1 {
            botao.setTitle("Concluir", for: .normal)
        }else{
            botao.setTitle("Próximo", for: .normal)
        }
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        currentPage = sender.currentPage
        updateContent()
    }
    
    @objc func botaoClicado() {
        //Aqui ponho as açoes que o botao vai ter
        if currentPage < onboardingPages.count - 1 {
            currentPage += 1
            updateContent()
        } else {
            
            //navegar para outra tela a partir daqui
        }
    }
}


