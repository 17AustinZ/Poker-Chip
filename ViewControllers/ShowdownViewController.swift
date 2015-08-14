//
//  ShowdownViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/7/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation
import Mixpanel

class ShowdownViewController : UITableViewController{

    var mixpanel = Mixpanel.sharedInstance()
    var winners : [Player]?
    var bettingVC : BettingViewController?

    override func viewDidLoad() {

        super.viewDidLoad()
        mixpanel.track("Opened View Controller", properties: ["View Controller" : "Showdown"])

    }
    func getWinners() -> [Player]{
        winners = []
        for i in 0..<tableView.numberOfRowsInSection(0){
            var path = NSIndexPath(forRow: i, inSection: 0)
            var cell =  tableView.cellForRowAtIndexPath(path)
            if cell?.accessoryType == UITableViewCellAccessoryType.Checkmark{
                winners?.append(bettingVC!.buttons[path.row].player!)
            }

        }
        return winners!
    }

}

extension ShowdownViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCellWithIdentifier("ShowdownCell", forIndexPath: indexPath) as! ShowdownTableViewCell
        cell.name = bettingVC?.buttons[indexPath.row].player?.name

        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let rows = bettingVC?.buttons.count
        if let rows = rows {
            return rows
        }
        return 0

    }



}

extension ShowdownViewController: UITableViewDelegate {


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell!.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell?.accessoryType = UITableViewCellAccessoryType.None
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark

//            winners?.append(bettingVC!.buttons[indexPath.row].player!)
        }

    }


    // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {


    }






}