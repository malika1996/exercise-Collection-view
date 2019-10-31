//
//  SettingsViewController.swift
//  CollectionViewPlay
//
//  Created by vinmac on 27/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

protocol SettingsDataDelegate {
    func setSettingsData(animationSpeed: Double, elementSize: Double, spacingBetweenElements: Double)
}

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var txtAnimationSpeed: UITextField!
    @IBOutlet weak private var txtElementSize: UITextField!
    @IBOutlet weak private var txtSpacing: UITextField!
    
    var delegate: SettingsDataDelegate?
    
    // MARK: IBActions
    @IBAction private func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func btnSaveTapped(_ sender: UIButton) {
        if self.txtAnimationSpeed.text == "" || self.txtElementSize.text == "" || self.txtSpacing.text == "" {
            let alertVC = UIAlertController(title: "Warning", message: "Please fill all the fields first", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
        if let animationSpeed = Double(self.txtAnimationSpeed.text!), let elementSize = Double(self.txtElementSize.text!), let spacing = Double(self.txtSpacing.text!) {
            self.delegate?.setSettingsData(animationSpeed: animationSpeed, elementSize: elementSize, spacingBetweenElements: spacing)
        } else {
            let alertVC = UIAlertController(title: "Warning", message: "Invalid value!!!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
