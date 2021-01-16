//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit
import RxSwift
import RxCocoa

class AddNoteViewController: UIViewController {
    
    //MARK:- when selected color -> background in same color
    //MARK:- when return to home page refresh data in tableView

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var addNewNoteButton: UIBarButtonItem!
    var noteColor: String = "red"
    let addNewNoteViewModel = AddNoteViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBodyOfNoteTextView()
        title = getCurrentDate()
        subscribeToSaveNewNote()
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
    func bind(){
        titleTextField.rx.text.orEmpty.bind(to: addNewNoteViewModel.titleBehavior).disposed(by: disposeBag)
        bodyTextView.rx.text.orEmpty.bind(to: addNewNoteViewModel.bodyBehavior).disposed(by: disposeBag)
        self.addNewNoteViewModel.colorBehavior.accept(self.noteColor)
        let dateNote = getCurrentDate()
        self.addNewNoteViewModel.dateBehavior.accept(dateNote)
    }
    func subscribeToSaveNewNote(){
        addNewNoteButton.rx.tap.subscribe { (_) in
            self.bind()
            self.addNewNoteViewModel.saveNote()
        }.disposed(by: disposeBag)
    }
}
