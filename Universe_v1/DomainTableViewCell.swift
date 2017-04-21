//
//  DomainTableViewCell.swift
//  Universe_v1
//
//  Created by Cezar Babin on 4/20/17.
//  Copyright © 2017 Cezar Babin. All rights reserved.
//

import UIKit

class DomainTableViewCell: UITableViewCell {
    
    let FREEBUTTONCOLOR : UIColor = UIColor(red:0.10, green:0.67, blue:0.13, alpha:1.0)
    
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
        if (domainName != nil){
            self.domainNameLabel.text = domainName
        }
        
        if self.domainStatus == .free {
            self.buildFreeCell()
        } else {
            self.buildTakenCell()
        }
    }
    
    func buildFreeCell() {
        self.domainStatusButton?.setTitle("FREE", for: .normal)
        self.domainStatusButton?.tintColor = FREEBUTTONCOLOR
        self.domainStatusButton?.layer.borderColor = FREEBUTTONCOLOR.cgColor
        self.domainStatusButton?.isEnabled = true
        self.domainStatusButton?.layer.cornerRadius = 3
        self.domainStatusButton?.layer.borderWidth = 1
    }
    
    func buildTakenCell() {
        self.domainStatusButton?.setTitle("TAKEN", for: .normal)
        self.domainStatusButton?.isEnabled = false
        //self.domainNameLabel?.isEnabled = false
        self.domainStatusButton?.layer.borderWidth = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
