//
//  AddTimeViewController.swift
//  WorkoutTimes
//
//  Created by Jason Philpy on 2/7/21.
//

import UIKit

protocol AddTimeDelegate:class {
    func addingTime(named: String, duration: TimeInterval)
}
class AddTimeViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    weak var delegate:AddTimeDelegate?
    
    public init() {
        super.init(nibName: "AddTimeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func addTime() {
        if nameTextField.text != nil && durationTextField.text != nil && Double(durationTextField.text!) != nil {
            delegate?.addingTime(named: nameTextField.text!, duration: Double(durationTextField.text!)!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }


}
