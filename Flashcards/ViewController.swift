//
//  ViewController.swift
//  Flashcards
//
//  Created by Raey Aweke on 2/15/20.
//  Copyright © 2020 Raey W Aweke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Giving round corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        // Shadow
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.3
        
        // Buttons style
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.4697876429, blue: 0.6162674829, alpha: 1)
        btnOptionOne.layer.cornerRadius = 15
        
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.4697876429, blue: 0.6162674829, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 15.0
        
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.4697876429, blue: 0.6162674829, alpha: 1)
        btnOptionThree.layer.cornerRadius = 15.0
        
    }


    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
        else{
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
        if btnOptionOne.isHidden == false {
            btnOptionOne.isHidden = true
        }
        if btnOptionThree.isHidden == false {
            btnOptionThree.isHidden = true
        }
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
}

