//
//  ShowdownViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/7/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import SimpleAlert
import ActionButton
import Mixpanel

class PlayerListViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate{

    var mixpanel = Mixpanel.sharedInstance()

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
            textField.delegate = self

        }

        addPlayerPopup.addAction(SimpleAlert.Action(title: "Add Player", style: .Default) { action in
            var playerName : String = addPlayerPopup.textFields[0].text
            var playerCount : Int = 0
            if !addPlayerPopup.textFields[1].text.isEmpty {
                playerCount = addPlayerPopup.textFields[1].text.toInt()!
            }
            else {
                return
            }
            Universal.sharedInstance.playersList.append(Player(name: playerName, startChips: playerCount, color: Universal.sharedInstance.playersList.count + 1))
            self.tableView.reloadData()

        })
        self.presentViewController(addPlayerPopup, animated: true, completion: {})

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        mixpanel.track("Opened View Controller", properties: ["View Controller" : "PlayerList"])


    }
}

extension PlayerListViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerCell
        let row = indexPath.row
        let player = Universal.sharedInstance.playersList[row]
        cell.player = player

        return cell

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Universal.sharedInstance.playersList.count
    }


}

extension PlayerListViewController: UITableViewDelegate {


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }

    // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }



    func saveObjectAndInsertBlankRowAtIndexPath(indexPath : NSIndexPath) -> AnyObject{
        var object = Universal.sharedInstance.playersList[indexPath.row]
        Universal.sharedInstance.playersList[indexPath.row] = Player(name: "", startChips: 0, color: 1)
        return object

    }


    func moveRowAtIndexPath(fromIndexPath : NSIndexPath, toIndexPath: NSIndexPath){
        var object = Universal.sharedInstance.playersList[fromIndexPath.row]
        Universal.sharedInstance.playersList.removeAtIndex(fromIndexPath.row)
        Universal.sharedInstance.playersList.insert(object, atIndex: toIndexPath.row)

    }


    func finishReorderingWithObject(object: AnyObject, atIndexPath indexPath: NSIndexPath) {
        Universal.sharedInstance.playersList[indexPath.row] = object as! Player
        tableView.reloadData()
        mixpanel.track("Reordered Player List")
    }

}
extension PlayerListViewController : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
        if textField.placeholder! == "Player Initials" {
            if count(textField.text) > 3 && range.length == 0{
                return false
            }

        } else if textField.placeholder == "Number of Chips"{

            for chr in string {
                if (!(chr >= "0" && chr <= "9")) {
                    return false
                }
            }
        }
        return true
    }

}