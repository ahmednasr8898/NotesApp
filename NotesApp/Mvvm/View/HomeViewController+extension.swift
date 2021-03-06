//
//  HomeViewController+extension.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import Foundation
import UIKit

extension HomeViewController{
    func setUpNavigationController(){
        title = "Note"
        //add right bar button item (add new note)
        let addBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAddNewNote(sender:)))
        navigationItem.rightBarButtonItem = addBarButton
        //add left bar button item (show side menu)
        let showMenuBarButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(showSideMenu(sender:)))
        navigationItem.leftBarButtonItem = showMenuBarButton
    }
    @objc func goToAddNewNote(sender: UIBarButtonItem){
        self.goToByNavigate(storyboardName: "AddNote", viewControllerName: AddNoteViewController.self)
    }
    @objc func showSideMenu(sender: UIBarButtonItem){
        present(menu!, animated: true, completion: nil)
    }
}
