//
//  ResultViewController.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/15/22.
//

import UIKit

class ResultViewController: UIViewController {
    var correctNum = 0
    var totalNum = 0
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultScoreLabel: UILabel!
    @IBAction func backToHomePageBtn(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correctNum == totalNum {
            messageLabel.text = "Perfect!"
        } else if correctNum > totalNum / 2 {
            messageLabel.text = "Almost"
        } else {
            messageLabel.text = "Try harder"
        }

        resultScoreLabel.text = "You got \(correctNum) of \(totalNum) of correct."

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
