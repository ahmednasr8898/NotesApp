//
//  SideMenuTableViewController.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/26/21.
//
import UIKit
import Toast_Swift

class SideMenuTableViewController: UITableViewController {

    let arrOfSectionMenu = ["Favourite","Set Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    func setUpTableView(){
        tableView.register(UINib(nibName: "BasicTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicTableViewCell")
        tableView.register(UINib(nibName: "AdvancedTableViewCell", bundle: nil), forCellReuseIdentifier: "AdvancedTableViewCell")
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfSectionMenu.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let basicCell = tableView.dequeueReusableCell(withIdentifier: "BasicTableViewCell", for: indexPath)
            return basicCell
        }
        else{
            let SetPasswordCell = tableView.dequeueReusableCell(withIdentifier: "AdvancedTableViewCell", for: indexPath) as! AdvancedTableViewCell
            SetPasswordCell.titleLabel.text = arrOfSectionMenu[indexPath.row]
            SetPasswordCell.mySwitch.addTarget(self, action: #selector(handelSwitch(sender:)), for: .valueChanged)
            if UserDefaults.standard.object(forKey: "PasswordNote") != nil{
                SetPasswordCell.mySwitch.setOn(true, animated: true)
            }else{
                SetPasswordCell.mySwitch.setOn(false, animated: true)
            }
            return SetPasswordCell
        }
    }
    @objc func handelSwitch(sender: UISwitch){
        if sender.isOn == true{
            showSetPasswordAlert { (isOK) in
                if isOK{
                    sender.isOn = true
                }else{
                    sender.isOn = false
                }
            }
        }else{
            showSureRemovePasswordAlert { (isOK) in
                if isOK{
                    sender.isOn = false
                }else{
                    sender.isOn = true
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.goToByNavigate(storyboardName: "Favorites", viewControllerName: FavoritesViewController.self)
        }
    }
}
extension SideMenuTableViewController{
    func showSetPasswordAlert(complation: @escaping (Bool)-> Void){
        let alert = UIAlertController(title: "set password", message: "make your notes in save by using password", preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = "put password"
        }
        alert.addTextField { (txt) in
            txt.placeholder = "confirme password"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            complation(false)
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //save password in UserDefuls
            if let password = alert.textFields?[0].text, !password.isEmpty, password == alert.textFields?[1].text{
                UserDefaults.standard.setValue(password, forKey: "PasswordNote")
                complation(true)
                print("notes locked by password")
                self.view.makeToast("notes locked by password")
            }else{
                complation(false)
                print("Password not matched")
                self.view.makeToast("Password not matched")
            }
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    func showSureRemovePasswordAlert(complation: @escaping (Bool)-> Void){
        let alert = UIAlertController(title: "attention", message: "are you sure to delete password??", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
           complation(false)
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //remove password from UserDefuls
            print("the password has been removed")
            self.view.makeToast("the password has been removed")
            UserDefaults.standard.removeObject(forKey: "PasswordNote")
            complation(true)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
