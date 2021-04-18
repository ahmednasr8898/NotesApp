//
//  ViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import UIKit
import CoreData
import SideMenu

class HomeViewController: UIViewController {
    
    let searchBar = UISearchController(searchResultsController: nil)
    let homeViewModel = HomeViewModel()
    @IBOutlet weak var notesTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrOfNotes = [NoteModel]()
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpTabelView()
        listenToPassword()
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
        setUpMenu()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        fetchData()
    }
    func setUpTabelView(){
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.rowHeight = 100
        notesTableView.tableFooterView = UIView()
        notesTableView.separatorStyle = .none
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
    }
    func fetchData(){
        homeViewModel.fetchData { (notes) in
            self.arrOfNotes = notes
            DispatchQueue.main.async {
                self.notesTableView.reloadData()
            }
        }
    }
    func listenToPassword(){
        homeViewModel.checkPasswordForNotes { (password) in
            if let password = password{
                self.showAlertWithTextField(title: "Enter your password", messege: "put your password for show your notes", placeHolderOne: "put password") { (pass) in
                    if pass == password{
                        print("okokokokokokok")
                    }else{
                        print("nononononononoon")
                        let alert = UIAlertController(title: "Password in worng!!", message: "", preferredStyle: .alert)
                        let reEnterPasswordButton = UIAlertAction(title: "ReEnter Password", style: .cancel) { (action) in
                            self.listenToPassword()
                        }
                        alert.addAction(reEnterPasswordButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func setUpMenu(){
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.leftSide = true
    }
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfNotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
        cell.titleLabel.text = arrOfNotes[indexPath.row].titleNote
        cell.dateLabel.text = arrOfNotes[indexPath.row].dateNote
        let data = arrOfNotes[indexPath.row]
        if data.colorNote == "white"{
            cell.itemView.layer.borderWidth = 1
            cell.itemView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }else if data.colorNote == "red"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "orange"{
            cell.itemView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "yellow"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "green"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "blue"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "purple"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "brown"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.colorNote == "gray"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
       return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete note") { (_, _, _) in
            let noteSelected = self.arrOfNotes[indexPath.row]
            self.homeViewModel.deleteNote(noteSelected: noteSelected) { (isSuccess) in
                if isSuccess{
                    print("success delete")
                }else{
                    print("Error when delete item: ")
                }
            }
            self.fetchData()
        }
        delete.image = UIImage(systemName: "trash")
        let addToFav = UIContextualAction(style: .normal, title: "add to favourite") { (_, _, _) in
            
            let noteSelected = self.arrOfNotes[indexPath.row]
            guard let title = noteSelected.titleNote, let body = noteSelected.bodyNote, let color = noteSelected.colorNote, let date = noteSelected.dateNote else {return}
            self.homeViewModel.addToFavorite(titleNote: title, bodyNote: body, colorNote: color, dateNote: date) { (isSccuss) in
                if isSccuss{
                    print("Add to fav")
                    self.homeViewModel.deleteNote(noteSelected: noteSelected) { (deleteSuccess) in
                        if deleteSuccess{
                            self.fetchData()
                            self.notesTableView.reloadData()
                        }
                    }
                }
            }
        }
        addToFav.image = UIImage(systemName: "heart")
        return UISwipeActionsConfiguration(actions: [delete,addToFav])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "AddNote", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        vc.checkIsEnabelToEdit = true
        vc.noteIndex = indexPath.row
        vc.selectNote = self.arrOfNotes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            homeViewModel.searchOnTableView(titleNote: searchText) { (notes) in
                guard let notes = notes else{return}
                self.arrOfNotes = notes
                self.notesTableView.reloadData()
            }
        }else{
            fetchData()
        }
    }
}
