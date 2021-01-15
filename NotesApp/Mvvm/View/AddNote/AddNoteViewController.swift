//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    var noteColor: String = "white"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBodyOfNoteTextView()
        title = getCurrentDate()
    }
    @IBAction func chooseNoteColorOnClick(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ChooseColor", bundle: nil).instantiateViewController(withIdentifier: "ChooseColorViewController") as! ChooseColorViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.noteColorDataBack = { color in
            self.noteColor = color
        }
        self.present(vc, animated: true, completion: nil)
    }
    func getCurrentDate()-> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
}
