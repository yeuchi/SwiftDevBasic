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

/*
 Part 3 Optional Bonus Challenge – UICollectionView
 With the currently implemented UI, the user can select from several filter options. But this interface has a major limitation: What if you want to offer even more filters, but can’t fit the buttons on the screen?

 It would be nice if we could have a scrolling list of filter buttons. This could fit into our existing layout if the list scrolls horizontally. We covered the UITableView API in this course, but UITableView cells scroll vertically and each cell takes up the entire width of the screen. There is a more advanced API called UICollectionView. A collection view is a more flexible widget than a table view, but it has a very similar API. The biggest addition is that the collection view API allows you to create custom layouts of cells in two dimensions. The bonus challenge is to refactor the filter button list from a stack view, into a horizontally scrolling collection view.

 · For an introduction to the UICollectionView API check out Apple’s video here: https://developer.apple.com/videos/play/wwdc2012-205/ (Note: This video was produced before Swift was released, so the examples are in Objective-C.) · Refer to the Collection View Programming Guide for iOS for a more in-depth introduction: https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html

 ·Take a look at the CollectionView-Simple sample project (Objective-C) on Apple’s iOS documentation site. Keep in mind that this implements a vertically scrolling list with two cells per row, whereas you want a horizontally scrolling list with one cell per column.https://developer.apple.com/library/prerelease/ios/samplecode/CollectionView-Simple/Introduction/Intro.html

 The Collection View API requires you to supply a layout object to manage the layout of cells in the collection view. Apple supplies a built-in class named UICollectionViewFlowLayout. Use this instead of creating your own custom layout class.


 */
