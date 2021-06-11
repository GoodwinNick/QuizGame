//
//  QuizTableViewCell.swift
//  Quiz
//
//  Created by Евгений Петренко on 10.06.2021.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answers: [UILabel]!
    @IBOutlet var checkBoxs: [UIButton]!
    
    var closureForSendData: ((Int) -> Void)!
    
    @IBAction func typedOnCheckBox(_ sender: UIButton) {
        
        for i in 0 ..< checkBoxs.count {
            if checkBoxs[i] == sender {
                
                checkBoxs[i].imageView?.largeContentImage = .checkmark
                checkBoxs[i].setImage(UIImage(systemName: "circle.fill"), for: .normal)
                closureForSendData(i)
                
            } else {
                checkBoxs[i].isEnabled = false
            }
        }
        
        
    }
    override func prepareForReuse() {
        checkBoxs.forEach {
            $0.isEnabled = true
            let imageCircle = UIImage(systemName: "circle")
            $0.setImage(imageCircle, for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
