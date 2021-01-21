//
//  AddNoteViewController+extension.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import Foundation
import UIKit
extension AddNoteViewController: UITextViewDelegate{
    func setUpBodyOfNoteTextView(){
        bodyTextView.text = "Note..."
        bodyTextView.textColor = UIColor.lightGray
        bodyTextView.font = UIFont.systemFont(ofSize: 13)
        bodyTextView.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Note..." {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont.systemFont(ofSize: 16)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "/n" {
            textView.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Note..."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont.systemFont(ofSize: 13)
        }
    }
    func setUpColorButton(colorNote: String){
        if colorNote == "white"{
            self.chooseButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if colorNote == "red"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }else if colorNote == "orange"{
            self.chooseButton.tintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else if colorNote == "yellow"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        }else if colorNote == "green"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if colorNote == "blue"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }else if colorNote == "purple"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        }else if colorNote == "brown"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        }else if colorNote == "gray"{
            self.chooseButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
    }
}
