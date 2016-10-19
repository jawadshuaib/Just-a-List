//
//  ListVC.swift
//  Super Simple Lists
//
//  Created by Jawad Shuaib on 2016-10-18.
//  Copyright © 2016 Jawad Shuaib. All rights reserved.
//

import UIKit

class ListVC: UITableViewController {

    private var savedLists = [String]()
    //private var savedLists = ["first", "second"]
    private var cellIdentifier = "Cell"
    private let LIST: String = "SAVEDLIST"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    loadData()
    }

    func loadData () {
        let obj = UserDefaults.standard.object(forKey: LIST)
        if let savedArray = obj as? NSArray {
            savedLists = (savedArray as? [String])!
        }
        savedLists.append ("")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell!.textLabel?.text = savedLists[indexPath.row]
        
        return cell!
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // access list item value
        let rowSelected = indexPath.row
        // create alert prompt
        let alert = UIAlertController (title: "Edit Item", message:nil,preferredStyle: UIAlertControllerStyle.alert)
 
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = self.savedLists[rowSelected]
        }
       
        // add save button
        let save = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {(save:UIAlertAction!) in
            
            if alert.textFields![0].text != "" {
                self.savedLists[rowSelected] = alert.textFields![0].text!
                self.savedLists.append ("")
                // save data
                self.saveList ()
                // reload
                self.tableView.reloadData()
            }
                
        })
        
        alert.addAction(save)
        self.present(alert, animated: true)
    }

    func saveList () {
        UserDefaults.standard.set(savedLists, forKey: LIST)
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
