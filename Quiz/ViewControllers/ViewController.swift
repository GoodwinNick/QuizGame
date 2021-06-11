//
//  ViewController.swift
//  Quiz
//
//  Created by Евгений Петренко on 10.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var questions: [Question]?
    private var userAnswers: [Int]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
        
        
        
        
        questions = [Question]()
        
        
        let jsonDecocer = JSONDecoder()
        
        let jData: Data? = readData(forName: "JsonOfQuestions")
        
        do {
            questions = try jsonDecocer.decode([Question].self, from: jData ?? Data())
        } catch {
            print("Error", error)
        }
        
        
        
        
        
        userAnswers = Array.init(repeating: 4, count: questions?.count ?? 0)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        userAnswers?.forEach {
            if $0 > 3 {
                
                let alarm = UIAlertController(title: "Not now!",
                                              message: "You should answer all questions!",
                                              preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "Oki!",
                                             style: .default,
                                             handler: nil
                )
                
                alarm.addAction(okAction)
                
                present(alarm,
                        animated: true,
                        completion: nil
                )
                
                
                return
            }
        }
        guard let destination = segue.destination as? ResultsViewController else {
            return
        }
        
        destination.delegate = self
    
    }
    
    
    func readData(forName name: String) -> Data? {
        do {
            if let path = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOf: URL.init(fileURLWithPath: path)).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Error:", error)
        }
        return nil
    }
}


extension ViewController: TransferedProtocol {
    func newGameStarted() {
        userAnswers = Array.init(repeating: 4, count: userAnswers?.count ?? 0)
        tableView.reloadData()
    }
    
    func getData() -> (questions: [Question]?, userAnswers: [Int]?) {
        return (questions, userAnswers)
    }
    
}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as? QuizTableViewCell else {
            return UITableViewCell()
        }
        
        guard let currentQuestion = questions?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let arrayOfAnswers = Array(currentQuestion.answers.values)
        cell.questionLabel.text = currentQuestion.question
        
        for i in 0 ..< cell.answers.count {
            cell.answers[i].text = arrayOfAnswers[i]
        }
        
        // MARK: Check for cells which was used
        if (userAnswers?[indexPath.row])! >= 0,
           (userAnswers?[indexPath.row])! <= 3 {
            for i in 0 ..< cell.checkBoxs.count {
                if i == (userAnswers?[indexPath.row])! {
                    let image = UIImage(systemName: "circle.fill")
                    cell.checkBoxs[i].setImage(image, for: .normal)
                }
                cell.checkBoxs[i].isEnabled = false
            }
        }
        
        cell.closureForSendData = { num in
            self.userAnswers?[indexPath.row] = num
            print(num)
        }
        
        return cell
    }
    
    func reloadReusableCells(cell: QuizTableViewCell) {
        cell.checkBoxs.forEach {
            $0.isEnabled = true
            let imageCircle = UIImage(systemName: "circle")
            $0.setImage(imageCircle, for: .normal)
        }
    }
    
}
