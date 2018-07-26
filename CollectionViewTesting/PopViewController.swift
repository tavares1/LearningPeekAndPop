//
//  PopViewController.swift
//  CollectionViewTesting
//
//  Created by Ada 2018 on 26/07/2018.
//  Copyright © 2018 Lucas Tavares. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var popImageView: UIImageView!
    var recievedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = recievedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
