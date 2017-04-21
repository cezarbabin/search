//
//  ViewController.swift
//  Universe_v1
//
//  Created by Cezar Babin on 4/20/17.
//  Copyright © 2017 Cezar Babin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ROWPADDING : CGFloat = 20.0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            print ("pressed search")
            self.textField.delegate = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.isHidden = true
        }
    }
    
    var domains : [[String : Any]]? {
        didSet {
            self.updateView()
        }
    }
    
    var loading : Bool = false {
        didSet {
            if self.loading {
                self.tableView.isHidden = true
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.tableView.isHidden = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
    func updateView() {
        self.tableView.reloadData()
        self.loading = false
        if self.domains != nil {
            let count = self.domains!.count
            if count == 0 {
                self.tableView.isHidden = true
            }
        } else {
            self.tableView.isHidden = true
        }
        
    }
    
    func search() {
        self.loading = true
        let query : String? = self.textField.text
        if (query != nil) {
            DispatchQueue.main.async {
                APIUtil.search(domain: query!) { (error, result) in
                    if error == nil {
                        print ("Request returned");
                        let domains = result
                        self.domains = result
                        for domain in domains! {
                            //let domainName = domain["name"]
                            //print (domain["summary"] ?? "unclear")
                        }
                    }
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return ROWPADDING }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = .clear
        return headerView
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.domains != nil ? self.domains!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : DomainTableViewCell

        cell = tableView.dequeueReusableCell(withIdentifier: "DomainCell", for: indexPath) as! DomainTableViewCell
        
        // TODO: need to check if domain is null 
        let domain : [String : Any]? = self.domains?[indexPath.row]
        
        // TODO: need to check if domain name is null for some reason
        cell.domainName = domain?["domain"] as? String
        
        // TODO: need to check if domain status is null for some reason
        let domainSummary = domain?["summary"] as? String
        if domainSummary == "inactive" {
            cell.domainStatus = .free
        } else {
            cell.domainStatus = .taken
        }
            
        return cell;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search()
        return true
    }
}

