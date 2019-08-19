//
//  AddItemTableViewController.swift
//  CheckList
//
//  Created by Neeraj kumar on 01/06/19.
//  Copyright © 2019 Neeraj kumar. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingitem item: CheckListItems)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingEditing item: CheckListItems)
    
}

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    weak var todoList: ToDoList?
    weak var itemToEdit: CheckListItems?
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    //enter item
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit{
            title = "Edit Title"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    //addbutton
    @IBAction func addItem(_ sender: Any) {

        if let item = itemToEdit, let text = textField.text{
            item.text = text
            delegate?.addItemViewController(self, didFinishAddingEditing: item)
            
        }else {
            if let item = todoList?.newTodo(){
//                let item = CheckListItems()
                if let textFieldText = textField.text{
                    item.text = textFieldText
                }
                item.checked = false
                delegate?.addItemViewController(self, didFinishAddingitem: item)
            }
        }
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    //goback cancel
    @IBAction func cancel(_ sender: Any) {

        delegate?.addItemViewControllerDidCancel(self)
    }
    
    

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    
}


extension AddItemTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool{
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard  let oldText = textField.text,
             let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            addBarButton.isEnabled = false
        }else{
            addBarButton.isEnabled = true
        }
        return true
    }
}
