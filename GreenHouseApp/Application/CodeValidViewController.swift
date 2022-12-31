//
//  CodeValidViewController.swift
//  
//
//  Created by Вадим on 28.12.2022.
//

import UIKit

class CodeValidViewController: UIViewController {
    
    override func loadView() {
        self.view = CodeValidView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        setupConfig()
    }
    
    func view() -> CodeValidView {
       return self.view as! CodeValidView
    }
    
    func setupConfig() {
        self.view().checkCodeButton.alpha = 0.5
        self.view().checkCodeButton.isEnabled = false
        
        self.view().codeTV.delegate = self
    }
    
}

extension CodeValidViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            self.view().checkCodeButton.alpha = 1
            self.view().checkCodeButton.isEnabled = true
        } else {
            self.view().checkCodeButton.alpha = 0.5
            self.view().checkCodeButton.isEnabled = false
        }
    }
     
}

extension CodeValidViewController: CodeValidViewControllerDelegate  {
}
