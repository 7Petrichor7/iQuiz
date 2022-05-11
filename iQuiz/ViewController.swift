//
//  ViewController.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let subjects : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions : [String] = ["Math knowledge test! 1+1 = ?", "Marval super heroes knowledge multiple choice test!", "Scientific field knowledge!"]
    let images : [String] = ["math", "marvel", "science"]
    
    @IBOutlet weak var tableViewQuiz: UITableView!
    @IBAction func toolbarItem_settings(_ sender: Any) {
        clickAlert("Settings", "Settings go here")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewQuiz.delegate = self
        tableViewQuiz.dataSource = self
        tableViewQuiz.rowHeight = 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return nil
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "quizTopic", for: indexPath)

        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = subjects[indexPath.row]
        clickAlert(item, "questions for \"\(item)\" will be here")
    }
    
    func clickAlert(_ title : String, _ message : String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialogMessage, animated: true, completion: nil)
    }
    


}

