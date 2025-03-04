//
//  ViewController.swift
//  Guess-the-Flag
//
//  Created by Ömerfaruk Saribal on 23.02.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
        @IBOutlet var button2: UIButton!
        @IBOutlet var button3: UIButton!

        var countries = [String]()
        var correctAnswer = 0
        var score = 0
        var askedQuestions = 0

        override func viewDidLoad() {
            super.viewDidLoad()

            countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
            
            configureButton(button1, withImageNamed: countries[0])
            configureButton(button2, withImageNamed: countries[1])
            configureButton(button3, withImageNamed: countries[2])
            
            askQuestion()
        }
        
        func configureButton(_ button: UIButton, withImageNamed imageName: String) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: imageName)
            
            // This replaces contentEdgeInsets
            config.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            // Configure a border via the background
            config.background.backgroundColor = .white
            config.background.strokeColor = .lightGray
            config.background.strokeWidth = 1
            config.background.cornerRadius = 0  // No border radius

            // Make the image scale aspect-fit within the button
            config.imagePlacement = .top  // or .leading, etc.
            config.imagePadding = 0

            button.configuration = config
        }

    
    func askQuestion(action: UIAlertAction! = nil){
        askedQuestions += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())"
        
        let scoreButton = UIBarButtonItem(image: UIImage(systemName: "trophy"), style: .plain, target: self, action: #selector(scoreTapped))
        navigationItem.rightBarButtonItem = scoreButton

    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        if askedQuestions % 10 == 0 {
            let finalAlertController = UIAlertController(title: "Final Score: \(score)", message: "10 questions asked in total do you want to continue?", preferredStyle: .alert)
            finalAlertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(finalAlertController, animated: true)
            
            score = 0
            askedQuestions = 0
        } else {
            let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
    }
    
    @objc func scoreTapped() {
        let ac = UIAlertController(title: "Current Score", message: "Your score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

