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
    
    var data = SubjectSource();
    let actor = SubjectSelector();
    var initialUrl = "https://tednewardsandbox.site44.com/questions.json"
    var urlInputField: UITextField = UITextField()
    
    var refresh = UIRefreshControl()
    var quizData : [Quiz]? = nil
    
    @IBOutlet weak var tableViewQuiz: UITableView!
    
//    @IBAction func toolbarItem_settings(_ sender: Any) {
//        clickAlert("Settings", "Settings go here")
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        if self.quizData == nil {
//            populateData(initialUrl)
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = myTableView.indexPathForSelectedRow{
//            let questions = indexPath.row
//            let questionView = segue.destination as! QuestionsViewController
//            questionView.segmentNumber = questions
//            questionView.quizData = myData.quizData
//            questionView.myURL = myData.myURL
//        }
//    }
    
    @IBAction func settingsPopUp(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Enter URL", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            self.urlInputField = textField
            self.urlInputField.placeholder = "Enter URL here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Check Now", comment: "OK"), style: .default, handler: {_ in
            if (self.urlInputField.text != nil) {
                NSLog("text is fine")
                UserDefaults.standard.setValue(self.urlInputField.text, forKey: "url_preference")
                self.fetch(urlInput: self.urlInputField.text!)
//                self.populateData(self.v.text!)
            }
        }))
        self.present(alert, animated: true, completion: {NSLog("complete setting")})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableViewQuiz.delegate = self
//        tableViewQuiz.dataSource = self
//        tableViewQuiz.rowHeight = 80
//        let quizTableViewNib = UINib(nibName: "QuizTableViewCell", bundle: nil)
//        tableViewQuiz.register(quizTableViewNib, forCellReuseIdentifier: "QuizTableViewCell")
        tableView.dataSource = data
        tableView.delegate = actor
        if (self.data.subjects.count == 0) {
            fetch(urlInput: defaultUrl)
        }
        self.navigationItem.hidesBackButton = true
//        if (self.subjects.count == 0) {
//            fetch(urlInput: defaultUrl)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionView = segue.destination as! QuestionViewController
        questionView.typeNum = tableView.indexPathForSelectedRow?.row
        questionView.fullData = self.data.fullData
        questionView.url = self.defaultUrl
    }
    
    
    func populateData(_ getter: String) {
        self.initialUrl = getter
        let url = URL(string: getter)
        let myFile = "data.json"
        let myDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard url != nil else {
            self.showAlertWithMessage(message: "Error! JSON is empty.")
            return
        }
        
        if Reachability.isNetworkAvailable() {
            let mySession = URLSession.shared
            let dataTask = mySession.dataTask(with: url!) { [self] (data, response, error) in
                if error == nil && data != nil {
                    // Parse JSON
                    let myDecoder = JSONDecoder()
                    
                    do {
                        let myQuiz = try myDecoder.decode([Quiz].self, from: data!)
                        self.myCategory = []
                        self.myDescription = []
                        self.quizData = myQuiz
                        
                        for q in myQuiz {
                            self.myCategory.append(q.title)
                            self.myDescription.append(q.desc)
                        }
                        if myDirectory != nil {
                            let myFilePath = myDirectory?.appendingPathComponent(myFile)
                            do {
                                try data!.write(to: myFilePath!, options: Data.WritingOptions.atomic)
                            } catch {
                                self.showAlertWithMessage(message: "Not able to save data.")
                            }
                        } else {
                            self.showAlertWithMessage(message: "Not able to retrieve data.")
                        }
                    } catch {
                        self.showAlertWithMessage(message: "Error found while parsing data.")
                    }
                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
            dataTask.resume()
        } else {
            self.showAlertWithMessage(message: "Network Unavailable! Data loading from local storage.")
            DispatchQueue.global(qos: .userInitiated).async {
                if myDirectory != nil {
                    let myFilePath = myDirectory?.appendingPathComponent(myFile)
                    var data: Data? = nil
                    do {
                        try data = Data(contentsOf: myFilePath!)
                    } catch {
                        NSLog(error.localizedDescription)
                    }
                    if data != nil && data!.count > 0 {
                        let myDecoder = JSONDecoder()
                        do {
                            let myQuiz = try myDecoder.decode([Quiz].self, from: data!)
                            DispatchQueue.main.async {
                                self.myCategory = []
                                self.myDescription = []
                                self.quizData = myQuiz
                                for q in myQuiz {
                                    self.myCategory.append(q.title)
                                    self.myDescription.append(q.desc)
                                }
                                self.tableView?.reloadData()
                            }
                        } catch {
                            self.showAlertWithMessage(message: "Unable to load data from local storage.")
                        }
                    }
                } else {
                    //
                    self.showAlertWithMessage(message: "Unable to load data")
                }
            }
        }
    }
    
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in NSLog("Done")}))
        self.present(alert, animated: true)
    }
    
    @objc func refresh(sender:AnyObject) {
        populateData(initialUrl)
        self.refresh.endRefreshing()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath)
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let quizVC = storyboard?.instantiateViewController(withIdentifier: "quizVC") as? QuestionViewController {
            quizVC.quizTitle = subjects[indexPath.row]
            quizVC.correctNum = 0
            self.navigationController?.pushViewController(quizVC, animated: true)
        }
    }
    
    func clickAlert(_ title : String, _ message : String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialogMessage, animated: true, completion: nil)
    }

}

class SubjectSelector: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

class SubjectSource : NSObject, UITableViewDataSource {
    public var fullData:[Quiz] = []
    public var subjects:[String] = []
    public var descriptions:[String] = []
    public var images = ["math", "marvel", "science"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SampleCell = tableView.dequeueReusableCell(withIdentifier: ViewController.CELL_STYLE, for: indexPath) as! SampleCell
        
        cell.desc?.text = descriptions[indexPath.row]
        cell.icon?.image = UIImage(named: images[indexPath.row])
        cell.title?.text = subjects[indexPath.row]
        return cell
        
    }
    
}

