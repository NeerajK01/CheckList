//
//  CkeckListTableViewCell.swift
//  CheckList
//
//  Created by Neeraj kumar on 02/06/19.
//  Copyright © 2019 Neeraj kumar. All rights reserved.
//

import UIKit

class CkeckListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMarkLabel: UILabel!
    @IBOutlet weak var todoTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
