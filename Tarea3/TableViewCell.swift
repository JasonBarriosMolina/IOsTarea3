//
//  TableViewCell.swift
//  Tarea3
//
//  Created by Jason Barrios on 2/20/19.
//  Copyright © 2019 Jason Barrios. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(book: Books) {
        lblTitle.text = book.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        lblDate.text = formatter.string(from: book.createAt)
    }
    
}
