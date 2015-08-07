//
//  ShowdownViewController.swift
//  ChipManager
//
//  Created by Austin Zhang on 8/7/15.
//  Copyright (c) 2015 Austin Zhang. All rights reserved.
//

import Foundation

class ShowdownViewController : UITableViewController{

    var bettingVC : BettingViewController?
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
        return rows!
    }


}

extension ShowdownViewController: UITableViewDelegate {


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