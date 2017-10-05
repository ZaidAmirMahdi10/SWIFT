//
//  MusicPlayerController.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-05-29.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var coverImage: UIImageView!
    var coverImageName = Int()
    
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var ArtistNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var albumSongsTable: UITableView!
    
    var Songs:Array< String > = Array < String >()
    var album_id = Int()
    var AlbumName = String ()
    var ArtistName = String ()
    
    var AlbumPath = String ()
    var trackName = String ()
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialization ...
        albumSongsTable.separatorStyle = .none
        
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        
        //Getting the cover image
        coverImageName = album_id + 1
        coverImage.image = UIImage(named: String(coverImageName))
        //Getting the album
        albumNameLabel.text = AlbumName
        //Getting the artist name
        ArtistNameLabel.text = ArtistName
        
        let trackName = getSongs(albumID: album_id).0.first
        let AlbumPath = "Albums/" + AlbumName
        if let audioFilePath = Bundle.main.path(forResource: trackName as? String, ofType: "mp3", inDirectory: AlbumPath) {
            print(audioFilePath)
            
            let mp3URL = URL(fileURLWithPath: audioFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MusicPlayerView.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    //Changing the top status bar color into white
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //Navigate to SearchResultsTable when clicking inside search field
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "SearchResultsTable", sender: self) //here you give the identifier of target ViewController
    }

    //albumSongsTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSongs(albumID: album_id).0.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        cell.textLabel?.text = getSongs(albumID: album_id).0[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let trackName = getSongs(albumID: album_id).0[indexPath.row] as? String
        let AlbumPath = "Albums/" + AlbumName
         if let audioFilePath = Bundle.main.path(forResource: trackName, ofType: "mp3", inDirectory: AlbumPath) {
            print(audioFilePath)
            
            let mp3URL = URL(fileURLWithPath: audioFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MusicPlayerView.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }

    }

//Music Player
    @IBOutlet var LowerButtons: [UIToolbar]!
    @IBAction func playPauseAction(_ sender: Any) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    @IBAction func stopAction(_ sender: Any) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    @IBAction func BackwardAction(_ sender: Any) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0
        
        if time < 0 {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    @IBAction func ForwardAction(_ sender: Any) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0
        
        if time > audioPlayer.duration {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    func updateProgressView(){
        if audioPlayer.isPlaying {
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }
   
    
    //Navigate to Segues (Other view controllers)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Navigate to SearchResultsTable
        if (segue.identifier == "SearchResultsTable") {
        }
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
