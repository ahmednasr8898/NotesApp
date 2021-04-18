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
    var selectNoteFav = FavoriteModel()
    var checkIsEnabelToEdit = false
    var checkIsEnabelToEditInFav = false
    var noteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBodyOfNoteTextView()
        setUpDesign()
        navigationController?.navigationBar.barTintColor = UIColor.systemGray6
        if checkIsEnabelToEdit{
            setUpNoteEdit()
        }
        if checkIsEnabelToEditInFav{
            setUpNoteEditInFav()
        }
    }
    func setUpDesign(){
        title = getCurrentDate()
        chooseButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bodyTextView.font = UIFont.systemFont(ofSize: 18)
        bodyTextView.textColor = .black

        titleTextField.layer.cornerRadius = 20.0
        titleTextField.layer.shadowColor = UIColor.gray.cgColor
        titleTextField.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        titleTextField.layer.shadowRadius = 12.0
        titleTextField.layer.shadowOpacity = 0.7
        
        bodyTextView.layer.cornerRadius = 10.0
        bodyTextView.layer.shadowColor = UIColor.gray.cgColor
        bodyTextView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bodyTextView.layer.shadowRadius = 12.0
        bodyTextView.layer.shadowOpacity = 0.7
    }
    func setUpNoteEdit(){
        titleTextField.text = selectNote.titleNote
        bodyTextView.text = selectNote.bodyNote
        setUpColorButton(colorNote: selectNote.colorNote!)
        addDeleteBarButton()
    }
    func setUpNoteEditInFav(){
        titleTextField.text = selectNoteFav.title
        bodyTextView.text = selectNoteFav.body
        setUpColorButton(colorNote: selectNoteFav.color!)
        //addDeleteBarButton()
    }
    func addDeleteBarButton(){
        let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteSelctedNoteOnClick))
        navigationItem.setRightBarButtonItems([deleteBarButton,addNewNoteButton,chooseButton], animated: true)
    }
    @objc func deleteSelctedNoteOnClick(){
        if checkIsEnabelToEditInFav{
            addNewNoteViewModel.deleteNoteFav(noteSelected: selectNoteFav) { (deleteNote) in
                if deleteNote{
                    print("delete this note")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
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
        }else if checkIsEnabelToEditInFav{
            editSelectedNoteInFav()
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
                self.titleTextField.text = " "
                self.bodyTextView.text = " "
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
    func editSelectedNoteInFav(){
        let title = titleTextField.text
        let body = bodyTextView.text
        let color = noteColor
        let date = getCurrentDate()
        addNewNoteViewModel.editNoteInFav(selectedNote: selectNoteFav, titleNote: title ?? "", bodyNote: body ?? "", colorNote: color, dateNote: date) { (isEdit) in
            if isEdit{
                print("Success to edit note Fav")
            }else{
                print("error when edit note Fav")
            }
        }
    }
}
