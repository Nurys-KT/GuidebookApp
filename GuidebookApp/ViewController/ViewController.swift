//
//  ViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        let selectedPlace = self.places[index.row]
        let placeVC = segue.destination as! PlaceViewController
        placeVC.place = selectedPlace
    }
    
    func fetchData() {
        do {
            self.places = try context.fetch(Place.fetchRequest())
        } catch let error {
            print("error --> \(error.localizedDescription)")
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.PLACE_CELL, for: indexPath) as? PlaceCell else { return UITableViewCell() }
        
        let place = places[indexPath.row]
        cell.setCell(place)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
