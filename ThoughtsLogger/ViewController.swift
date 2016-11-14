//
//  ViewController.swift
//  ThoughtsLogger
//
//  Created by Nabil Baalbaki on 7/30/16.
//  Copyright © 2016 Nabil Baalbaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MAKE: Properties
    var fileName : String = ""
    var filePath : String = ""
    var todayDate : String = ""
    var thoughtTime : String = ""
    @IBOutlet weak var thoughtTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPaths()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MAKE: Actions
    @IBAction func saveThought(_ sender: UIButton) {
        
        let thoughtStr = thoughtTextField.text! + " " + thoughtTime + "\n"
        
        //Temp
        let fileManager = FileManager.default
        
        if(fileManager.fileExists(atPath: filePath))
        {
            //Append to file
            if let fileHandle = FileHandle(forWritingAtPath: filePath) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(thoughtStr.data(using: String.Encoding.utf8)!)
                fileHandle.closeFile()
                thoughtTextField.text = ""
            }
            else {
                print("Couldn't open file handler")
            }
        }
        else {
            //Create file
            do {
                try thoughtStr.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                thoughtTextField.text = ""
            } catch {
                print("Error info: \(error)")
            }
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    func getTodayDate() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.string(from: date)
    }
    
    func initPaths(){
        
        todayDate = getTodayDate()
        thoughtTime = todayDate.substring(from: todayDate.characters.index(of : ",")!)
        fileName = todayDate.substring(to: todayDate.characters.index(of: ",")!)
        fileName = fileName.replacingOccurrences(of: "/", with: "-")
        filePath = getDocumentsDirectory().appendingPathComponent(fileName + ".txt")
    }
}

