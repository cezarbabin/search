//
//  DomainTableViewCell.swift
//  Universe_v1
//
//  Created by Cezar Babin on 4/20/17.
//  Copyright © 2017 Cezar Babin. All rights reserved.
//

import UIKit

class DomainTableViewCell: UITableViewCell {
    
    enum DomainStatus {
        case free
        case taken
    }
    
    @IBOutlet weak var domainNameLabel: UILabel!
    var domainName : String? {
        didSet {
            self.updateView()
        }
    }
    
    @IBOutlet weak var domainStatusButton: UIButton!
    var domainStatus : DomainStatus = .free {
        didSet {
            self.updateView()
        }
    }
        
    func updateView() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.domainStatus == .free {
            self.domainStatusButton?.setTitle("FREE", for: .normal)
        } else {
            self.domainStatusButton?.setTitle("TAKEN", for: .normal)
        }
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
