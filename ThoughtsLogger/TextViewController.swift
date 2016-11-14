//
//  TextViewController.swift
//  ThoughtsLogger
//
//  Created by Nabil Baalbaki on 8/7/16.
//  Copyright © 2016 Nabil Baalbaki. All rights reserved.
//

import Foundation
import UIKit

class TextViewController: UIViewController {
    
    // MAKE: Properties
    @IBOutlet weak var thoughtTextView: UITextView!
    
    var thoughtString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thoughtTextView.text = thoughtString
        adjustSize()
    }
    
    func adjustSize(){
        let fixedWidth = thoughtTextView.frame.size.width
        thoughtTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = thoughtTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = thoughtTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        thoughtTextView.frame = newFrame;
    }
}
