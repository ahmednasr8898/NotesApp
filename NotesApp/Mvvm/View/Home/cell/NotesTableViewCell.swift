//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
