//
//  ViewController.swift
//  CollectionViewTesting
//
//  Created by Lucas Tavares on 25/07/2018.
//  Copyright © 2018 Lucas Tavares. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    var animes:[UIImage] = [#imageLiteral(resourceName: "deadly"),#imageLiteral(resourceName: "demon"),#imageLiteral(resourceName: "dragonball"),#imageLiteral(resourceName: "kirito"),#imageLiteral(resourceName: "naosei"),#imageLiteral(resourceName: "onepiece"),#imageLiteral(resourceName: "franxx"),#imageLiteral(resourceName: "fate"),#imageLiteral(resourceName: "king"),#imageLiteral(resourceName: "boku"),#imageLiteral(resourceName: "narutotop"),#imageLiteral(resourceName: "x"),#imageLiteral(resourceName: "dark"),#imageLiteral(resourceName: "fullmetal"),#imageLiteral(resourceName: "saitama"),#imageLiteral(resourceName: "sakura"),#imageLiteral(resourceName: "deathnote"),#imageLiteral(resourceName: "bucky")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Número de células que vai ter na collection é definido pela quantidade de UIImages no array animes.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }
    
    // Configurando a célular da CollectionView para utilizar as imagens do array Animes.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestingCollectionViewCell
        cell.imageCollectionView.image = animes[indexPath.row]
        return cell
    }
    
    
    // Passando a imagem por Segue caso a seja clicado, sem o 3D Touch.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PopViewController{
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)?.row
            destination.recievedImage = animes[indexPath!]
        }
    }
    
    // Verificando se o aparelho é compatível com o 3D Touch e registrando a view que será utilizada na pré-visualização..
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView)
        }else{
            print("ins't avaliable")
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Delegate de ControlAnimes, responsável pelos previewActions.
extension ViewController:ControlAnimesDelegate{
    // função recebe o indexPath via delegate, com o indexPath, podemos saber qual a cell e modificamos sua borda para mostrar que a action funciona.
    func favoritarAnime(at indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.layer.borderColor = UIColor.green.cgColor
            if cell.layer.borderWidth > 0 {
                cell.layer.borderWidth = 0
            } else {
                cell.layer.borderWidth = 10
            }
        }
        // Dismiss da peekViewController, pois como é realizada a ação, queremos ver seu resultado.
        self.navigationController?.popViewController(animated: true)
}
    // Removendo o elemento da collectionView
    func deletarAnime(at indexPath: IndexPath) {
        animes.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        // Dismiss da peekViewController, pois como é realizada a ação, queremos ver seu resultado.
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController:UIViewControllerPreviewingDelegate{
    
    // Método responsável pela pré-visualização, nele é retornado qual a viewController será mostrado na pré-visualização.
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // Recebendo indexPath da celula que foi selecionada, e a propia celula
        guard let indexPath = collectionView.indexPathForItem(at: location),
        let cell = collectionView.cellForItem(at: indexPath)
            else {  return nil }
        
        // Praticamente estamos fazendo um prepareToSegue aqui, recebendo a referência da ViewController e passando valores.
        guard let peekViewController = storyboard?.instantiateViewController(withIdentifier: "PeekViewController") as? PeekViewController else{
            return nil
        }
        
        // Inicializando o delegate e passando o indexPath para o peekViewController, possibilitando que os métodos do ControlAnimesDelegate sejam utilizados.
        peekViewController.delegate = self
        peekViewController.indexPath = indexPath
        
        //Setando imagem que será mostrada na pré-visualização.
        peekViewController.recievedImage = animes[indexPath.row]
        
        // Configurando a pre-visualização.
        peekViewController.preferredContentSize = CGSize(width: 0.0, height: 200.0)
        previewingContext.sourceRect = cell.frame

        return peekViewController
    }
    /*
        Função responsável pelo Pop
    */
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        /*A maneira que encontramos de passar a informação para a PopViewController, já que ele não utiliza a segue, é ter uma referência de peekViewController e passar a informação para o PopViewController.
    */
        let peekViewController = viewControllerToCommit as? PeekViewController
       
        // Selecionando a ViewController que ira ser o pop
        guard let popViewController = storyboard?.instantiateViewController(withIdentifier: "PopViewController") as? PopViewController else{
            return
        }
        //Selecionando a imagem para mostrar no pop
        popViewController.recievedImage = peekViewController?.recievedImage
        // mostrando o pop
        show(popViewController, sender: self)
    }
    
    
}

