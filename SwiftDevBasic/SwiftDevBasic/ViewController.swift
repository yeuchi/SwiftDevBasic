//
//  ViewController.swift
//  SwiftDevBasic
//
//  Created by yeuchi on 6/7/20.
//  Copyright © 2020 yeuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TableDelegateProtocol {
    
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtSelectedFilter: UILabel!
    
    var image:UIImage?=nil
    var myRGBA:RGBAImage? = nil
    
    /*
     * Delegate Method
     * - execute convolution filter
     */
    func onSelectedFilter(filterType: KernelType) {
        self.txtSelectedFilter.text = filterType.rawValue
        var filterParams = FilterParams()
        filterParams.kernel = filterType
        runInstaFilter(params:filterParams)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "sample")
        imageView.image = image
    }
    
    @IBAction func onClickFilter(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "idTableViewController") as! TableViewController
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickCompare(_ sender: UIButton) {
    }
    
/*
    Part 1 Implement Filter and Compare functions
    1. When a user taps a filter button, the image view should update with the filtered image.

    · Use the RGBAImage class from the course 1 project to get access to the pixels contained in a UIImage object.

    · Employ your filter code from course 1 to filter the selected image.

    2. When a user taps the compare button, the image view should show the original image. When they tap the button again, show the filtered image.

    Part 2 Refine the UI
    1. Disable the compare button when a filter hasn’t been selected.

    · If the user hasn’t selected a filter yet, then the image hasn’t changed, and the compare button isn’t useful. Disable the button when its function is not needed.

    2. Make it easier to compare the original and filtered images.

    · When the user touches the image, toggle between the filtered, and original images temporarily.

    · When the user lifts their finger, toggle back.

    3. Make it more explicit that the user is looking at the original image.

    · Add a small overlay view on top of the image view with the text “Original”. This should only be visible when the user is looking at the original image.

    4. Cross-fade images when a user selects a new filter or uses the compare function.

    · A smoother transition between images gives the app a more refined feel.

    · During the cross-fade you will need to display two images at once. You’ll need to add a second UIImageView on top of the first one, and you can animate the alpha of the top view to show or hide the bottom view.

    5. Use images instead of text for the filter buttons.

    · Choose a small generic image that you can use as an icon for the filter buttons.

    · For each filter button, replace the text with a filtered version of that icon so that the user can see what the effect looks like before they select it.

    · You may not be able to fit as many filter buttons on the screen if you use images, that’s ok, just fit as many as you can.

    6. Add an Edit button.

    ● Add an edit button next to the Filter button in the bottom toolbar. The function of this button is to allow the user to adjust the intensity of the currently applied filter (this button should be disabled until a filter has been selected.)

    ● When the user taps the edit button, hide the filter option list (if visible) and show a UISlider widget instead.

    ● After the user adjusts the slider, the image should be updated with the new filter intensity.

*/
    
    /*
     Part 3 Optional Bonus Challenge – UICollectionView
     With the currently implemented UI, the user can select from several filter options. But this interface has a major limitation: What if you want to offer even more filters, but can’t fit the buttons on the screen?

     It would be nice if we could have a scrolling list of filter buttons. This could fit into our existing layout if the list scrolls horizontally. We covered the UITableView API in this course, but UITableView cells scroll vertically and each cell takes up the entire width of the screen. There is a more advanced API called UICollectionView. A collection view is a more flexible widget than a table view, but it has a very similar API. The biggest addition is that the collection view API allows you to create custom layouts of cells in two dimensions. The bonus challenge is to refactor the filter button list from a stack view, into a horizontally scrolling collection view.

     · For an introduction to the UICollectionView API check out Apple’s video here: https://developer.apple.com/videos/play/wwdc2012-205/ (Note: This video was produced before Swift was released, so the examples are in Objective-C.) · Refer to the Collection View Programming Guide for iOS for a more in-depth introduction: https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html

     ·Take a look at the CollectionView-Simple sample project (Objective-C) on Apple’s iOS documentation site. Keep in mind that this implements a vertically scrolling list with two cells per row, whereas you want a horizontally scrolling list with one cell per column.https://developer.apple.com/library/prerelease/ios/samplecode/CollectionView-Simple/Introduction/Intro.html

     The Collection View API requires you to supply a layout object to manage the layout of cells in the collection view. Apple supplies a built-in class named UICollectionViewFlowLayout. Use this instead of creating your own custom layout class.


     */


    func runInstaFilter(params:FilterParams) {
        
        self.myRGBA = RGBAImage(image:self.image!)!
        let filter = params.getKernelValues()

            // Denominator: find kernel sum
            var denominator = 0
            for cy in 0..<3 {
                for cx in 0..<3 {
                    denominator += filter[cx][cy]
                }
            }
            if(denominator == 0) {
                denominator = 1
            }
            else if (denominator < 0) {
                denominator *= -1
            }

            /*
             * Rubric:
             * Does the playground code apply a filter to each pixel of the image? Maximum of 2 pts
             */
            for y in 0..<self.myRGBA!.height {
                for x in 0..<self.myRGBA!.width {
                    var sumRed = 0
                    var sumGreen = 0
                    var sumBlue = 0
                    
                    // integrate, convolve with kernel (index -1 -> 1)
                    for cy in 0..<3 {
                        for cx in 0..<3 {
                            
                            // constraint pixel index -> in bound
                            var yy = y + cy - 1
                            if(yy < 0){
                                yy = 0
                            }
                            else if (yy >= self.myRGBA!.height) {
                                yy = self.myRGBA!.height-1
                            }
                            
                            var xx = x + cx - 1
                            if(xx < 0){
                                xx = 0
                            }
                            else if (xx >= self.myRGBA!.width) {
                                xx = self.myRGBA!.width-1
                            }
                            
                            // do integration
                            let i = yy * self.myRGBA!.width + xx
                            let pix = self.myRGBA!.pixels[i]
                            sumRed += Int(pix.red) * filter[cx][cy]
                            sumGreen += Int(pix.green) * filter[cx][cy]
                            sumBlue += Int(pix.blue) * filter[cx][cy]
                        }
                    }
                    let ii = y * self.myRGBA!.width + x
                    self.myRGBA!.pixels[ii].red = UInt8(max(0, min(255, sumRed/denominator)))
                    self.myRGBA!.pixels[ii].green = UInt8(max(0, min(255, sumGreen/denominator)))
                    self.myRGBA!.pixels[ii].blue = UInt8(max(0, min(255, sumBlue/denominator)))
                }
            }
            let convolvedImage = self.myRGBA!.toUIImage()
            imageView.image = convolvedImage
            //newImage2
        }
    }
    

