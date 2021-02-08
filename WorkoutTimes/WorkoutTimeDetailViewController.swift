//
//  WorkoutTimeDetailViewController.swift
//  WorkoutTimes
//
//  Created by Jason Philpy on 2/7/21.
//

import UIKit

class WorkoutTimeDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationTextField: UITextField! {
        didSet {
            durationTextField.delegate = self
        }
    }
    
    var workoutTime:WorkoutTime
    var timesManager: TimesManager
    
    public init(workoutTime: WorkoutTime, timesManager: TimesManager) {
        self.workoutTime = workoutTime
        self.timesManager = timesManager
        super.init(nibName: "WorkoutTimeDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Time Details"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        nameLabel.text = workoutTime.name
        durationTextField.text = "\(workoutTime.duration)"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil && Double(textField.text!) != nil {
            workoutTime.duration = Double(textField.text!)!
            timesManager.dbManager.save()
        }
    }


}
