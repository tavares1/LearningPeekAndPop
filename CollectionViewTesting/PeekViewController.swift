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
    
    /*  Como PeekViewContoller foi registrado como pre-visualização podemos escrever previewActionItens aqui.
     Escrevemos ações de dar like e apagar anime do array visualizado. e retirnamos ele para a view
 */
    override var previewActionItems: [UIPreviewActionItem]{
        
        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) -> Void in
            self.delegate?.favoritarAnime(at: self.indexPath!)
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
            self.delegate?.deletarAnime(at: self.indexPath!)
        }
        
        return [likeAction, deleteAction]
    }
}
