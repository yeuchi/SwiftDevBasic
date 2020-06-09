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

## Functionality
- Filters: select 1 of 5 types 3x3 kernels, identity, sobel-x derivative, sobel-y derivative, sharpen or blur.
- Edit: effect level of above filters: small or large.
- Compare: cross-fade toggle between original and filtered image.

<img width="220" alt="original" src="https://user-images.githubusercontent.com/1282659/84190087-f2c58c00-aa5b-11ea-9507-6ed0228a96af.png"> <img width="220" alt="table" src="https://user-images.githubusercontent.com/1282659/84190093-f48f4f80-aa5b-11ea-8895-48f3282c4953.png"> <img width="220" alt="edit" src="https://user-images.githubusercontent.com/1282659/84167034-53909c80-aa3b-11ea-8dca-afc0a0eac22a.png"> <img width="220" alt="sharpen" src="https://user-images.githubusercontent.com/1282659/84167041-568b8d00-aa3b-11ea-9f5b-c70e41c9cc27.png">

## Effect Level
For Sobel derivative filters, the size of the convolution is actually increased from 1x3 to 3x3. \
For Sharpen and Blur, filters remain 3x3 but the amplitude of the identity differs. \
<img width="220" alt="sharp_less" src="https://user-images.githubusercontent.com/1282659/84204436-d3852980-aa70-11ea-904b-6f9d67d13519.png"> <img width="220" alt="sharp_more" src="https://user-images.githubusercontent.com/1282659/84204439-d54eed00-aa70-11ea-803b-e70b8ef07c2a.png"> <img width="220" alt="sobel_less" src="https://user-images.githubusercontent.com/1282659/84204443-d6801a00-aa70-11ea-9a27-475f3272ab0f.png"> <img width="220" alt="sobel_more" src="https://user-images.githubusercontent.com/1282659/84204451-d849dd80-aa70-11ea-88a2-d706d2d0eb43.png">

## IDE
XCode 11.5 Swift 5.1

## References

1. Passing Data Between View Controllers using Delegate and Protocol for Beginners iOS - Swift 4 by Astitv Nagpal, July 10, 2018
https://medium.com/@astitv96/passing-data-between-view-controllers-using-delegate-and-protocol-ios-swift-4-beginners-e32828862d3f
