//
//  ToDoList.swift
//  CheckList
//
//  Created by Neeraj kumar on 01/06/19.
//  Copyright © 2019 Neeraj kumar. All rights reserved.
//

import Foundation

class ToDoList{
    var todos: [CheckListItems] = []
    
    init(){

        let row0Item = CheckListItems()
        let row1Item = CheckListItems()
        let row2Item = CheckListItems()
        let row3Item = CheckListItems()
        let row4Item = CheckListItems()
        
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "code an app"
        row3Item.text = "walk a dog"
        row4Item.text = "Study design pattern"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
        
    }
    
    func newTodo() -> CheckListItems {
        let item = CheckListItems()
        item.text = randomTitle()
        item.checked = true
        todos.append(item)
        return item
    }
    
    func move(item: CheckListItems, to index: Int){
        guard let currentIndex = todos.index(of: item) else{
            return
        }
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }
    
    //delete multiple
    func remove(items: [CheckListItems]){
        for item in items{
            if let index = todos.index(of: item){
                todos.remove(at: index)
            }
        }
    }
    
    private func randomTitle() -> String {
        var titles = ["New todo List","Generic Todo","Fill me out","I need something todo","Much todo about Nothing"]
        let randomTitle = Int.random(in: 0...titles.count-1)
        return titles [randomTitle]
    }
}
