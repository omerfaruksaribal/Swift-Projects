//
//  ViewController.swift
//  Storm-Viewer
//
//  Created by Ömerfaruk Saribal on 15.02.2025.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    @objc func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        var loadedPictures = [String]()
        
        for item in items {
            if item.hasPrefix("nssl"){
                // this is a picture we want to load
                loadedPictures.append(item)
            }
        }
        loadedPictures.sort()
        
        performSelector(onMainThread: #selector(updateUI), with: loadedPictures, waitUntilDone: false)
    }
    
    @objc func updateUI(_ loadedPictures: [String]) {
        pictures = loadedPictures
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

