//
//  ViewController.swift
//  SwiftDevBasic
//
//  Created by yeuchi on 6/7/20.
//  Copyright © 2020 yeuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TableDelegateProtocol {
    
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnFilter: UIButton!

    @IBOutlet weak var imageContainer: UIView!
    
    @IBOutlet weak var imageViewFiltered: UIImageView!
    @IBOutlet weak var imageViewSource: UIImageView!
    @IBOutlet weak var txtSelectedFilter: UILabel!
    @IBOutlet weak var txtSelectedLevel: UILabel!
    @IBOutlet var effectView: UIView!
    @IBOutlet weak var txtOriginal: UILabel!
    
    var image:UIImage?=nil
    var myRGBA:RGBAImage? = nil
    var params:FilterParams = FilterParams()
    var state:ViewState = ViewState.Source
 
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "Identity")
        imageViewSource.image = image
        
        /*
         * imageView touch event
         */
        var tap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.onTouchImage))
        tap.minimumPressDuration = 0
        imageViewSource.addGestureRecognizer(tap)
        imageViewSource.isUserInteractionEnabled = true
        
        self.imageViewFiltered.alpha = 0.0
        
        /*
         * effect level pop-up
         */
        self.effectView.backgroundColor = UIColor.lightGray
        self.effectView.translatesAutoresizingMaskIntoConstraints = false
        
        /*
         * 1. Disable the compare button when a filter hasn’t been selected.
         *
         * If the user hasn’t selected a filter yet, then the image hasn’t changed,
         * and the compare button isn’t useful. Disable the button when its function is not needed.
         */
        btnCompare.isEnabled = false
    }
    
    /*
     * Part 2
     * 2. Make it easier to compare the original and filtered images.
     *
     * When the user touches the image, toggle between the filtered, and original images temporarily.
     *
     * When the user lifts their finger, toggle back.
     */
    @objc func onTouchImage(gesture: UITapGestureRecognizer) {
        
        switch (gesture.state) {
        case UIGestureRecognizerState.began:
            changeImageState()
        
        case UIGestureRecognizerState.ended:
            changeImageState()
         
        //case UIGestureRecognizerState.changed:
        //case UIGestureRecognizerState.cancelled:
        //
        default:
            return
        }
    }
    
    /*
     * Part 1
     *
     * 1. When a user taps a filter button, the image view should update with the filtered image.
     * Use the RGBAImage class from the course 1 project to get access to the pixels contained in a UIImage object.
     * Employ your filter code from course 1 to filter the selected image.
     */
    @IBAction func onClickFilter(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "idTableViewController") as! TableViewController
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
        btnCompare.isEnabled = true
    }
    
    /*
     * Delegate Method
     * - execute convolution filter
     */
    func onSelectedFilter(filterType: KernelType) {
        self.txtSelectedFilter.text = filterType.rawValue
        self.params.kernel = filterType
        applyFilter()
    }
       
    @IBAction func onEditLevel(_ sender: UISlider) {
        if sender.value < 0.5 {
            self.params.effectLevel = EffectLevel.Small
        }
        else {
            self.params.effectLevel = EffectLevel.Large
        }
        
        self.txtSelectedLevel.text = self.params.effectLevel.rawValue
        applyFilter()
    }
    
    func applyFilter() {
        runInstaFilter(params: self.params)
        self.state = ViewState.Filtered
        self.imageViewSource.alpha = 0.0
        self.imageViewFiltered.alpha = 1.0
    }
       
    @IBAction func onClickSelected(_ sender: UIButton) {
        hideEffectLevel()
    }
    
    /*
     * Part 2 Refine the UI
     * 6. Add an Edit button.
     *
     *  ● Add an edit button next to the Filter button in the bottom toolbar.
     *    The function of this button is to allow the user to adjust the intensity of the currently applied filter (this button should be disabled until a filter has been selected.)
     *
     *  ● When the user taps the edit button, hide the filter option list (if visible) and show a UISlider widget instead.
     *
     *  ● After the user adjusts the slider, the image should be updated with the new filter intensity.
     */
    @IBAction func onClickEdit(_ sender: UIButton) {
        showEffectLevel()
    }
    
    func showEffectLevel() {
        self.viewMain.addSubview(self.effectView)
        
        let topAnchor = effectView.topAnchor.constraint(equalTo: imageContainer.topAnchor)
         
         let leftConstraint = effectView.leftAnchor.constraint(equalTo: viewMain.leftAnchor)
         
         let rightConstraint = effectView.rightAnchor.constraint(equalTo: viewMain.rightAnchor)
         
         let heightConstraint = effectView.heightAnchor.constraint(lessThanOrEqualToConstant: 130)
         
         NSLayoutConstraint.activate([leftConstraint, rightConstraint, topAnchor, heightConstraint])
        
        self.viewMain.layoutIfNeeded()
        
        effectView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.effectView.alpha = 1
        }
    }
    
    func hideEffectLevel() {
        UIView.animate(withDuration: 1, animations: {
            self.effectView.alpha = 0
        }) {completed in
            if completed == true {
                self.effectView.removeFromSuperview()
            }
        }
    }
    
    /*
     * Part 1 Implement Filter and Compare functions
     *
     * 2. When a user taps the compare button, the image view should show the original image.
     * When they tap the button again, show the filtered image.
     *
     * Part 2
     * - this button is not visible until user selects filter.
     */
    @IBAction func onClickCompare(_ sender: UIButton) {
        changeImageState()
    }
    
    /*
     * Part 2
     * 3. Make it more explicit that the user is looking at the original image.
     *
     * Add a small overlay view on top of the image view with the text “Original”.
     * This should only be visible when the user is looking at the original image.
     *
     * 4. Cross-fade images when a user selects a new filter or uses the compare function.
     *
     * A smoother transition between images gives the app a more refined feel.
     *
     * During the cross-fade you will need to display two images at once.
     * You’ll need to add a second UIImageView on top of the first one,
     * and you can animate the alpha of the top view to show or hide the bottom view.
     */
    func changeImageState() {
        var sourceAlpha:CGFloat = 1.0
        var filteredAlpha:CGFloat = 0.0
        
        //var toImage = self.image
        if(btnCompare.isEnabled) {
            if(self.state == ViewState.Filtered) {
               // self.imageViewSource.image = self.image
                self.state = ViewState.Source
            }
            else {
              //  self.imageView.image = self.convolvedImage
                self.state = ViewState.Filtered
                
                sourceAlpha = 0.0
                filteredAlpha = 1.0
            }
            
            UIView.animate(withDuration: 1.5) {
                self.imageViewFiltered.alpha = filteredAlpha
                self.imageViewSource.alpha = sourceAlpha
                self.txtOriginal.alpha = sourceAlpha
            }
        }
    }

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
            self.imageViewFiltered.image = self.myRGBA!.toUIImage()
        }
    }
    

