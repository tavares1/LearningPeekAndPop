//
//  ViewController.swift
//  CollectionViewTesting
//
//  Created by Lucas Tavares on 25/07/2018.
//  Copyright © 2018 Lucas Tavares. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

    var animes:[UIImage] = [#imageLiteral(resourceName: "deadly"),#imageLiteral(resourceName: "demon"),#imageLiteral(resourceName: "dragonball"),#imageLiteral(resourceName: "kirito"),#imageLiteral(resourceName: "naosei"),#imageLiteral(resourceName: "onepiece"),#imageLiteral(resourceName: "franxx"),#imageLiteral(resourceName: "fate"),#imageLiteral(resourceName: "king"),#imageLiteral(resourceName: "boku"),#imageLiteral(resourceName: "narutotop"),#imageLiteral(resourceName: "x"),#imageLiteral(resourceName: "dark"),#imageLiteral(resourceName: "fullmetal")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestingCollectionViewCell
        cell.imageCollectionView.image = animes[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PeekViewController{
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)?.row
            destination.recievedImage = animes[indexPath!]
            destination.indexPath = collectionView.indexPath(for: cell)
            destination.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:ControlAnimesDelegate{
    func favoritarAnime(at indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.layer.borderColor = UIColor.green.cgColor
            if cell.layer.borderWidth > 0 {
                cell.layer.borderWidth = 0
            } else {
                cell.layer.borderWidth = 10
            }
        }
        self.navigationController?.popViewController(animated: true)
}
    
    func deletarAnime(at indexPath: IndexPath) {
        animes.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        self.navigationController?.popViewController(animated: true)
    }
}

