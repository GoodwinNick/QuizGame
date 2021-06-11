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
        
        for item in checkBoxs {
            let i = item.tag
            if item == sender {
                
                item.imageView?.largeContentImage = .checkmark
                item.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                item.isEnabled = false
                print(i)
                closureForSendData(i)
                
            } else {
                item.isEnabled = false
            }
        }
        
    }
    
    override func prepareForReuse() {
        checkBoxs.forEach {
            $0.isEnabled = true
            let imageCircle = UIImage(systemName: "circle")
            $0.setImage(imageCircle, for: .normal)
            $0.tintColor = .link
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
