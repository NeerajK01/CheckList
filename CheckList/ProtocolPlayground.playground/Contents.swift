import UIKit

protocol Persist{
    func save()
}

class Monster: Persist{
    func save(){
        print("Moster")
    }
}

class Sword: Persist{
    func save(){
        print("sword")
    }
}

let monster = Monster()
let sword = Sword()

let items: [Persist] = [monster, sword]

class GameManager{
    func saveLevel(_ items: [Persist]){
        for item in items{
            item.save()
        }
    }
}

let game = GameManager()
game.saveLevel(items)
