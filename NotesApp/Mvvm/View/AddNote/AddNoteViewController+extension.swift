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
}
