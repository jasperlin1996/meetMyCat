//
//  ViewController.swift
//  meetMyCat
//
//  Created by Jasper Lin on 2019/4/8.
//  Copyright © 2019 jasperlin1996. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBOutlet weak var sliderLabel: UILabel!
    @IBAction func getSliderValue(_ sender: UISlider) {
        sliderLabel.text = Int(sender.value).description
    }
    @IBOutlet weak var luckySlider: UISlider!
    
    @IBAction func luckySwitcher(_ sender: UISwitch) {
        if sender.isOn{
            luckySlider.isEnabled = true
        }
        else{
            luckySlider.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -300, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -300, up: false)
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    @IBOutlet weak var selectImage: BgShaper!
    
    @IBAction func changeCat(_ sender: UISegmentedControl) {
        selectImage.changeImage(sender.selectedSegmentIndex)
    }
    @IBOutlet weak var getDateValue: UIDatePicker!
    
    func nothing(){
        
    }
    @IBAction func startPredict(_ sender: UIButton) {
        let date = getDateValue.date.description
        let dateArr = date.components(separatedBy: " ")[0].components(separatedBy: "-")
        
        var sum: Int = Int(sliderLabel.text!) ?? 0
        if luckySlider.isEnabled == false {
            sum = 0
        }
        for index in 0...dateArr.count-1 {
            for digit in dateArr[index] {
                sum += Int(String(digit))!
            }
        }
        let rs = GKMersenneTwisterRandomSource()
        rs.seed = UInt64(sum)
        
        let rd = GKRandomDistribution(randomSource: rs, lowestValue: 0, highestValue: 100)
        let result = rd.nextInt()
        
        let message = (result >= 50) ? "可以喔！ 有\(result)%會成功！" : "先不要... 只有\(result)%會成功"
        
        let alert = UIAlertController(title: "結果是...", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK!", style: .default) { (UIAlertAction) in self.nothing()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

