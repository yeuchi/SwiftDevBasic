//
//  TableViewController.swift
//  SwiftDevBasic
//
//  Created by yeuchi on 6/8/20.
//  Copyright © 2020 yeuchi. All rights reserved.
//

import UIKit

protocol TableDelegateProtocol {
    func onEditedFilter(filterType: KernelType, level: EffectLevel)
}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnDone: UIButton!
    var delegate: TableDelegateProtocol? = nil
    var filterType:KernelType = KernelType.Identity
    var effectLevel:EffectLevel = EffectLevel.small
    
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
    
    override func viewDidLayoutSubviews() {
    
    }
    
    @IBAction func onChangeSlider(_ sender: UISlider) {
        if sender.value < 0.5 {
            self.effectLevel = EffectLevel.small
        }
        else {
            self.effectLevel = EffectLevel.large
        }
    }
    
    @IBAction func onClickDone(_ sender: UIButton) {
        if self.delegate != nil {
            let dataToBeSent = self.filterType
            self.delegate?.onEditedFilter(filterType: dataToBeSent, level:self.effectLevel)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filters[indexPath.row])
        filterType = filters[indexPath.row]
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
