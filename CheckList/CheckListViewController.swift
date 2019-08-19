//
//  ViewController.swift
//  CheckList
//
//  Created by Neeraj kumar on 31/05/19.
//  Copyright © 2019 Neeraj kumar. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    

    var todoList: ToDoList
    
    @IBAction func addItem(){
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    //multiple row delete
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRow = tableView.indexPathsForSelectedRows{
            var items = [CheckListItems]()
            for indexPath in selectedRow{
                items.append(todoList.todos[indexPath.row])
            }
            todoList.remove(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRow, with: .automatic)
            tableView.endUpdates()
        }
    }
    required init?(coder aDecoder: NSCoder) {

        todoList = ToDoList()
        
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for:  indexPath)
        
        let item = todoList.todos[indexPath.row]
        
        configureText(for: cell, with: item)
        
        configureCheckmarked(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todoList.move(item: todoList.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing{
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath){
            let item = todoList.todos[indexPath.row]
            item.toggle()
            configureCheckmarked(for: cell, with: item)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    
    
    //deleting button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItems){
        if let checkmarkCell = cell as? CkeckListTableViewCell{
            checkmarkCell.todoTextLabel.text = item.text
        }
    }
    
    func configureCheckmarked(for cell: UITableViewCell, with item: CheckListItems){
        
        guard let checkmarkCell = cell as? CkeckListTableViewCell else{
            return
        }
        
        if item.checked{
            checkmarkCell.checkMarkLabel.text = "√"
        }else{
            checkmarkCell.checkMarkLabel.text = ""
        }
//
//            if item.checked {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                addItemViewController.delegate = self
                addItemViewController.todoList = todoList
            }
        }else if segue.identifier == "EditItemSegue"{
            if let addItemViewController = segue.destination as?
                AddItemTableViewController{
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell){
                        let item = todoList.todos[indexPath.row]
                        addItemViewController.itemToEdit = item
                        addItemViewController.delegate = self
                }
            }
        }
    }
    
    }


extension CheckListViewController: AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingitem item: CheckListItems) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
//        todoList.todos.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingEditing item: CheckListItems) {
        if let index = todoList.todos.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
