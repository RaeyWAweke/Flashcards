//
//  ViewController.swift
//  Flashcards
//
//  Created by Raey Aweke on 2/15/20.
//  Copyright © 2020 Raey W Aweke. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAnsOne: String?
    var extraAnsTwo: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Read saved Flashcards
         readSavedFlashcards()
        
        // Adding out initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Ethiopia?", answer: "Addis Ababa", extraAnswerOne: "Harare", extraAnswerTwo: "Accra", isExisting: false)
            }
            else {
                updateLabels()
                updateNextPrevButtons()
            }
        
        frontLabel.isHidden = false
        
        // Giving round corners
        card.layer.cornerRadius = 20
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        // Shadow
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.3
        
        // Buttons style
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.3518724144, green: 0.8151190877, blue: 1, alpha: 1)
        btnOptionOne.layer.cornerRadius = 20
        
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.3518724144, green: 0.8151190877, blue: 1, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 20.0
        
        
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.3518724144, green: 0.8151190877, blue: 1, alpha: 1)
        btnOptionThree.layer.cornerRadius = 20.0
        
    }


    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard() {
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if(self.frontLabel.isHidden == true){
                self.frontLabel.isHidden = false
            }
            else{
                self.frontLabel.isHidden = true
            }
        })
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnsOne: extraAnswerOne, extraAnsTwo: extraAnswerTwo)
        
        if isExisting {
            // Replace current flashcard
            flashcards[currentIndex] = flashcard
        } else {
        
            // adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            // logging to console
            print("😎 Added new flashcard")
            print("😎 We now have \(flashcards.count) flashcards")
            
            // update current index
            currentIndex = flashcards.count - 1
            print("😎 Our current index is \(currentIndex)")
        }
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
        
        // save flashcards
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isEnabled = false
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7464932799, green: 0.7466199994, blue: 0.7464765906, alpha: 1)
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
        if btnOptionOne.isEnabled == true {
            btnOptionOne.isEnabled = false
            btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7464932799, green: 0.7466199994, blue: 0.7464765906, alpha: 1)
        }
        if btnOptionThree.isEnabled == true {
            btnOptionThree.isEnabled = false
            btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7464932799, green: 0.7466199994, blue: 0.7464765906, alpha: 1)
        }
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isEnabled = false
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7464932799, green: 0.7466199994, blue: 0.7464765906, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        }
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        // decrease current index
        currentIndex -= 1
        
        // update labels
        //updateLabels()
        
        // update next and prev buttons
        updateNextPrevButtons()
        
        animateCardOutPrev()
        resetOptions()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        // increase current index
        currentIndex += 1
        
        // update next and prev buttons
        updateNextPrevButtons()
        
        animateCardOut()
        resetOptions()
    }
    
    func updateNextPrevButtons() {
        
        // disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // disable prev button if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        btnOptionOne.setTitle(currentFlashcard.extraAnsOne, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.extraAnsTwo, for: .normal)
    }
    
    func saveAllFlashcardsToDisk() {
        
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question":card.question, "answer":card.answer, "extraAnsOne":card.extraAnsOne ?? "Brasilia", "extraAnsTwo":card.extraAnsTwo ?? "Accra"]
        }
        
        // save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log it
        print("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        
        // read dictionary array form disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnsOne: dictionary["extraAnsOne"], extraAnsTwo: dictionary["extraAnsTwo"])
            }
            
            // put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
            print("😎 \(flashcards.count) flashcards read from memory")
        }
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        // show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete the flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard() {
        
        // Delete current
        flashcards.remove(at: currentIndex)
        
        // Special case: Check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        if currentIndex == -1 {
            frontLabel.text = ""
            backLabel.text = ""
            
            btnOptionOne.setTitle("", for: .normal)
            btnOptionTwo.setTitle("", for: .normal)
            btnOptionThree.setTitle("", for: .normal)
        }
        else {
            updateNextPrevButtons()
            updateLabels()
            saveAllFlashcardsToDisk()
        }
        
        print("😎 Current number of flashcards: \(flashcards.count)")
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        }, completion: { finished in
            
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        
        // Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        
        // Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrev() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        }, completion: { finished in
            
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev() {
        
        // Start on the left side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        
        // Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func resetOptions() {
        btnOptionThree.isEnabled = true
        btnOptionOne.isEnabled = true
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.3518724144, green: 0.8151190877, blue: 1, alpha: 1)
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.3518724144, green: 0.8151190877, blue: 1, alpha: 1)
    }
}

