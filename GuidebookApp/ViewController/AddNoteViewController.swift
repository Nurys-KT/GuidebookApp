//
//  AddNoteViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/21.
//

import UIKit
import CoreData

protocol AddNoteProtocol {
    func noteAdded()
}

class AddNoteViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var noteTextView: UITextView!
    
    var place: Place?
    var notes: [Note] = []
    var delegate: AddNoteProtocol?
    
//    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        // create a new note
        let n = Note(context: context)
        
        // configure the properties
        n.date = Date()
        n.text = noteTextView.text
        n.place = place
        
        // save at core data
//        appDelegate.saveContext()
        do {
            try context.save()
        } catch let error {
            
        }
        
        
        delegate?.noteAdded()
        
        dismiss(animated: true, completion: nil)
    }
    
}
