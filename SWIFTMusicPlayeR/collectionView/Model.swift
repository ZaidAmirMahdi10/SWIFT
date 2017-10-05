//
//  ModelViewController.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-05-28.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import UIKit

//Creating an array to store images
//let covers = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png"]
var covers:Array< String > = Array < String >()
var albums:Array< String > = Array < String >()
var artists:Array< String > = Array < String >()
var songs:Array< String > = Array < String >()


//Getting the data from json
func get_JSON()
{
    if covers.isEmpty == false{
        return
    }
    
    else{
    let url=URL(string:"http://localhost/PlayWithJason%202.0/Albums.json")
    do {
        let allJsonData = try Data(contentsOf: url!)
        let allInfo = try JSONSerialization.jsonObject(with: allJsonData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
        
      //  if let arrJSON = allContacts["data"] as? [[String : Any]] {
        //    for aObject in arrJSON {
          //      if ChooseSubject.mineFagKoder.contains(aObject["subject"] as! String) { ...
                    
        if let Albums = allInfo["Albums"] as? [[String : Any]] {
            for albumObject in Albums{
                
                covers.append(albumObject["album_id"] as! String)
                albums.append(albumObject["album_name"] as! String)
                artists.append(albumObject["artist_name"] as! String)
                
                //Getting all songs
                if let Songs = albumObject["songs"] as? [[String : Any]] {
                    for songObject in Songs {
                        songs.append(songObject["song_name"] as! String)
                    }
                }
            }
        }
      //print(covers)
    }
    catch {
    }
        }
}

//Sending data to MusicPlayer Based on albumID
func getSongs (albumID: Int) -> (Array<Any>, Int, Int)
{
    var songsPerAlbum:Array< String > = Array < String >()
    
    let url=URL(string:"http://mymusicapp.x10host.com/cgi-bin/Albums.json")
    do {
        let allJsonData = try Data(contentsOf: url!)
        let allInfo = try JSONSerialization.jsonObject(with: allJsonData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
       
        if let Albums = allInfo["Albums"] as? [[String : Any]] {
            let albumObject = Albums[albumID]
              //Getting individual songs list by albumID
            //Getting all songs
            if let Songs = albumObject["songs"] as? [[String : Any]] {
                for songObject in Songs {
                        songsPerAlbum.append(songObject["song_name"] as! String)
                     }
            }
        }
    }
    catch {
    }
    
    return (songsPerAlbum,1,2)
}



