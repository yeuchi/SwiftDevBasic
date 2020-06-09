//
//  TableViewController.swift
//  SwiftDevBasic
//
//  Created by yeuchi on 6/8/20.
//  Copyright © 2020 yeuchi. All rights reserved.
//

import UIKit

protocol TableDelegateProtocol {
    func onSelectedFilter(filterType: KernelType)
}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: TableDelegateProtocol? = nil
    
    let filters = [KernelType.Identity,
    KernelType.SobelX,
    KernelType.SobelY,
    KernelType.Sharpen,
    KernelType.Blur,]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filters[indexPath.row])
        
        if self.delegate != nil {
            let dataToBeSent = filters[indexPath.row]
            self.delegate?.onSelectedFilter(filterType: dataToBeSent)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        cell.textLabel?.text = filters[indexPath.row].rawValue
        
        return cell
    }
}
