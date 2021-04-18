//
//  UIViewController+extension.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/15/21.
//
import Foundation
import UIKit
extension UIViewController{
    func goToByPresent<vc: UIViewController>(storyboardName: String , viewControllerName: vc.Type , showAs: UIModalPresentationStyle){
        let identfire = String(describing: viewControllerName)
        if let page = UIStoryboard(name: storyboardName, bundle:nil).instantiateViewController(withIdentifier: identfire) as? vc{
        page.modalPresentationStyle = showAs
        present(page, animated: true, completion: nil)
        }
    }
    func goToByNavigate<vc: UIViewController>(storyboardName: String , viewControllerName: vc.Type) {
        let identfire = String(describing: viewControllerName)
        if let page = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identfire) as? vc{
        navigationController?.pushViewController(page, animated: true)
        }
    }
    func showAlertWithTextFields(title: String, messege: String, placeHolderOne: String?, placeHolderTwo: String?, complation: @escaping (Bool)-> Void){
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = placeHolderOne
        }
        alert.addTextField { (txt) in
            txt.placeholder = placeHolderTwo
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            complation(false)
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //save password in UserDefuls
            /*print("Save is Success")
            guard let password = alert.textFields?[0].text, !password.isEmpty, password == alert.textFields?[1].text else {return}
            UserDefaults.standard.setValue(password, forKey: "PasswordNote")*/
            complation(true)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithTextField(title: String, messege: String, placeHolderOne: String?, complation: @escaping (String?)-> Void){
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = placeHolderOne
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
           guard let text = alert.textFields?[0].text else {
            complation(nil)
            return
           }
            complation(text)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithoutTextFields(title: String, messege: String, complation: @escaping (Bool)-> Void){
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
           complation(false)
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //save password in UserDefuls
            /*print("Save is Success")
            UserDefaults.standard.removeObject(forKey: "PasswordNote")*/
            complation(true)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
