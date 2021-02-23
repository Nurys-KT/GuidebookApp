//
//  PlaceViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit

class PlaceViewController: UIViewController {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Variables and properties
    var place: Place?
    
    // lazy를 쓰면 이게 실제로 생성될때 computed가 되는데, 실제로 lazy를 안써주면 이게 계산되는 시점이 viewDidLoad 이전이라 self. 를 호출할수가 없음.
    lazy var infoViewController: InfoViewController = {
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.INFO_VIEWCONTROLLER) as! InfoViewController
        return infoVC
    }()
    
    lazy var mapViewController: MapViewController = {
        let mapVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MAP_VIEWCONTROLLER) as! MapViewController
        return mapVC
    }()
    
    lazy var notesViewController: NotesViewController = {
        let notesVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.NOTES_VIEWCONTROLLER) as! NotesViewController
        return notesVC
    }()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let imageName = self.place?.imageName,
              let placeName = self.place?.name else { return }
        
        self.placeImageView.image = UIImage(named: imageName)
        self.placeNameLabel.text = placeName
        
        segmentChanged(self.segmentedControl)
    }

    // MARK: - Methods
    private func switchChildViewControllers(_ childVC: UIViewController) {
        // add it as a child view controller of this one
        addChild(childVC)
        
        // add its view as a subview of the container view
        containerView.addSubview(childVC.view)
        
        // set it's frame and sizing
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // indicate that its now a child view controller
        childVC.didMove(toParent: self)
    }
    
    // sender를 UISegmentedControl로 바꿔줌.
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {      
        switch sender.selectedSegmentIndex {
        case 0:
            infoViewController.place = self.place
            switchChildViewControllers(infoViewController)
        case 1:
            mapViewController.place = self.place
            switchChildViewControllers(mapViewController)
        case 2:
            notesViewController.place = self.place
            switchChildViewControllers(notesViewController)
        default:
            infoViewController.place = self.place
            switchChildViewControllers(infoViewController)
        }
    }
    
}
