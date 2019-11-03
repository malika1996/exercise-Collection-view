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
    
    // MARK: Class properties
    private var firstResponder: UITextField?
    var delegate: SettingsDataDelegate?
    var animationSpeed: Double?
    var elementSize: CGFloat?
    var spacing: CGFloat?
    
    // MARK: IBActions
    @IBAction private func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func btnSaveTapped(_ sender: UIButton) {
        if self.txtAnimationSpeed.text == "" || self.txtElementSize.text == "" || self.txtSpacing.text == "" {
            self.showAlert(title: "Warning", message: "Please fill all the fields first")
        }
        if let animationSpeed = Double(self.txtAnimationSpeed.text!), let elementSize = Double(self.txtElementSize.text!), let spacing = Double(self.txtSpacing.text!), Double(self.txtElementSize.text!) != 0 {
            self.delegate?.setSettingsData(animationSpeed: animationSpeed, elementSize: elementSize, spacingBetweenElements: spacing)
        } else {
            self.showAlert(title: "Warning", message: "Invalid value!!!")
        }
    }
    
    @objc private func btnDoneTapped(sender: UIButton) {
        self.firstResponder?.resignFirstResponder()
    }
     
    // MARK: View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstResponder = self.txtAnimationSpeed
        self.txtAnimationSpeed.keyboardType = UIKeyboardType.decimalPad
        self.txtElementSize.keyboardType = UIKeyboardType.decimalPad
        self.txtSpacing.keyboardType = UIKeyboardType.decimalPad
        self.txtAnimationSpeed.delegate = self
        self.txtElementSize.delegate = self
        self.txtSpacing.delegate = self
        self.addToolbarToKeyboard()
        if let animationSpeed = self.animationSpeed, let elementSize = self.elementSize, let spacing = self.spacing {
            self.txtAnimationSpeed.text = "\(animationSpeed)"
            self.txtElementSize.text = "\(elementSize)"
            self.txtSpacing.text = "\(spacing)"
        }
    }
    
    // MARK: Private methods
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let btnDone = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(self.btnDoneTapped(sender:)))
        toolbar.setItems([btnDone], animated: true)
        self.txtAnimationSpeed.inputAccessoryView = toolbar
        self.txtElementSize.inputAccessoryView = toolbar
        self.txtSpacing.inputAccessoryView = toolbar
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        self.firstResponder = textField
    }
}
