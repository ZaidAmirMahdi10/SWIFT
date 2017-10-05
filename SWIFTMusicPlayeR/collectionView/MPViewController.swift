//
//  MPViewController.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-05-20.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import UIKit


class MPViewController: UIViewController {
    
    @IBOutlet weak var nameOfImage: UILabel!
    
    var labelText = String()
    
    override func viewDidLoad() {
        
        nameOfImage.text = labelText
        
        // Getting the songs from Model class
        print(getSongs(albumID: Int(labelText)!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
