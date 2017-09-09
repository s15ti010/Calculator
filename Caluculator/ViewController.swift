//
//  ViewController.swift
//  Caluculator
//
//  Created by mizuho on 2017/09/06.
//  Copyright © 2017年 mizuho. All rights reserved.
//デザイン、小数点計算、二回以上の計算、＝後の数値残す,0徐算エラー

import UIKit

enum Operator {
    // 未定義
    case undefined
    // 加法 (+)
    case addition
    // 減法 (-)
    case subtraction
    // 乗法 (×)
    case multiplication
    // 除法 (÷)
    case division
}

class ViewController: UIViewController {

    
    var firstValue:Double = 0
    var secondValue:Double = 0
    var currentOperator = Operator.undefined
    
    var syosu = 0 //１以上で少数位を表す
    var operate = false //演算子
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.backgroundColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        
        // 特定した数値を代入する変数
        var value:Double = 0
        // タップされたボタンを特定する
        switch sender.currentTitle! {
        case "0":
            value = 0
        case "1":
            value = 1
        case "2":
            value = 2
        case "3":
            value = 3
        case "4":
            value = 4
        case "5":
            value = 5
        case "6":
            value = 6
        case "7":
            value = 7
        case "8":
            value = 8
        case "9":
            value = 9
        default:
            value = 0
        }
        
        operate = false
        
        // 演算子が入力される前かどうかを判別
        if currentOperator == .undefined && syosu == 0{
            // 1つ目の数値の1桁目に追加
                firstValue = firstValue * 10 + value
            // ラベルに反映
                label.text = "\(firstValue)"
        }else if currentOperator != .undefined && syosu == 0{
            // 2つ目の数値の1桁目に追加
            secondValue = secondValue * 10 + value
            // ラベルに反映
            switch currentOperator {
            case .addition:
                label.text = "\(firstValue) + \(secondValue)"
            case .subtraction:
                label.text = "\(firstValue) - \(secondValue)"
            case .multiplication:
                label.text = "\(firstValue) × \(secondValue)"
            case .division:
                label.text = "\(firstValue) ÷ \(secondValue)"
            default:
                label.text = "\(firstValue) @ \(secondValue)" //この選択肢になることはない
            }
        }else if currentOperator == .undefined && syosu > 0{
            //1つ目の数値の少数位に追加
            var aaa = 1.0
            for _ in 0...syosu - 1 {
                aaa = aaa / 10
            }
            firstValue = firstValue + value * aaa
            syosu += 1
            //ラベルに反映
            label.text = "\(firstValue)"
        }else if currentOperator != .undefined && syosu > 0{
            //2つ目の数値の少数位に追加            
            var aaa = 1.0
            for _ in 0...syosu - 1 {
                aaa = aaa / 10
            }
            secondValue = secondValue + value * aaa
            syosu += 1
            //ラベルに反映
            switch currentOperator {
            case .addition:
                label.text = "\(firstValue) + \(secondValue)"
            case .subtraction:
                label.text = "\(firstValue) - \(secondValue)"
            case .multiplication:
                label.text = "\(firstValue) × \(secondValue)"
            case .division:
                label.text = "\(firstValue) ÷ \(secondValue)"
            default:
                label.text = "\(firstValue) @ \(secondValue)" //この選択肢になることはない
            }
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        //続けて打てるようにする
        if currentOperator != .undefined && operate == false{
            switch currentOperator{
            case .addition:
                firstValue += secondValue
            case .subtraction:
                firstValue -= secondValue
            case .multiplication:
                firstValue *= secondValue
            case .division:
                if secondValue == 0 {
                        label.text = "0除算Error"
                        firstValue = 0
                        currentOperator = .undefined
                        return
                } else {
                        firstValue /= secondValue
                }
            case .undefined:
                firstValue = 0
            }
            
        }
    
    
            secondValue = 0
        
        // タップされたボタンを特定する
        switch sender.currentTitle! {
        case "+":
            currentOperator = .addition
            label.text = "\(firstValue) + "
        case "-":
            currentOperator = .subtraction
            label.text = "\(firstValue) - "
        case "×":
            currentOperator = .multiplication
            label.text = "\(firstValue) × "
        case "÷":
            currentOperator = .division
            label.text = "\(firstValue) ÷ "
        default:
            currentOperator = .undefined
            label.text = "\(firstValue) ＠ "
        }
        
        syosu = 0 //少数位初期化
        operate = true
        
    }
    
        
        
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        // 演算を行う
        var value:Double = 0
        switch currentOperator {
        case .addition:
            value = firstValue + secondValue
        case .subtraction:
            value = firstValue - secondValue
        case .multiplication:
            value = firstValue * secondValue
        case .division:
            if secondValue == 0 {
                label.text = "0除算Error"
                firstValue = 0
                currentOperator = .undefined
                return
            } else {
                value = firstValue / secondValue
            }
        case .undefined:
            value = firstValue
        }
        // ラベルに反映させる
        label.text = "\(value)"
        // 演算に使用したプロパティを初期化する
        firstValue = value
        secondValue = 0
        currentOperator = .undefined
        syosu = 0//少数位初期化    
        }
    
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        firstValue = 0
        secondValue = 0
        currentOperator = .undefined
        label.text = "0"
        syosu = 0
    }
    
    @IBAction func syosutenButtonTapped(_ sender: UIButton) {
        if syosu == 0{
            syosu = 1
        }
    }
    
    
    @IBAction func CButtonTapped(_ sender: UIButton) {
        
    }
    
  

}
