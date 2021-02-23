//
//  PlaceCell.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit

class PlaceCell: UITableViewCell {

    // MARK: - property
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style the cell background
        cardView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        placeImageView.image = nil
        placeLabel.text = ""
    }

    // MARK: - Method
    func setCell(_ p: Place) {
        guard let imageName = p.imageName else { return }
        self.placeImageView.image = UIImage(named: imageName)
        self.placeLabel.text = p.name
    }
}
