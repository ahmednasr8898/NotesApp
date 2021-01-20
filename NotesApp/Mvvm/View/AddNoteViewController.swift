//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var chooseButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var addNewNoteButton: UIBarButtonItem!
    var noteColor: String = "white"
    let addNewNoteViewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBodyOfNoteTextView()
        title = getCurrentDate()
        chooseButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor.systemGray6
    }
    @IBAction func chooseNoteColorOnClick(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ChooseColor", bundle: nil).instantiateViewController(withIdentifier: "ChooseColorViewController") as! ChooseColorViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.noteColorDataBack = { color in
            self.noteColor = color
            if color == "white"{
                self.chooseButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else if color == "red"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }else if color == "orange"{
                self.chooseButton.tintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }else if color == "yellow"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            }else if color == "green"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }else if color == "blue"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            }else if color == "purple"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }else if color == "brown"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
            }else if color == "gray"{
                self.chooseButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func AddNewNoteOnClick(_ sender: UIBarButtonItem) {
        saveNewNote()
    }
    func getCurrentDate()-> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    func saveNewNote(){
        let title = titleTextField.text
        let body = bodyTextView.text
        let color = noteColor
        let date = getCurrentDate()
        addNewNoteViewModel.saveNote(titleNote: title ?? "", bodyNote: body ?? "", colorNote: color , dateNote: date ) { (isSaved) in
            if isSaved{
                print("Success to save new note")
            }else{
                print("error when save new note")
            }
        }
    }
}
