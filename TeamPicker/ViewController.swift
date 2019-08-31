//
//  ViewController.swift
//  TeamPicker
//
//  Created by Bao Nguyen on 3/1/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    //MARK: Properties
    
    @IBOutlet weak var playerCollectionView: UICollectionView!
    var players = [Player]()
    var selectedPlayers = [String : Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func loadData() {
        
        players.append(Player(name: "Bảo Nguyễn", image : UIImage(named: "image1")!,position : "Midfielder", rating: 4))
        players.append(Player(name: "Bin Nguyễn", image : UIImage(named: "Bin")!, position : "Defender", rating: 4))
        players.append(Player(name: "Bi Lê", image : UIImage(named: "Bi")!, position : "Defender", rating: 4))
        players.append(Player(name: "Minh Cường", image : UIImage(named: "Cuong")!, position : "Winger", rating: 3))
        players.append(Player(name: "Đắc Nam Đế", image : UIImage(named: "Dac")!, position : "Defender", rating: 5))
        players.append(Player(name: "Đạt Nguyễn", image : UIImage(named: "Dat")!, position : "Striker", rating: 2))
        players.append(Player(name: "David Lê", image : UIImage(named: "David")!, position : "Winger", rating: 2))
        players.append(Player(name: "Dưỡng Cao", image : UIImage(named: "Duong")!, position : "Striker", rating: 5))
        players.append(Player(name: "Hưng Trần", image : UIImage(named: "Hung")!, position : "Winger", rating: 4))
        players.append(Player(name: "Luân Lê", image : UIImage(named: "Luan")!, position : "Defender", rating: 4))
        players.append(Player(name: "Nha Cao", image : UIImage(named: "Nha")!, position : "Midfielder", rating: 4))
        players.append(Player(name: "Quân Nguyễn", image : UIImage(named: "Quan")!, position : "Goalie", rating: 3))
        players.append(Player(name: "Quang Độc Hành", image : UIImage(named: "Quang")!, position : "Striker", rating: 3))
        players.append(Player(name: "Thắng Nguyễn ", image : UIImage(named: "Thang")!, position : "Striker", rating: 2))
        players.append(Player(name: "Thanh Nguyễn", image : UIImage(named: "Thanh")!, position : "Winger", rating: 3))
        players.append(Player(name: "Thuận Nguyễn", image : UIImage(named: "Thuan")!, position : "Defender", rating: 2))
        players.append(Player(name: "Tú Nguyễn", image : UIImage(named: "Tu")!, position : "Midfielder", rating: 4))
        players.append(Player(name: "Jonny Tuệ", image : UIImage(named: "Tue")!, position : "Defender", rating: 4))
        players.append(Player(name: "Anh Vũ", image : UIImage(named: "Vu")!, position : "Defender", rating: 4))
        players.append(Player(name: "Vũ Trần", image : UIImage(named: "VuLon")!, position : "Defender", rating: 2))
        players.append(Player(name: "Tôn Tôn", image : UIImage(named: "NoImage")!, position : "Defender", rating: 3))
        players.append(Player(name: "Trí Trí", image : UIImage(named: "NoImage")!, position : "Defender", rating: 2))
        players.append(Player(name: "An Đỗ", image : UIImage(named: "An")!, position : "Defender", rating: 3))
        
        /*
         if let nsData = NSData(contentsOf: Player.ArchiveURL) {
         do {
         
         let data = Data(referencing:nsData)
         
         if let loadedPlayers = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Player] {
         players = loadedPlayers
         }
         } catch {
         print("Couldn't read file.")
         }
         }
         */
        
    }
    
    //MARK: UICollectionView Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell
        let player = players[indexPath.row]
        cell?.nameLabel.text = player.name
        cell?.playerImage.image = player.image
        return cell!
    }
    
    //MARK: UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = playerCollectionView.cellForItem(at: indexPath) as! PlayerCollectionViewCell
        if cell.isSlect {
            cell.playerImage.layer.borderWidth = 0
            cell.isSlect = false
            selectedPlayers.removeValue(forKey: players[indexPath.row].name)
        } else {
            cell.playerImage.layer.borderColor = UIColor.red.cgColor
            cell.playerImage.layer.borderWidth = 2
            cell.isSlect = true
            let newPlayer = players[indexPath.row]
            selectedPlayers[newPlayer.name] = newPlayer
        }
        
        
        
    }
    
    //MARK: Actions
    @IBAction func doneSelection(_ sender: UIBarButtonItem) {
       
        
    }
    
    
    @IBAction func SelectionDone(_ sender: UIBarButtonItem) {
        for (_, player) in selectedPlayers {
            print(player.name)
        }
        
        performSegue(withIdentifier: "SelectTeam", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SelectTeam") {
            let destination = segue.destination as! SelectTeamViewController
            destination.dataFromCollection = self.selectedPlayers
        }
        
    }
    
    @IBAction func SaveFile(_ sender: UIBarButtonItem) {
        //let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(players, toFile: //Player.ArchiveURL.path)
        //NSKeyedArchiver.archivedData(withRootObject: Player.ArchiveURL.path, requiringSecureCoding: false).
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: players, requiringSecureCoding: false)
            try data.write(to: Player.ArchiveURL)
            os_log("Players successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save players...", log: OSLog.default, type: .error)
        }
        
        
    }
    
}

