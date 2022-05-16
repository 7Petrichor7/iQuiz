//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/15/22.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var quizTitle = ""
    var questionIndexClicked = 0
    var answerSelected = -1
    var correctNum = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func optionButtonTouchUpInside(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                answerSelected = 0
                answerA.isSelected = true
                answerB.isSelected = false
                answerC.isSelected = false
                answerD.isSelected = false
            case 2:
                answerSelected = 1
                answerA.isSelected = false
                answerB.isSelected = true
                answerC.isSelected = false
                answerD.isSelected = false
            case 3:
                answerSelected = 2
                answerA.isSelected = false
                answerB.isSelected = false
                answerC.isSelected = true
                answerD.isSelected = false
            case 4:
                answerSelected = 3
                answerA.isSelected = false
                answerB.isSelected = false
                answerC.isSelected = false
                answerD.isSelected = true
            default:
                answerSelected = -1
        }
    }
    
    let mathQuestions : [Question] = [Question(question: "Solve the following equation: X−2=7", optionA: "7", optionB: "2", optionC: "9", optionD: "11", correctAnswer: 2)]
    
    let marvelQuestions : [Question] = [Question(question: "During which war did Captain America get his superhuman abilities?", optionA: "Civil War", optionB: "World War I", optionC: "Worlds War II", optionD: "The Cold War", correctAnswer: 2)]
    
    let scienceQuestions : [Question] = [Question(question: "Bees must collect nectar from approximately how many flowers to make 1 pound of honeycomb?", optionA: "10 thousand", optionB: "2 million", optionC: "20 million", optionD: "50 million", correctAnswer: 2)]
    
    @IBAction func submitBtnTouchUpInside(_ sender: Any) {
        if answerSelected == -1 {
            let alert = UIAlertController(title: "No Response", message: "Please select a answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in
                NSLog("\"OK\" pressed.")
            }))
            self.present(alert, animated: true, completion: {
                NSLog("The completion handler fired")
            })
        } else {
            if let answerVC = storyboard?.instantiateViewController(withIdentifier: "answerVC") as? AnswerViewController {
                
                if quizTitle == "Mathematics" {
                    answerVC.question = mathQuestions[questionIndexClicked].question
                    let corrAnswer = mathQuestions[questionIndexClicked].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = mathQuestions[questionIndexClicked].optionA
                    case 1:
                        answerVC.answer = mathQuestions[questionIndexClicked].optionB
                    case 2:
                        answerVC.answer = mathQuestions[questionIndexClicked].optionC
                    case 3:
                        answerVC.answer = mathQuestions[questionIndexClicked].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.result = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.result = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = mathQuestions.count
                } else if quizTitle == "Marvel Super Heroes" {
                    answerVC.question = marvelQuestions[questionIndexClicked].question
                    let corrAnswer = marvelQuestions[questionIndexClicked].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = marvelQuestions[questionIndexClicked].optionA
                    case 1:
                        answerVC.answer = marvelQuestions[questionIndexClicked].optionB
                    case 2:
                        answerVC.answer = marvelQuestions[questionIndexClicked].optionC
                    case 3:
                        answerVC.answer = marvelQuestions[questionIndexClicked].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.result = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.result = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = marvelQuestions.count
                } else if quizTitle == "Science" {
                    answerVC.question = scienceQuestions[questionIndexClicked].question
                    let corrAnswer = scienceQuestions[questionIndexClicked].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = scienceQuestions[questionIndexClicked].optionA
                    case 1:
                        answerVC.answer = scienceQuestions[questionIndexClicked].optionB
                    case 2:
                        answerVC.answer = scienceQuestions[questionIndexClicked].optionC
                    case 3:
                        answerVC.answer = scienceQuestions[questionIndexClicked].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.result = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.result = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = scienceQuestions.count
                }
                answerVC.currentQuestionNum = questionIndexClicked
                answerVC.subject = quizTitle
                answerVC.correctAnswer = correctNum
                self.navigationController?.pushViewController(answerVC, animated: true)
            }
        }
    }
    
    @IBAction func backToHomePageTouchUpInside(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        switch quizTitle {
        case "Mathematics":
            questionLabel.text = mathQuestions[questionIndexClicked].question
            answerA.setTitle(mathQuestions[questionIndexClicked].optionA, for: .normal)
            answerB.setTitle(mathQuestions[questionIndexClicked].optionB, for: .normal)
            answerC.setTitle(mathQuestions[questionIndexClicked].optionC, for: .normal)
            answerD.setTitle(mathQuestions[questionIndexClicked].optionD, for: .normal)
        case "Marvel Super Heroes":
            questionLabel.text = marvelQuestions[questionIndexClicked].question
            answerA.setTitle(marvelQuestions[questionIndexClicked].optionA, for: .normal)
            answerB.setTitle(marvelQuestions[questionIndexClicked].optionB, for: .normal)
            answerC.setTitle(marvelQuestions[questionIndexClicked].optionC, for: .normal)
            answerD.setTitle(marvelQuestions[questionIndexClicked].optionD, for: .normal)
        case "Science":
            questionLabel.text = scienceQuestions[questionIndexClicked].question
            answerA.setTitle(scienceQuestions[questionIndexClicked].optionA, for: .normal)
            answerB.setTitle(scienceQuestions[questionIndexClicked].optionB, for: .normal)
            answerC.setTitle(scienceQuestions[questionIndexClicked].optionC, for: .normal)
            answerD.setTitle(scienceQuestions[questionIndexClicked].optionD, for: .normal)
        default:
            print("Incorrect category")
        }
    }
}

