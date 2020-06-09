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
    
    let filters = [ KernelType.Identity,
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
        
        // label
        cell.textLabel?.text = filters[indexPath.row].rawValue
    
        /*
         * Part 2 Refine the UI
         *
         *  5. Use images instead of text for the filter buttons.
         *
         * Choose a small generic image that you can use as an icon for the filter buttons.
         *
         * For each filter button, replace the text with a filtered version of that icon so that the user can see what the effect looks like before they select it.
         *
         * You may not be able to fit as many filter buttons on the screen if you use images, that’s ok, just fit as many as you can.
         */
        let name = filters[indexPath.row].rawValue
        let icon = UIImage(named: name)
        cell.imageView?.image = icon
        return cell
    }
}
