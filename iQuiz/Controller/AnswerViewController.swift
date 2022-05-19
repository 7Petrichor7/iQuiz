//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/15/22.
//

import UIKit

class AnswerViewController: UIViewController {
    var subject : String = ""
    var question : String = ""
    var answer : String = ""
    var result : String = ""
    var currentQuestionNum = -1
    var totalQuestionNum = 0
    var correctAnswer = 0

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextBtnTouchUpInside(_ sender: Any) {
        if currentQuestionNum == totalQuestionNum - 1 {
            if let resultVC = storyboard?.instantiateViewController(withIdentifier: "resultVC") as? ResultViewController {
                resultVC.correctNum = correctAnswer
                resultVC.totalNum = totalQuestionNum
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
        } else {
            if let quizVC = storyboard?.instantiateViewController(withIdentifier: "quizVC") as? QuestionViewController {
                quizVC.questionIndexClicked = currentQuestionNum + 1
                quizVC.answerSelected = -1
                quizVC.quizTitle = subject
                quizVC.correctNum = correctAnswer
                self.navigationController?.pushViewController(quizVC, animated: true)
            }
        }
    }
    
    @IBAction func backToHomeBtnTouchUpInside(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        questionLabel.text = question
        answerLabel.text = answer
        resultLabel.text = result
        print(correctAnswer)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
