//
//  CheckListItems.swift
//  CheckList
//
//  Created by Neeraj kumar on 01/06/19.
//  Copyright © 2019 Neeraj kumar. All rights reserved.
//

import Foundation

class CheckListItems: NSObject{
    var text = ""
    var checked = false
    
    func toggle(){
        checked = !checked
    }
}
