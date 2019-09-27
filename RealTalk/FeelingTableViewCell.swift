//
//  FeelingTableViewCell.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/24/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit

class FeelingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    var vc: SignUpVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func click(_ sender: Any) {
        if (button.titleLabel!.text == "Uncheck") {
            button.setTitle("Checked", for: .normal)
            vc!.adjust(op: "Add", item: label.text!)
        }
        else {
            button.setTitle("Unchecked", for: .normal)
            vc!.adjust(op: "Delete", item: label.text!)
        }
    }
    
}
