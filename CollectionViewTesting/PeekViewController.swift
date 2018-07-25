//
//  PeekViewController.swift
//  CollectionViewTesting
//
//  Created by Lucas Tavares on 25/07/2018.
//  Copyright © 2018 Lucas Tavares. All rights reserved.
//

import UIKit

class PeekViewController: UIViewController {
    @IBOutlet weak var peekImageView: UIImageView!
    var recievedImage:UIImage?
    var delegate: ControlAnimesDelegate?
    var indexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        peekImageView.image = recievedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func favoritarAnime(_ sender: Any) {
        delegate?.favoritarAnime(at: indexPath!)
    }
    
    @IBAction func excluirAnime(_ sender: Any) {
        delegate?.deletarAnime(at: indexPath!)
    }
}
