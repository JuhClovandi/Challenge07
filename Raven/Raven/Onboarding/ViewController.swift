//
//  UIViewController.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//
import UIKit
import SwiftUI

//UIViewController que será usado dentro do SwiftUI (Tela do UIKit)
class ViewController: UIViewController {
    
    //PageViewController que vai gerenciar as telas do Onboarding
    var pageViewController: UIPageViewController!
    
    //PageControl para mostrar em qual página estamos
    var pageControl: UIPageControl!
    
    //Botao para avançar para a próxima tela
    let botao = UIButton(type: .system)
    
    
    //Conteudo das telas
    let onboardingPages = [
        (image: "person.3.fill", instruction: "Onboarding.Instruction.Text1"),
        (image: "tray.fill", instruction: "Onboarding.Instruction.Text2"),
        (image: "star.fill", instruction: "Onboarding.Instruction.Text3"),
        (image: "person.3.fill", instruction: "Onboarding.Instruction.Text4"),
        (image: "tray.fill", instruction: "Onboarding.Instruction.Text5")
    ]
    
    //Armazena as páginas criadas
    var pages: [OnboardingPage] = []
    
    //Indice atual da página
    var page = 0
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        setupPages()        //Cria cada página do Onboarding
        setupPageViewController() //Configura o PageViewController
        setupPageControl()  //Configura o PageControl
        setupButton()       //Configura botão Próximo
        setupTitle()
        
    }
    
    func updateButtonTitle(page: Int) {
        
        if page == pages.count - 1 {
            botao.setTitle(String(localized: LocalizedStringResource(stringLiteral: "Onboarding.Button.Text2")), for: .normal)
        } else {
            botao.setTitle(String(localized: LocalizedStringResource(stringLiteral: "Onboarding.Button.Text1")), for: .normal)
        }
    }
    
    //MARK: - Cria páginas individuais
    func setupPages() {
        pages = onboardingPages.enumerated().map { index, data in
            let pageVC = OnboardingPage()
            pageVC.pageIndex = index
            pageVC.imageName = data.image
            pageVC.instructionText = String(localized: LocalizedStringResource(stringLiteral: data.instruction))

            
            return pageVC
        }
    }
    
    //MARK: - Configura PageViewController
    func setupPageViewController() {
        //Cria PageViewController com swipe horizontal
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        //Define a primeira página
        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        //Adiciona como filho
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        //Faz PageViewController ocupar toda a tela
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: - Configura PageControl
    func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = page
        pageControl.currentPageIndicatorTintColor = UIColor(named: "ButtonBackground")
        pageControl.pageIndicatorTintColor = UIColor(named: "ButtonBackground")?.withAlphaComponent(0.3)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //Ação para clicar nas bolinhas (opcional)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    //MARK: - Configura o titulo
    func setupTitle() {
        //Titulo da página
        let labelTitle = UILabel()
        labelTitle.text = String(localized: LocalizedStringResource(stringLiteral: "Onboarding.Title.Text"))
        labelTitle.textAlignment = .center
        labelTitle.textColor = UIColor(named: "Title")
        labelTitle.font = UIFont(name: "DMSerifText-Regular", size: 38)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        ])
        
    }
    
    //MARK: - Configura botão Próximo
    func setupButton() {
        updateButtonTitle(page: page)
        botao.setTitleColor(UIColor(named: "TipsTextColor"), for: .normal)
        botao.backgroundColor = UIColor(named: "ButtonBackground")
        botao.layer.cornerRadius = 20
        botao.layer.shadowColor = UIColor(named: "ButtonBackground")?.cgColor
        botao.layer.shadowRadius = 4
        botao.layer.shadowOpacity = 1
        botao.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        botao.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        botao.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(botao)
        
        NSLayoutConstraint.activate([
            botao.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botao.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            botao.widthAnchor.constraint(equalToConstant: 290),
            botao.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: - Botão Próximo
    @objc func nextButtonTapped() {
        //Animação do botão
        animateButton(botao)
        
        //Vibração
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
 
        if page < pages.count - 1 {
            //Avança para próxima página
            page += 1
            let nextVC = pages[page]
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = page
            updateButtonTitle(page: page)
        } else {
            //Mudar quando for subir 
//            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            //Chegou no final → navegar para ContentView
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {

                let contentView = UIHostingController(rootView: ContentView())
                
                contentView.view.frame = window.bounds.offsetBy(dx: window.bounds.width, dy: 0)
                window.addSubview(contentView.view)
                
                UIView.animate(withDuration: 0.5, animations: {
                    contentView.view.frame = window.bounds
                    window.rootViewController?.view.frame = window.bounds.offsetBy(dx: -window.bounds.width, dy: 0)
                }, completion: { _ in
                    window.rootViewController = contentView
                })
            }
        }
                
    }
    
    //MARK: - PageControl clicado (opcional)
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        let direction: UIPageViewController.NavigationDirection = selectedPage > page ? .forward : .reverse
        page = selectedPage
        updateButtonTitle(page: page)
        pageViewController.setViewControllers([pages[page]], direction: direction, animated: true, completion: nil)
    }
    
    //MARK: - Animação do botão
    fileprivate func animateButton(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                viewToAnimate.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}

//MARK: - PageViewController DataSource e Delegate
extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    //Volta uma página
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingPage else { return nil }
        let previousIndex = vc.pageIndex - 1
        return previousIndex >= 0 ? pages[previousIndex] : nil
    }
    
    //Vai para próxima página
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingPage else { return nil }
        let nextIndex = vc.pageIndex + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }
    
    //Atualiza PageControl após swipe
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first as? OnboardingPage {
            page = currentVC.pageIndex
            pageControl.currentPage = page
            updateButtonTitle(page: page)
            
        }
    }
}

//MARK: - Tela individual do Onboarding
class OnboardingPage: UIViewController {
    var pageIndex: Int = 0
    var imageName: String = ""
    var instructionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        //Imagem central
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Texto de instrução
        let labelInstruction = UILabel()
        labelInstruction.text = instructionText
        labelInstruction.textAlignment = .center
        labelInstruction.numberOfLines = 0
        labelInstruction.textColor = .white
        labelInstruction.font = UIFont(name: "MozillaHeadlineCondensed-ExtraLight", size: 24)
        labelInstruction.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(imageView)
        view.addSubview(labelInstruction)
        
        //Constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imageView.heightAnchor.constraint(equalToConstant: 136),
            
            labelInstruction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelInstruction.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            labelInstruction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelInstruction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
