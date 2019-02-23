//
//  ViewController.swift
//  Tarea3
//
//  Created by Jason Barrios on 2/20/19.
//  Copyright © 2019 Jason Barrios. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    public var books : Results<Books>?
    private let customCellIdentifier = "TableViewCell"
    private let customCellHeight: CGFloat = 70.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerCustomTableView()
        
        addRightNavigationBarButtonItem()
        
        loadBooks()
    }
    
    func registerCustomTableView() {
        let nib = UINib(nibName: customCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: customCellIdentifier)
    }
    
    func addRightNavigationBarButtonItem(){
        let backButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showDialog(sender:)))
        navigationItem.rightBarButtonItem = backButton
    }
    
    
    @objc func showDialog(sender: UIBarButtonItem){
        //navigationController?.popViewController(animated: true)
        let alert = UIAlertController(title: "", message: "Agrega titulo", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Guardar", style: .default) { (alertAction) in
            weak var text1 = alert.textFields![0] as UITextField
            
            if text1?.text != "" {
                let book = Books()
                book.title = text1?.text ?? ""
                book.createAt = Date()
                
                self.saveRealmObject(realmObject : book)
                self.loadBooks()
            }

        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Titulo"
        }
        
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
    
    
    private func loadBooks()
    {
        do {
            let realm = try Realm();
            let books = realm.objects(Books.self)
            if books.isEmpty {
            }
            else
            {
                self.books = books
                tableView.reloadData()
            }
        }
        catch let error as NSError
        {
            print ("Error loading : \(error)")
        }
    }
    
    private func saveRealmObject(realmObject: Object)
    {
        do
        {
            let realm = try Realm();
            try realm.write {
                realm.add(realmObject, update: true)
            }
        }
        catch let error as NSError {
            print("Error insert : \(error)")
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellIdentifier) as? TableViewCell else {
            return UITableViewCell()
        }
        
        if let books = books {
            cell.setupCell(book: books[indexPath.row])
        }

        return cell
    }
    
}


