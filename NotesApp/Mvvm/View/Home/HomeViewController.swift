//
//  ViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit
import RxSwift
import RxCocoa
import CoreData

class HomeViewController: UIViewController {
    
    //MARK:- make right swipe with two buttons (add to fav, delete this note)
    
    let homeViewModel = HomeViewModel()
    @IBOutlet weak var notesTableView: UITableView!
    let disposeBag = DisposeBag()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpTabelView()
        subscribeToFetchData()
        subsribeToDateInTableView()
    }
    func setUpTabelView(){
        notesTableView.rowHeight = 80
        notesTableView.tableFooterView = UIView()
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
    }
    func subsribeToDateInTableView() {
        homeViewModel.notes.bind(to: notesTableView.rx.items(cellIdentifier: "NotesTableViewCell", cellType: NotesTableViewCell.self)) { row, data, cell in
            cell.titleLabel.text = data.titleNote
            cell.dateLabel.text = data.dateNote
            //loop in colorNote and change color cell, borderColor and textLableColor
            if data.colorNote == "white"{
                    print("white is ok")
                }else{
                    print("White is no")
                }
            cell.itemView.layer.cornerRadius = 10
            cell.itemView.layer.borderWidth = 1
            cell.itemView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.itemView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }.disposed(by: disposeBag)
    }
    func subscribeToFetchData(){
        homeViewModel.fetchData.subscribe().disposed(by: disposeBag)
    }
}
