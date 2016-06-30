//
//  BookletTableViewCell.swift
//  toodles
//
//  Created by Susan Madsen on 6/29/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import UIKit

class BookletTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    
    func configureCell(booklet : Booklet){
        lblTitle.text = booklet.title
        lblDescription.text = booklet.description
    }

}
