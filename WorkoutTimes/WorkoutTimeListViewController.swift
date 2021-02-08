//
//  ViewController.swift
//  WorkoutTimes
//
//  Created by Jason Philpy on 2/3/21.
//

import UIKit
import CoreData
import Firebolt

class WorkoutTimeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTimeDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "WTTableViewCell", bundle: nil), forCellReuseIdentifier: "wtcell")
        }
    }
    
    var timesManager: TimesManager
    let resolver = Resolver()
    
    public init(timesManager: TimesManager) {
        self.timesManager = timesManager
        super.init(nibName: "WorkoutTimeListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Workout Times"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTime))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc
    func addNewTime() {
        let addTimeVC = AddTimeViewController()
        addTimeVC.delegate = self
        navigationController?.present(addTimeVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutTime = timesManager.times[indexPath.row]
        let detailVC = WorkoutTimeDetailViewController(workoutTime: workoutTime, timesManager: timesManager)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesManager.times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wtcell", for: indexPath) as! WTTableViewCell
        let time = timesManager.times[indexPath.row]
        cell.nameLabel.text = time.name
        cell.durationLabel.text = "\(time.duration)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            timesManager.removeTime(index: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func addingTime(named: String, duration: TimeInterval) {
        timesManager.addTime(name: named, duration: duration)
        tableView.reloadData()
    }
}

