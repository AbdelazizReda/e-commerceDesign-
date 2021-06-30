//
//  headerView.swift
//  e-commerce layout
//
//  Created by عبدالعزيز رضا  on 6/4/21.
//

import UIKit

class headerView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    var title: String?{
        didSet{
            titleLabel.text = title
            
        }
    }
    
}
