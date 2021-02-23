//
//  NotesViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var place: Place?
    var notes: [Note] = []
    
//    var fetchedNotesRC: NSFetchedResultsController<Note>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }

    func refresh() {
        // check if there's a place set
        if let place = place {
            
            // get a fetch request for places
//            let request: NSFetchRequest<Note> = Note.fetchRequest()
            let request = Note.fetchRequest() as NSFetchRequest<Note>
            request.predicate = NSPredicate(format: "place = %@", place)
            
            // set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            do {
                // create a fetched request result controller
//                fetchedNotesRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
                
                // excute the fetch
//                try fetchedNotesRC!.performFetch()
                
                self.notes = try context.fetch(request)
                
            } catch let error {
                print("error --> \(error.localizedDescription)")
            }
        }
        
        // tell table view to request data
        tableView.reloadData()
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        // Display popup
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ADDNOTES_VIEWCONTROLLER) as! AddNoteViewController
        
        // set self as delegate so we can get notified of a new note being added
        addNoteVC.delegate = self
        
        // pass the place object through
        addNoteVC.place = self.place
        
        // configure the popup mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        // present it
        present(addNoteVC, animated: true, completion: nil)
    }
    
}

extension NotesViewController: AddNoteProtocol {
    func noteAdded() {
        refresh()
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedNotesRC?.fetchedObjects?.count ?? 0
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.NOTE_CELL, for: indexPath)
        
        let dateLabel = cell.viewWithTag(1) as! UILabel
        let noteLabel = cell.viewWithTag(2) as! UILabel
        
//        guard let note = fetchedNotesRC?.object(at: indexPath) else { return UITableViewCell() }
        if notes != nil {
            let note = notes[indexPath.row]
            
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "MMM d, yyyy - h:mm a"
            
            dateLabel.text = dateFomatter.string(from: note.date!)
            noteLabel.text = note.text
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
//            guard let n = self.fetchedNotesRC?.object(at: indexPath) else { return }
            let n = self.notes[indexPath.row]
            self.context.delete(n)
//            self.appDelegate.saveContext()
            do {
                try self.context.save()
            } catch let error {
                //
            }
            
            self.refresh()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension NotesViewController: UITableViewDelegate {
}
