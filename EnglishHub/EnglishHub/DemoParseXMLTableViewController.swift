//
//  DemoParseXMLTableViewController.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class DemoParseXMLTableViewController: UITableViewController, NSXMLParserDelegate {
    
    @IBOutlet var conversationTableView: UITableView!
    
    var parser: NSXMLParser?
    var lessionArray: [Lession]?
    
    var name: String?
    var sound: String?
    var sentencesArray: [String]?
    //var questions: [Questionaire]?
    var element: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.parseXLMFromFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseXLMFromFile() {
        lessionArray = []
        // get url file
        let urlpath = NSBundle.mainBundle().pathForResource("basic", ofType: "xml")
        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
        // get parse data
        parser = NSXMLParser(contentsOfURL: url)
        parser?.delegate = self;
        parser?.parse()
        conversationTableView.reloadData()
    }
    
    // MARK: - XML parser
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        
        if elementName == "lession" {
            name = ""
            sound = ""
            sentencesArray = []
            //questions = []
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element == "name" {
            name = string
            element = ""
        }
        if element == "sound" {
            sound = string
            element = ""
        }
        if element == "sentence" {
            sentencesArray?.append(string)
            element = ""
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "lession" {

            
            let lession = Lession(name: name!, sound: sound!, sentencesArray: sentencesArray!)
            lessionArray?.append(lession)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (lessionArray?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = lessionArray![indexPath.row].name

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
