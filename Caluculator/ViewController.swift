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
    var operate = false //演算子が入力されているか
    var isInput = false //入力が開始されているか
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.backgroundColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        
        // 特定した数値を代入する変数
        var value:Double = 0
        
        // タップされたボタンを特定する
        value = NSString(string: sender.currentTitle!).doubleValue
    
        if isInput {
            //すでに入力が開始されている場合
            label.text! += sender.currentTitle!
        } else {
            //起動後またはAC後、初めての入力の場合
            label.text = sender.currentTitle!
        }
        
        isInput = true
        operate = false
        
        // 演算子が入力される前かどうかを判別
        if currentOperator == .undefined && syosu == 0{
            // 1つ目の数値の1桁目に追加
                firstValue = firstValue * 10 + value
        }else if currentOperator != .undefined && syosu == 0{
            // 2つ目の数値の1桁目に追加
            secondValue = secondValue * 10 + value
        }else if currentOperator == .undefined && syosu > 0{
            //1つ目の数値の少数位に追加
            var digit = 1.0
            for _ in 0...syosu - 1 {
                digit /= 10
            }
            firstValue = firstValue + value * digit
            syosu += 1
        }else if currentOperator != .undefined && syosu > 0{
            //2つ目の数値の少数位に追加
            var digit = 1.0
            for _ in 0...syosu - 1 {
                digit /= 10
            }
            secondValue = secondValue + value * digit
            syosu += 1
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
            label.text! += " + "
        case "-":
            currentOperator = .subtraction
            label.text! += " - "
        case "×":
            currentOperator = .multiplication
            label.text! += " × "
        case "÷":
            currentOperator = .division
            label.text! += " ÷ "
        default:
            currentOperator = .undefined
            label.text! += " ＠ "
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
                label.text = "0除算Error"                     //error後に続いてしまうAC押せばok
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
        label.text = "\(value)"            //演算結果代入
        
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
        
        isInput = false
    }
    
    @IBAction func syosutenButtonTapped(_ sender: UIButton) {
       
        if syosu == 0{
            syosu = 1
            label.text = label.text! + "."                       //ifの中に入れた
        }
    }
    
    
    @IBAction func CButtonTapped(_ sender: UIButton) {
       
        if currentOperator == .undefined{
            firstValue = 0
            label.text = "\(firstValue)"
        }else{
            currentOperator = .undefined
            secondValue = 0
            label.text  = "\(firstValue)"
        }
        
    }
    
  

}
