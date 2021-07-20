//
//  DrawingsViewController.swift
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

import UIKit

@objc protocol DrawingsViewControllerDelegate {
    func drawings(viewController: DrawingsViewController);
}

@objc class DrawingsViewController: UIViewController {
    
   @objc weak var delegate: DrawingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        setupTitle()
        setUpButtons()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.font = UIFont(name: "Montserrat-Regular", size: 17)
        title.text = "Drawings"
        self.navigationItem.titleView = title
    }
    
    private func setupLeftBarButtonItem() {
        let vc = navigationController?.viewControllers.first
        let button = UIBarButtonItem(title: "Artist", style: .plain, target: self, action: #selector(drawings(viewController:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 17.0)!], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 17.0)!], for: .highlighted)
        vc?.navigationItem.backBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLeftBarButtonItem()
    }
    
    private func setUpButtons() {
        let axisX = 88;
        var axisY = 114;
        let buttonTitles = ["Planet", "Head", "Tree", "Landscape"]
        
        for value in buttonTitles {
            let button = DrawingButton(frame: CGRect(x: axisX, y: axisY, width: 200, height: 40))
            axisY += 55
            
            button.setTitle(value, for: .normal)
            
            if (value == UserDefaults.standard.string(forKey: "selected_drawing")) {
                highLight(sender: button);
            }
            
            button.addTarget(self, action: #selector(highLight(sender:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(drawings(viewController:)), for: .touchUpInside)
            
            self.view .addSubview(button)
        }
    }
    
    @objc func highLight(sender: DrawingButton) {
        for case let drawingButton as DrawingButton in self.view.subviews {
            drawingButton.isSelected = false
        }
        
        if (sender.isHighlighted || sender.titleLabel?.text == UserDefaults.standard.string(forKey: "selected_drawing")) {
            sender.isSelected = true
        }
        
        UserDefaults.standard.setValue(sender.titleLabel?.text, forKey: "selected_drawing")
    }
    
//    @objc func saveState(sender: DrawingButton) {
//        let delegate = self.delegate;
//        delegate?.drawings(viewController: self)
//    }
}

extension DrawingsViewController: DrawingsViewControllerDelegate {
    func drawings(viewController: DrawingsViewController) {
        delegate?.drawings(viewController: viewController)
    }
}
