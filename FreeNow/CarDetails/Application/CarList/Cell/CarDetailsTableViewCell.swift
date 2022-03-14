//
//  CarDetailsTableViewCell.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 13/03/22.
//

import UIKit

class CarDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var headingLAbel: UILabel!
    @IBOutlet weak var stateLabe: UILabel!
    @IBOutlet weak var latlongLabel: UILabel!

    var cellModel: CarDetailsTableCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpdata(with model: CarDetailsTableCellViewModel?) {
        self.cellModel = model
        displayData()
    }

    private func displayData() {
        guard let cellModel = cellModel else { return }
        self.idLabel.text = cellModel.carID
        self.typeLabel.text = cellModel.carType
        self.headingLAbel.text = cellModel.heading
        self.stateLabe.text = cellModel.state
        self.stateLabe.textColor = cellModel.stateLabelColor
        self.latlongLabel.text = cellModel.latLong
    }

    class func reuseIdentifier() -> String {
        return String(describing: self).lowercased()
    }
}
