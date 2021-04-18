//
//  FavoritesViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/26/21.
//
import UIKit

class FavoritesViewController: UIViewController {

    let favoritesViewModel = FavoritesViewModel()
    @IBOutlet weak var favTableView: UITableView!
    var arrOfNotes = [FavoriteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabelView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        fetchData()
    }
    func setUpTabelView(){
        favTableView.dataSource = self
        favTableView.delegate = self
        favTableView.rowHeight = 100
        favTableView.tableFooterView = UIView()
        favTableView.separatorStyle = .none
        favTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
    }
    func fetchData(){
        favoritesViewModel.fetchData { (notes) in
            self.arrOfNotes = notes
            DispatchQueue.main.async {
                self.favTableView.reloadData()
            }
        }
    }
}
extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfNotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
        cell.titleLabel.text = arrOfNotes[indexPath.row].title
        cell.dateLabel.text = arrOfNotes[indexPath.row].date
        let data = arrOfNotes[indexPath.row]
        if data.color == "white"{
            cell.itemView.layer.borderWidth = 1
            cell.itemView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }else if data.color == "red"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "orange"{
            cell.itemView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "yellow"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "green"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "blue"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "purple"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "brown"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if data.color == "gray"{
            cell.itemView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
       return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete note") { (_, _, _) in
            print("Delete")
            let noteSelected = self.arrOfNotes[indexPath.row]
            self.favoritesViewModel.deleteNote(noteSelected: noteSelected) { (isSuccess) in
                if isSuccess{
                    print("success delete")
                }else{
                    print("Error when delete item: ")
                }
            }
            self.fetchData()
        }
        delete.image = UIImage(systemName: "trash")
        let addToFav = UIContextualAction(style: .normal, title: "back to home") { (_, _, _) in
         print("back to home")
            let noteSelected = self.arrOfNotes[indexPath.row]
            guard let title = noteSelected.title, let body = noteSelected.body, let color = noteSelected.color, let date = noteSelected.date else {return}
            self.favoritesViewModel.backToHome(titleNote: title, bodyNote: body, colorNote: color, dateNote: date) { (isSuccess) in
                if isSuccess{
                    print("back to home")
                    self.favoritesViewModel.deleteNote(noteSelected: noteSelected) { (deleteSuccess) in
                        if deleteSuccess{
                            self.fetchData()
                            self.favTableView.reloadData()
                        }
                    }
                }
            }
        }
        addToFav.image = UIImage(systemName: "homekit")
        return UISwipeActionsConfiguration(actions: [delete,addToFav])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "AddNote", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        vc.checkIsEnabelToEditInFav = true
        vc.noteIndex = indexPath.row
        vc.selectNoteFav = self.arrOfNotes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

