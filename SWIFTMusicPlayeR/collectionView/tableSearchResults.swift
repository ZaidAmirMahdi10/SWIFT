//
//  File.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-06-06.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import Foundation
import UIKit

//Values to be sent to music player controller
private var SelectedItem  = 0
private var SelectedAlbum  = String()
private var SelectedArtist = String()

class tableSearchResults: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

//Changing the top status bar color into white

//Return Button to previous view controller
@IBAction func ReturnButton(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    dismiss(animated: true, completion: nil)
}

//The search bar function that converts input to lowercase and filters the data
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = albums.filter({ (names: String) -> Bool in
        return names.lowercased().range(of: searchText.lowercased()) != nil
    })
    
    if searchText != ""
    {
        isSearching = true
        self.tableView.reloadData()
    }
    else
    {
        isSearching = false
        self.tableView.reloadData()
    }
}

//When clicking on search field
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    isSearching = true
    SearchBar.endEditing(true)
    self.tableView.reloadData()
}


@available(iOS 2.0, *)
public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    if isSearching{
        return filteredData.count
    }
    return (albums.count)
}

@available(iOS 2.0, *)
public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    
    if isSearching{
        cell.AlbumName.text = filteredData[indexPath.row]
        return cell
    } else {
        cell.AlbumName.text = albums[indexPath.row]
        return cell
    }
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if isSearching{
        SelectedAlbum = filteredData[indexPath.row] as String
        SelectedItem = getSearchedID(searchedItem: SelectedAlbum)
        print("AlbumID : ", SelectedItem)
        print(SelectedAlbum)
        performSegue(withIdentifier: "MusicPlayerView", sender: self) //here you give the identifier of target ViewController
    }
        
    else {
        SelectedItem = indexPath.row
        SelectedAlbum = albums[indexPath.row] as String
        print("AlbumID : ", SelectedItem)
        print(SelectedAlbum)
        performSegue(withIdentifier: "MusicPlayerView", sender: self) //here you give the identifier of target ViewController
    }
}

func getSearchedID(searchedItem: String) -> Int {
    
    let indexOfItem = albums.index(of: searchedItem) //
    
    return indexOfItem!
}

//Navigate to Segues (Other view controllers)
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //Navigate to MPViewController
    if (segue.identifier == "MusicPlayerView") {
        let DestViewController = segue.destination as! MusicPlayerView
        DestViewController.album_id = SelectedItem
        DestViewController.AlbumName = SelectedAlbum
    }
}

}
