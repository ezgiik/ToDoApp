//
//  TasksCell.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import UIKit

class TasksCell: UITableViewCell {

    @IBOutlet weak var labelTaskDesc: UILabel!
    @IBOutlet weak var labelTaskDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
