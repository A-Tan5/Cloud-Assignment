//
//  ViewController.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aIView.isHidden = true
        aIView.stopAnimating()
        nextPageButton.setTitle("下一頁", for: .normal)
    }
    
    
    
    @IBOutlet weak var aIView: UIActivityIndicatorView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    @IBAction func nextPagePressed(_ sender: UIButton) {
        aIView.isHidden = false
        aIView.startAnimating()
        nextPageButton.setTitle("", for: .normal)
    }
    
}

