//
//  ViewController.swift
//  Universe_v1
//
//  Created by Cezar Babin on 4/20/17.
//  Copyright © 2017 Cezar Babin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        DispatchQueue.main.async {
            APIUtil.search(domain: "adler")
        }

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : DomainTableViewCell;

        cell = tableView.dequeueReusableCell(withIdentifier: "DomainCell", for: indexPath) as! DomainTableViewCell
        
        cell.domainName = "adler.com"
        cell.domainStatus = .free
        
        return cell;
    }
}

