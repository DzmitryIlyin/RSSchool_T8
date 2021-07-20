//
//  DrawingButton.swift
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

import UIKit

class DrawingButton: UIButton {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
          }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
          }
    
    private func setup() {
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 10
        
        self.setTitleColor(.init(named: "Light Green Sea"), for: .normal)
        self.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    override var isSelected: Bool{
        didSet {
            if oldValue == false && isSelected {
                self.layer.shadowColor = UIColor(named: "Light Green Sea")?.cgColor
            } else if oldValue == true && !isSelected {
                self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            }
        }
    }
    
    override var isHighlighted: Bool{
        didSet {
            if (oldValue == false) && isHighlighted {
                self.layer.shadowColor = UIColor(named: "Light Green Sea")?.cgColor
            } else if oldValue == true && !isSelected {
                self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            }
        }
    }
    
}
