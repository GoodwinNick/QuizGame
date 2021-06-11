//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Евгений Петренко on 11.06.2021.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate: TransferedProtocol!
    
   
    private var questions: [Question]?
    private var userAnswers: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        questions = delegate.getData().questions
        userAnswers = delegate.getData().userAnswers
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "quizCell")
    }
    
    @IBAction func newGameStart(_ sender: Any) {
        delegate.newGameStarted()
        navigationController?.popViewController(animated: true)
        
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAnswers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as? QuizTableViewCell else {
            return UITableViewCell()
        }
        
        guard let currentQuestion = questions?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let arrayOfAnswers = Array(currentQuestion.answers.values)
        let arrayOfKeys = Array(currentQuestion.answers.keys)
        
        cell.questionLabel.text = currentQuestion.question
        
        for i in 0 ..< cell.answers.count {
            cell.answers[i].text = arrayOfAnswers[i]
        }
        
            for i in 0 ..< cell.checkBoxs.count {
                if arrayOfKeys[i] == "correct" {
                    cell.checkBoxs[i].tintColor = .green
                }
                
                if i == (userAnswers?[indexPath.row])! {
                    let image = UIImage(systemName: "circle.fill")
                    cell.checkBoxs[i].setImage(image, for: .normal)
                    if cell.checkBoxs[i].tintColor != .green {
                        cell.checkBoxs[i].tintColor = .red
                    }
                    
                }
                cell.checkBoxs[i].isEnabled = false
            }
        
        return cell
    }
    
    
}

extension ResultsViewController: UITableViewDelegate {
    
}
