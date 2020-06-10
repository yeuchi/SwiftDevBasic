# SwiftDevBasic
iOS App Development Basic course project.

## Course
Coursera University of Toronto iOS App Development with Swift Specialization Courses: \
iOS App Development Basics with Professor Parham Aarabi. \
https://www.coursera.org/learn/swift-programming

#### Course Forum 
https://www.coursera.org/learn/ios-app-development-basics/discussions

This is the 2nd course of the series, 3rd repository in Github. \
Previous 2 repositories are as follow. 

1. Swift5ImageProcessor - 1st course - image processing in Swift utilizing RGBA.swift
https://github.com/yeuchi/Swift5ImageProcessor

2. InstaFilter - 2nd course - culmunation of lessons. \
https://github.com/yeuchi/InstaFilterApp

## Course Lesson Functionality
- Default: load given image, Compare button disabled until filter is applied once.
- New: Camera & Album upload image.  Code given by course as starter.

<img width="220" alt="action_Sheet" src="https://user-images.githubusercontent.com/1282659/84277254-e04d6000-aaf8-11ea-8f99-01b7c01ed11f.png"> <img width="220" alt="all_photos" src="https://user-images.githubusercontent.com/1282659/84277265-e3485080-aaf8-11ea-9790-f899e25ca5bd.png"> <img width="220" alt="choose" src="https://user-images.githubusercontent.com/1282659/84277272-e5aaaa80-aaf8-11ea-93cd-cddd5cbe0870.png"> <img width="220" alt="selected" src="https://user-images.githubusercontent.com/1282659/84277280-e93e3180-aaf8-11ea-8456-94fd401a100a.png">

## Functionality
- Upload: default image is available at start.
- Filters: select 1 of 4 types 3x3 kernels (sobel-x derivative, sobel-y derivative, sharpen or blur).
- Edit: use slider to select effect level of above filters (small or large).
- Compare: cross-fade toggle between original and filtered image.
- Quick Compare: touch image to temporarily toggle image; mouse/finger up will revert view.

<img width="220" alt="default" src="https://user-images.githubusercontent.com/1282659/84277524-43d78d80-aaf9-11ea-92d5-ececc4c79256.png"> <img width="220" alt="table" src="https://user-images.githubusercontent.com/1282659/84190093-f48f4f80-aa5b-11ea-8895-48f3282c4953.png"> <img width="220" alt="edit" src="https://user-images.githubusercontent.com/1282659/84167034-53909c80-aa3b-11ea-8dca-afc0a0eac22a.png"> <img width="220" alt="sharpen" src="https://user-images.githubusercontent.com/1282659/84167041-568b8d00-aa3b-11ea-9f5b-c70e41c9cc27.png">

## Effect Level
For Sobel derivative filters, the size of the convolution is actually increased from 1x3 to 3x3. \
For Sharpen and Blur, filters remain 3x3 but the amplitude of the identity differs. \
<img width="220" alt="sharp_less" src="https://user-images.githubusercontent.com/1282659/84204436-d3852980-aa70-11ea-904b-6f9d67d13519.png"> <img width="220" alt="sharp_more" src="https://user-images.githubusercontent.com/1282659/84204439-d54eed00-aa70-11ea-803b-e70b8ef07c2a.png"> <img width="220" alt="sobel_less" src="https://user-images.githubusercontent.com/1282659/84204443-d6801a00-aa70-11ea-9a27-475f3272ab0f.png"> <img width="220" alt="sobel_more" src="https://user-images.githubusercontent.com/1282659/84204451-d849dd80-aa70-11ea-88a2-d706d2d0eb43.png">

## IDE
XCode 11.5 Swift 5.1

## References

1. Passing Data Between View Controllers using Delegate and Protocol for Beginners iOS - Swift 4 by Astitv Nagpal, July 10, 2018
https://medium.com/@astitv96/passing-data-between-view-controllers-using-delegate-and-protocol-ios-swift-4-beginners-e32828862d3f
