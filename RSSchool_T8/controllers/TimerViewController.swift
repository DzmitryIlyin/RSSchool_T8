//
//  DrawingsViewController.swift
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/17/21.
//

import UIKit

@objc class TimerViewController: UIViewController {
    
    var currentSliderValue: Float = 1.00;
    var sliderValueLabel = UILabel()
    let savedSliderValue = UserDefaults.standard.float(forKey: "current_slider_value")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        setUpButton()
        setUpSlider()
    }
    
    func setUpButton() {
        let saveButton = DrawingButton(frame: CGRect(x: 250.0, y: 20.0, width: 85.0, height: 32.0))
        saveButton.addTarget(self, action: #selector(saveState(_:)), for: .touchUpInside)

        saveButton.setTitle("Save", for: .normal)

        self.view.addSubview(saveButton)
    }
    
    func setUpSlider() {
        currentSliderValue = savedSliderValue >= 1.00 ? savedSliderValue : currentSliderValue
        
        let timerSlider = UISlider(frame: CGRect(x: 74, y: 112, width: 223, height: 4))
        timerSlider.minimumValue = 1.00
        timerSlider.maximumValue = 5.00
        timerSlider.setValue(currentSliderValue, animated: false)
        timerSlider.minimumTrackTintColor = .init(named: "Light Green Sea")
        timerSlider.addTarget(self, action: #selector(handleSlider(_:)), for: .valueChanged)
        
        let minLabel = UILabel(frame: CGRect(x: 26, y: 103, width: 40, height: 22))
        minLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        minLabel.text = "1.00"
        let maxLabel = UILabel(frame: CGRect(x: 318, y: 103, width: 40, height: 22))
        maxLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        maxLabel.text = "5.00"
        
        sliderValueLabel.frame = CGRect(x: 162, y: 161, width: 70, height: 22)
        sliderValueLabel.text = "\(String(format:"%.2f", currentSliderValue))  s"
        
        self.view.addSubview(minLabel)
        self.view.addSubview(maxLabel)
        self.view.addSubview(timerSlider)
        self.view.addSubview(sliderValueLabel)
    }
    
    @objc private func handleSlider(_ slider: UISlider) {
        currentSliderValue = roundf(100 * Float(slider.value)) / 100
        UserDefaults.standard.set(currentSliderValue, forKey: "current_slider_value")
        sliderValueLabel.text = "\(String(format:"%.2f", currentSliderValue))  s"
    }
    
    @objc private func saveState(_ sender: DrawingButton) {
        UserDefaults.standard.setValue(Float(currentSliderValue), forKey: "slider_value")
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
}
