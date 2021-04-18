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
        itemView.layer.cornerRadius = 20.0
        itemView.layer.shadowColor = UIColor.gray.cgColor
        itemView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        itemView.layer.shadowRadius = 6.0
        itemView.layer.shadowOpacity = 0.7
    }
}
