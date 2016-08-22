//
//  ViewController.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSXMLParserDelegate {
    
    @IBOutlet weak var lessionCollectionView: UICollectionView!
    
    var parser: NSXMLParser?
    var lessionArray: [Lession]?
    
    var name: String?
    var sound: String?
    var sentencesArray: [String]?
    var element: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        lessionCollectionView.reloadData()
    }
    
    // MARK: - XML parser
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        
        if elementName == "lession" {
            name = ""
            sound = ""
            sentencesArray = []
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

    // #MARK - collection view datasource function
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (lessionArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = lessionCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        cell.imageview.image = UIImage(named: "lesson_\(indexPath.row + 1)")
        
        return cell;
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        var size = CGSize(width: 10, height: 10)
//        
//        size.width = CGRectGetWidth(collectionView.frame)
//        
//        return size
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let size = CGSize(width: (screenWidth / 3 - 10), height: screenWidth / 10)
        
        return size
    }
    
    
}

