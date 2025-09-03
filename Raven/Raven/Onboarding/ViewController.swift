//
//  UIViewController.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//
import UIKit
import SwiftUI

//Define um protocolo para enviar eventos do UIKit para SwiftUI
//protocol UIViewControllerDelegate: AnyObject {
//    //O que eu for por de interação do UIKIT com o SwiftUI devo por aqui dentro. como por exemplo: func botaoClicado()
//    func botaoClicado() //metodo que sera chamado quando o botao for clicado
//}

//UIViewController que será usado dentro do SwiftUI( Tela do UIKit)
class ViewController: UIViewController {
    
    //Delegate é quem vai receber os avisos ( normalmente o Coordinator). Necessario apenas quando preciso se comunicar
    //weak var delegate: UIViewControllerDelegate?
    
    //
    
    
    //Titulo para da pagina de Onboarding
    var TitleText: String = String(localized: "Bem-vindo")
    var labelTitle: UILabel!
    
    //Imagem do centro que representa
    var imageString: String = "person.3.fill"
    var image: UIImageView!
    
    //Texto de intrucao
    var instructionText: String = "Instrução"
    var labelInstruction: UILabel!
    
    //Botao
    let botao = UIButton(type: .system)
    var buttonText: String = "Teste"
    
    //Page Control
    var pageControl: UIPageControl!
    
    //Botao para pular o Onboarding
    let skipButton: UIButton = .init(type: .system)

    
    //Conteudo das telas
    let onboardingPages = [
        (title: "Onboarding.Title.Text", image: "person.3.fill", instruction: "Onboarding.Instruction.Text1"),
        (title: "Onboarding.Title.Text", image: "tray.fill", instruction: "Onboarding.Instruction.Text2"),
        (title: "Onboarding.Title.Text", image: "star.fill", instruction: "Onboarding.Instruction.Text3"),
        (title: "Onboarding.Title.Text", image: "person.3.fill", instruction: "Onboarding.Instruction.Text4"),
        (title: "Onboarding.Title.Text", image: "tray.fill", instruction: "Onboarding.Instruction.Text5")
    ]
    
    //Aqui vai dizer para o PageControl onde ele esta
    var page = 0
    
    
    
    //Metodo chamado quando a tela é carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background" )
        
        //Funcao de Scroll dos lados
        // Swipe para a esquerda
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        // Swipe para a direita
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        
        setupTitleLabel()

        setupImage()

        setupInstructionLabel()
        
        setupButton()
        
        setupPageControl()
 
        
        
        //Posicionar itens na tela
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ancora de Eixo X
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -56), //Ancora de Eixo Y
            image.heightAnchor.constraint(equalToConstant: 136),
            
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Ancora no centro horizontal da tela
            labelTitle.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -120), //Ancora no topo da tela
            
            labelInstruction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelInstruction.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            labelInstruction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelInstruction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: botao.bottomAnchor ,constant: 16),
            
            botao.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botao.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 240),
            botao.widthAnchor.constraint(equalToConstant: 290),
            botao.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        //Listar fontes
//        for family in UIFont.familyNames {
//            print("Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("   Font: \(name)")
//            }
//        }
//        
        //DMSerifText-Regular
        //MozillaHeadlineCondensed-ExtraLight
        updateContent()
        
        
    }
    
    //Titulo da pagina
    func setupTitleLabel() {
        //Titulo para da pagina de Onboarding (Linkado na imagem de centro da tela)
        labelTitle = UILabel()
        labelTitle.text = TitleText
        labelTitle.textColor = UIColor(named: "Title")
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        //Ativando Dynamics Types
        if  let titleFont = UIFont(name: "DMSerifText-Regular", size: 38) {
            labelTitle.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: titleFont)
            labelTitle.adjustsFontForContentSizeCategory = true
        }
        view.addSubview(labelTitle)
        
    }
    
    
    //Imagem do centro
    func setupImage(){
        //Imagem do centro da tela (Ficara no centro da tela como base)
        image = UIImageView()
        image.image = UIImage(systemName: imageString)
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
    }
    
    //Subtitulo
    func setupInstructionLabel(){
        //Texto de instrução (Linkado na parte de baixo da imagem de referencia)
        labelInstruction = UILabel()
        labelInstruction.text = instructionText
        labelInstruction.numberOfLines = 0
        labelInstruction.textAlignment = .center
        labelInstruction.textColor = .white
        labelInstruction.translatesAutoresizingMaskIntoConstraints = false
        
        //Ativando Dynamics Types
        if let instructionFont = UIFont(name: "MozillaHeadlineCondensed-ExtraLight", size: 24){
            labelInstruction.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: instructionFont)
            labelInstruction.adjustsFontForContentSizeCategory = true
        }

        view.addSubview(labelInstruction)
    }
    
    //Botao
    func setupButton(){
        //Criando botao em UIKit
        botao.setTitle("Próximo", for: .normal)
        botao.setTitleColor(UIColor(named: "TipsTextColor"), for: .normal)
        botao.backgroundColor = UIColor(named: "ButtonBackground")
        
        if let shodowColor = UIColor(named: "ButtonBackground"){
            botao.layer.shadowColor = shodowColor.cgColor
            botao.layer.shadowRadius = 8
            botao.layer.shadowOpacity = 1
            botao.layer.shadowOffset = CGSize(width: 2, height: 2)
            botao.layer.cornerRadius = 20
        }

        
        
        //Aqui diz para que quando clicar no botao ele chamar a funcao botaoClicado
        botao.addTarget(self, action: #selector(botaoClicado), for: .touchUpInside)
        
        // Ativando Auto Layout para posicionar o botao. usar os (Contraints)
        botao.translatesAutoresizingMaskIntoConstraints = false
        
        //Ativando Dynamics Types
        if let buttonFont = UIFont(name: "AvenirNext-Regular", size: 17){
            botao.titleLabel?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: buttonFont)
            botao.titleLabel?.adjustsFontForContentSizeCategory = true
        }
        
        //Adiciona o botao a tela
        view.addSubview(botao)
    }
    
    //PageControl
    func setupPageControl(){
        //PageControl
        pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = page
        pageControl.currentPageIndicatorTintColor = UIColor(named: "ButtonBackground")
        pageControl.pageIndicatorTintColor = UIColor(named: "ButtonBackground")?.withAlphaComponent(0.3)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        //O PageControl tem açoes de toque que vem de forma padrao
        //Target para fazer funcionar
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        view.addSubview(pageControl)
    }
    
    
    //Atualiza os conteudo da tela de acordo com a posiçao do vetor de conteudos da tela
    func updateContent(){
        let data = onboardingPages[page]
        labelTitle.text = String(localized: LocalizedStringResource(stringLiteral: data.title))
        image.image = UIImage(systemName: data.image)
        labelInstruction.text = String(localized: LocalizedStringResource(stringLiteral: data.instruction))
        pageControl.currentPage = page
        
        //Para quando trocar e chegar no final do PageControl ele mudar o text
        if page == onboardingPages.count - 1 {
            botao.setTitle(String(localized: LocalizedStringResource(stringLiteral: "Onboarding.Button.Text2")), for: .normal)
        }else{
            botao.setTitle(String(localized: LocalizedStringResource(stringLiteral: "Onboarding.Button.Text1")), for: .normal)
        }
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        page = sender.currentPage
        updateContent()
    }
    
    @objc func botaoClicado() {
        //Aqui ponho as açoes que o botao vai ter
        if page < onboardingPages.count - 1 {
            page += 1
            updateContent()
        } else {
            //navegar para outra tela a partir daqui
            
            //Pega a primeira cena conectada do app
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               //Dentro da cena, pega a primeira janela do app
               let window = scene.windows.first {
                    //Define a nova tela raiz da janela como a ContentView dentro de um UIHostingController
                    //Isso substitui o OnboardingViewController e faz a ContentView ser a tela principal
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    
                    //Garante que a janela fique visível e ativa na tela
                    window.makeKeyAndVisible()
                
                    //TODO: Criar logica de aparecer onBoarding apenas uma vez
                }
           
        }
    }
    
    
    @objc func skipButtonTapped() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           //Dentro da cena, pega a primeira janela do app
           let window = scene.windows.first {
                //Define a nova tela raiz da janela como a ContentView dentro de um UIHostingController
                //Isso substitui o OnboardingViewController e faz a ContentView ser a tela principal
                window.rootViewController = UIHostingController(rootView: ContentView())
                
                //Garante que a janela fique visível e ativa na tela
                window.makeKeyAndVisible()
            }
    }
    
    @objc func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print("Deslizou para a esquerda → Próxima página")
            if page < onboardingPages.count - 1 {
                page += 1
                updateContent()
            }
        } else if gesture.direction == .right {
            print("Deslizou para a direita ← Página anterior")
            if page > 0 {
                page -= 1
                updateContent()
            }
        }
    }
}




