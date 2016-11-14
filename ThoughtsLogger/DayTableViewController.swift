//
//  DayTableViewController.swift
//  ThoughtsLogger
//
//  Created by Nabil Baalbaki on 8/6/16.
//  Copyright © 2016 Nabil Baalbaki. All rights reserved.
//

import UIKit

class DayTableViewController: UITableViewController{

    // MARK: Properties
    
    var days = [String]()
    
    var thoughtString : String = ""
    var filePath : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load files
        loadDays()
    }
    
    func loadDays(){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory( at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            let txtFiles = directoryContents.filter{ $0.pathExtension == "txt" }
            
            days = txtFiles.flatMap({$0.deletingPathExtension().lastPathComponent})
            
            
        } catch{
            print(error)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DayTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DayTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let fileName = days[(indexPath as NSIndexPath).row]
        
        cell.fileLabel.text = fileName
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let fileName = days[(indexPath as NSIndexPath).row] + ".txt"
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            //reading
            do {
                thoughtString = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue) as String
            }
            catch {
                print(error)
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
            let i = (self.tableView.indexPath(for: cell)! as NSIndexPath).row
            
            let fileName = days[i] + ".txt"
            
            if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
                let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
                
                //reading
                do {
                    thoughtString = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue) as String
                }
                catch {
                    print(error)
                }
                
            }
        }
        
        
        let textViewController : TextViewController = segue.destination as! TextViewController
        
        textViewController.thoughtString = thoughtString
    }

}
