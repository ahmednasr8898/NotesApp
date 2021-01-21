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
    var selectNote = NoteModel()
    var checkIsEnabelToEdit = false
    var noteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBodyOfNoteTextView()
        setUpDesign()
        navigationController?.navigationBar.barTintColor = UIColor.systemGray6
        if checkIsEnabelToEdit{
            setUpNoteEdit()
        }
    }
    func setUpDesign(){
        title = getCurrentDate()
        chooseButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bodyTextView.font = UIFont.systemFont(ofSize: 18)
        bodyTextView.textColor = .black
    }
    func setUpNoteEdit(){
        titleTextField.text = selectNote.titleNote
        bodyTextView.text = selectNote.bodyNote
        setUpColorButton(colorNote: selectNote.colorNote!)  
        addDeleteBarButton()
    }
    func addDeleteBarButton(){
        let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteSelctedNoteOnClick))
        navigationItem.setRightBarButtonItems([deleteBarButton,addNewNoteButton,chooseButton], animated: true)
    }
    @objc func deleteSelctedNoteOnClick(){
        addNewNoteViewModel.deleteNote(noteSelected: selectNote) { (isSuccessDelete) in
            print("delete this note")
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func chooseNoteColorOnClick(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ChooseColor", bundle: nil).instantiateViewController(withIdentifier: "ChooseColorViewController") as! ChooseColorViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.noteColorDataBack = { color in
            self.noteColor = color
            self.setUpColorButton(colorNote: color)
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func AddNewNoteOnClick(_ sender: UIBarButtonItem) {
        if checkIsEnabelToEdit{
            editSelectedNote()
        }else{
            saveNewNote()
        }
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
    func editSelectedNote(){
        let title = titleTextField.text
        let body = bodyTextView.text
        let color = noteColor
        let date = getCurrentDate()
        addNewNoteViewModel.editNote(selectedNote: selectNote, titleNote: title ?? "", bodyNote: body ?? "", colorNote: color, dateNote: date) { (isEdit) in
            if isEdit{
                print("Success to edit note")
            }else{
                print("error when edit note")
            }
        }
    }
}
