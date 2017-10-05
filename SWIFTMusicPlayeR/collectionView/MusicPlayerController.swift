//
//  MusicPlayerController.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-05-29.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import UIKit

class MusicPlayerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var album_id = Int()
    var Songs:Array< String > = Array < String >()
    let covers = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png"]
    
   
    
    
    var coverImageName = Int()
    
   
    
    @IBOutlet weak var albumNameLabel: UILabel!
    var albumNameLabelName = String()
    
    
    
    @IBOutlet weak var ArtistNameLabel: UILabel!
    var ArtistNameLabelName = String()
    
   
    @IBOutlet weak var albumSongsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialization ...
         albumSongsTable.separatorStyle = .none
        //Getting the cover image
        coverImageName = album_id + 1
        coverImageName.image = UIImage(named: String(coverImageName))
        //Getting the album
        albumNameLabel.text = albumNameLabelName
        //Getting the artist name
        ArtistNameLabel.text = ArtistNameLabelName
        
        
        // Getting the songs from Model class
        getSongs(albumID: album_id)
        
        
    }

    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return getSongs(albumID: album_id).0.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        
        cell.textLabel?.text = getSongs(albumID: album_id).0[indexPath.row] as? String
        
        return cell
    }

    func printing () -> Array<Any> {
        let Songs = getSongs(albumID: album_id).0
        
        return Songs
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
