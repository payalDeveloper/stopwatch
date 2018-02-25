//
//  ViewController.swift
//  Stopwatch
//
//  Created by payal on 11/02/18.
//  Copyright © 2018 payal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainTimerHour: UILabel!
    @IBOutlet weak var mainTimerMin: UILabel!
    @IBOutlet weak var mainTimerSec: UILabel!
    
    @IBOutlet weak var smallTimerHour: UILabel!
    @IBOutlet weak var smallTimerMin: UILabel!
    @IBOutlet weak var smallTimerSec: UILabel!
    
    var timer = Timer()
    var subTimer = Timer()
    
    var status = false
    var time  = 00
    var subtime  = 00
    
    var second1 = 00
    var second2 = 00
    
    var minute1 = 00
    var minute2 = 00
    
    var arrayObject = [[Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    func initialSetup(){
        self.startButton.layer.cornerRadius =  0.5 * self.startButton.bounds.width
        self.resetButton.layer.cornerRadius = 0.5 * self.resetButton.bounds.width
        self.startButton.setBackgroundImage(UIImage.init(named: "backgroundImage"), for: .highlighted)
        self.resetButton.setBackgroundImage(UIImage.init(named: "backgroundImage"), for: .highlighted)
        self.startButton.setTitleColor(UIColor.green, for: .normal)
        self.startButton.setTitleColor(UIColor.black, for: .highlighted)
        self.resetButton.setTitleColor(UIColor.black, for: .highlighted)
    }
    
    @IBAction func onClickResetButton(_ sender: Any) {
        if status{
            subTimer.invalidate()
            arrayObject.append([subtime/10 , second2 , minute2])
            arrayObject.reverse()
            self.tableView.reloadData()
            self.resetSubTimer()
            self.lapTimer()
        }else{
            self.resetData()
            timer.invalidate()
            subTimer.invalidate()
            self.resetMainTimer()
            self.resetSubTimer()
            status = false
            arrayObject.removeAll()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onClickStartButton(_ sender: UIButton) {
        if status{
            self.startButton.setTitle("Start", for: .normal)
            self.resetButton.setTitle("Reset", for: .normal)
            self.startButton.setTitleColor(UIColor.green, for: .normal)
            status = false
            timer.invalidate()
            subTimer.invalidate()
        }else {
            status = true
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode:.commonModes)
            self.lapTimer()
            self.resetButton.setTitle("Lap", for: .normal)
            self.startButton.setTitle("Stop", for: .normal)
            self.startButton.setTitleColor(UIColor.red, for: .normal)
        }
    }
    @objc func subTimerUpdate(){
        subtime += 1
        self.smallTimerSec.text = String(format:".%02d",subtime / 10)
        if subtime >= 1000 {
            second2 += 01
            self.smallTimerMin.text = String(format:":%02d",second2)
            if second2 == 60{
                second2 = 00
                minute2 += 01
                self.smallTimerHour.text = String(format:"%02d",minute2)
            }
            subtime = 0
        }
        
    }
    @objc func updateTimer(){
        time += 1
        self.mainTimerSec.text = String(format:".%02d",time / 10)
        if time >= 1000 {
            second1 += 01
            self.mainTimerMin.text = String(format:":%02d",second1)
            if second1 == 60{
                second1 = 00
                minute1 += 01
                self.mainTimerHour.text = String(format:"%02d",minute1)
            }
            time = 0
        }
    }
    func resetMainTimer(){
        self.mainTimerSec.text = ".00"
        self.mainTimerMin.text = ":00"
        self.mainTimerHour.text = "00"

    }
    func resetSubTimer(){
        
        subtime = 00
        second2 = 00
        minute2 = 00
        self.smallTimerSec.text = ".00"
        self.smallTimerMin.text = ":00"
        self.smallTimerHour.text = "00"
    }
    
    func lapTimer(){
        subTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(subTimerUpdate), userInfo: nil, repeats: true)
        RunLoop.current.add(subTimer, forMode:.commonModes)
    }
    
    func resetData(){
        time = 00
        subtime = 00
        second2 = 00
        second1 = 00
        minute2 = 00
        minute1 = 00
    }
    
    
}
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayObject.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell") as! LapTableViewCell
        let currentObject = arrayObject[indexPath.row]
        cell.lapLabel.text = "Lap \(arrayObject.count - indexPath.row)"
        var value = currentObject
        
        cell.cellTimerSecLabel.text = String(format:".%02d",value[0])
        cell.cellTimerMinLabel.text = String(format:":%02d",value[1])
        cell.cellTimerHourLabel.text = String(format:"%02d",value[2])
        return cell
    }
    
}

