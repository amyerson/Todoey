//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Create the Way on 2/25/18.
//  Copyright © 2018 Favor It. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()

    }

    //MARK: TableView Datasource Methods
    //display all categories in persistent container
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
//        cell.accessoryType = category.done ? .checkmark : .none
        
        return cell
        
    }
    
    
    //MARK: - Data Manipulation Methods
    //save and load data (CRUD)
    
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()

    }
    
    //MARK: - Add New Categories
    //add button pressed using categories entity

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Tableview Delegate Methods
    //what happens when we click in a cell in the tableview
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
 
        if let indexPath = tableView.indexPathForSelectedRow {
            
    destinationVC.selectedCategory = categories?[indexPath.row] 
            
    }

    }
    
}
