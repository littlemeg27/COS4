//
//  ReportsTableViewCell.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/23/25.
//

import UIKit

class ReportsTableViewCell: UITableViewCell
{
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var selectedDate: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
