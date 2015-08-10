//
//  ShowdownViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/7/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import SimpleAlert

class PlayerListViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate{

    var playerList : [Player]!

    func addNewPlayer(){
        tableView.reloadData()



        var addPlayerPopup = SimpleAlert.Controller(title: "Add a Player ", message: "", style: SimpleAlert.Controller.Style.Alert)
        addPlayerPopup.addTextFieldWithConfigurationHandler() { textField in
            textField.frame.size.height = 30
            textField.backgroundColor = nil
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0
            textField.placeholder = "Player Initials"
            textField.borderStyle = UITextBorderStyle.Line
            textField.delegate = self

        }

        addPlayerPopup.addTextFieldWithConfigurationHandler() { textField in
            textField.frame.size.height = 30
            textField.backgroundColor = nil
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0
            textField.placeholder = "Number of Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.borderStyle = UITextBorderStyle.Line
//            textField.delegate = self

        }

        addPlayerPopup.addAction(SimpleAlert.Action(title: "Add Player", style: .Default) { action in
            var playerName : String = addPlayerPopup.textFields[0].text
            var playerCount : Int = addPlayerPopup.textFields[1].text.toInt()!
            self.playerList.append(Player(name: playerName, startChips: playerCount, color: self.playerList.count + 1))
            self.tableView.reloadData()

        })
        self.presentViewController(addPlayerPopup, animated: true, completion: {})

//        println(playerList)
    }

    override func viewDidLoad() {
        playerList = []
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBarHidden = true


    }
}

extension PlayerListViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerCell
        println("Asdf")
        let row = indexPath.row
        let player = playerList[row] as Player
        cell.player = player

        return cell

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return playerList.count
    }


}

extension PlayerListViewController: UITableViewDelegate {


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }

    // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
}
extension PlayerListViewController : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if count(textField.text) > 3 && range.length == 0{
            return false
        }
        return true
    }
}