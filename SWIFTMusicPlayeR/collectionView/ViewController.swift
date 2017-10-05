//
//  ViewController.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-04-14.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//
import UIKit

//Values to be sent to music player controller
private var SelectedItem  = 0
private var SelectedAlbum  = String()
private var SelectedArtist = String()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SearchBar: UISearchBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView!.contentInset = UIEdgeInsets(top: 60, left: 30, bottom: 10, right: 30)
        
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        
        //Getting JSON data from Model Class
        get_JSON()
    }

    //Changing the top status bar color into white
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //Navigate to SearchResultsTable when clicking inside search field
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "SearchResultsTable", sender: self) //here you give the identifier of target ViewController
    }
    
    //Check it later :)
    func showSearchResults(sender: AnyObject) {
        let resultsController = UITableViewController(style: .plain)
        let searchController  = UISearchController(searchResultsController: resultsController)
        self.present(searchController, animated: true, completion: nil)
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Adding images to the rows of the collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covers.count
    }
    

    
    //Adding the data to each cell of the collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
            
            cell.AlbumCover.image = UIImage(named: covers[indexPath.row])
            cell.AlbumName.text = albums[indexPath.row] // Adding album names to cell
            cell.ArtistName.text = artists[indexPath.row] // Adding album names to cell
            return cell
        } else {
            return CollectionViewCell()
        }
    }
 
    // Change border color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 1.0
        cell?.layer.borderColor = UIColor.blue.cgColor
    }
    
    // Change border color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 1.0
        cell?.layer.borderColor = UIColor.blue.cgColor
    }
    
    //Printinig the selected image ID in console
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        SelectedItem = indexPath.row
        SelectedAlbum = albums[indexPath.row] as String
        SelectedArtist = artists[indexPath.row] as String
        print("AlbumID : ", SelectedItem)
        print(SelectedAlbum)
        print(SelectedArtist)
        
        performSegue(withIdentifier: "MusicPlayerView", sender: self) //here you give the identifier of target ViewController
    }
    
    //Navigate to Segues (Other view controllers)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Navigate to MPViewController
        if (segue.identifier == "MusicPlayerView") {
            let DestViewController = segue.destination as! MusicPlayerView
            DestViewController.album_id = SelectedItem
            DestViewController.AlbumName = SelectedAlbum
            DestViewController.ArtistName = SelectedArtist
        }
        //Navigate to SearchResultsTable 
        if (segue.identifier == "SearchResultsTable") {
        }
    }
}






