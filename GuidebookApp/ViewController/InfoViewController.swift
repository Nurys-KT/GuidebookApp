//
//  InfoViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        if place != nil {
            summaryLabel.text = place?.summary
        }
    }

}
