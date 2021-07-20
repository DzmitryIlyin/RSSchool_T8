//
//  ButtonLayer.swift
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

import UIKit

class ButtonLayer: CALayer {
    
    override var shadowColor: CGColor?{
        get {
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        }
        set {
            self.shadowColor = newValue
        }
    }
    
    override var shadowOpacity: Float {
        get {
            0.1
        }
        set {
            self.shadowOpacity = newValue
        }
    }
    
    override var shadowOffset: CGSize{
        get {
            .zero
        }
        set {
            self.shadowOffset = newValue
        }
    }
    
    override var shadowRadius: CGFloat{
        get {
            2
        }
        set {
            self.shadowRadius = newValue
        }
    }
    
    override var masksToBounds: Bool{
        get{
            true
        }
        set {
            self.masksToBounds = newValue
        }
    }
    
//    override var backgroundColor: CGColor?{
//        get{
//            UIColor.black.cgColor
//        }
//        set {
//            self.backgroundColor = newValue
//        }
//    }
}
