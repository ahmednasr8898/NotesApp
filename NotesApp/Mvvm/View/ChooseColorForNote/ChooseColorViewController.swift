//
//  ChooseColorViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit

class ChooseColorViewController: UIViewController {

    //clouser for back color is selected
    var noteColorDataBack: ((_ noteColor: String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissView()
    }
    func dismissView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewOnClick))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func tapViewOnClick(){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func redColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("red")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func orangeColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("orange")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func yellowColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("yellow")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func greenColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("green")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func blueColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("blue")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func purpleColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("purple")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func whiteColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("white")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func brownColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("brown")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func grayColorOnClick(_ sender: UIButton) {
        noteColorDataBack?("gray")
        dismiss(animated: true, completion: nil)
    }
}
