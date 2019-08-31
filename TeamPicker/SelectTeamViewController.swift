//
//  SelectTeamViewController.swift
//  TeamPicker
//
//  Created by Bao Nguyen on 3/2/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

class SelectTeamViewController: UIViewController {
    
    //MARK: Properties
    var dataFromCollection = [String : Player]()
    var players = [Player]()
    
    @IBOutlet weak var playersLabel: UILabel!
    
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Label: UILabel!
    
    var allPlayers = ""
    var team1Players = ""
    var team2Players = ""
    var fiveStarPlayers = [Player]()
    var fourStarPlayers = [Player]()
    var threeStarPlayers = [Player]()
    var twoStarPlayers = [Player]()
    var oneStarPlayers = [Player]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllPlayer()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Actions
    func loadAllPlayer(){
        if dataFromCollection.count == 0 {
            return
        }
        print("size of dic: " + String (dataFromCollection.count))
        for (name, player) in dataFromCollection {
            allPlayers = allPlayers + name + " - "
            players.append(player)
            switch player.rating {
            case 4 :
                fourStarPlayers.append(player)
            case 3 :
                threeStarPlayers.append(player)
            case 2:
                twoStarPlayers.append(player)
            default:
                print("No default")
            }
            
            
           
        }
        print("after sort")
        players.sort(by: {player1, player2 in player1.rating > player2.rating})
        for player in players {
            print(player.name)
        }
        allPlayers.removeLast()
        allPlayers.removeLast()
        playersLabel.text = allPlayers
    }
    
    func equalSizeTeam() {
        let allPlayerCount = dataFromCollection.count
        var sumTeam1 = 0
        var sumTeam2 = 0
        fourStarPlayers.shuffle()
        threeStarPlayers.shuffle()
        twoStarPlayers.shuffle()
        for _ in 0..<allPlayerCount/2 {
           
            //let first = players[index*2]
            //let second = players[index*2 + 1]
            
            let first = selectHighestplayer()
            let second = selectHighestplayer()
            
            if(sumTeam1 <= sumTeam2) {
                team1Players = team1Players + first.name + " - "
                team2Players = team2Players + second.name + " - "
                sumTeam1 += first.rating
                sumTeam2 += second.rating
            } else {
                team1Players = team1Players + second.name + " - "
                team2Players = team2Players + first.name + " - "
                sumTeam1 += second.rating
                sumTeam2 += first.rating
            }
        }
        
        team1Label.text = team1Players
        team2Label.text = team2Players
    }
    
    func unequalSizeTeam() {
        let allPlayerCount = dataFromCollection.count
        
        fourStarPlayers.shuffle()
        threeStarPlayers.shuffle()
        twoStarPlayers.shuffle()
        for _ in 0...1 {
            let second = selectLowestplayer()
            team2Players = team2Players + second.name + " - "
           
        }
        let first = selectHighestplayer()
        team1Players = team1Players + first.name + " - "
        
        for _ in 0..<(allPlayerCount-3)/2 {
            
            //let first = players[index*2]
            //let second = players[index*2 + 1]
            
            let first = selectHighestplayer()
            let second = selectHighestplayer()
            team1Players = team1Players + first.name + " - "
            team2Players = team2Players + second.name + " - "
            
        }
        
        team1Label.text = team1Players
        team2Label.text = team2Players
    }
    
    func selectHighestplayer() -> Player {
        if(fiveStarPlayers.count != 0){
            return fiveStarPlayers.remove(at: 0)
        } else if (fourStarPlayers.count != 0) {
            return fourStarPlayers.remove(at: 0)
        } else if (threeStarPlayers.count != 0) {
            return threeStarPlayers.remove(at: 0)
        } else if (twoStarPlayers.count != 0) {
            return twoStarPlayers.remove(at: 0)
        } else {
            return oneStarPlayers.remove(at: 0)
        }
    }

    func selectLowestplayer() -> Player {
        if(oneStarPlayers.count != 0){
            return oneStarPlayers.remove(at: 0)
        } else if (twoStarPlayers.count != 0) {
            return twoStarPlayers.remove(at: 0)
        } else if (threeStarPlayers.count != 0) {
            return threeStarPlayers.remove(at: 0)
        } else if (fourStarPlayers.count != 0) {
            return fourStarPlayers.remove(at: 0)
        }
        else {
            return fiveStarPlayers.remove(at: 0)
        }
    }
    
    @IBAction func DivideTeam(_ sender: UIButton) {
        fourStarPlayers.removeAll()
        threeStarPlayers.removeAll()
        twoStarPlayers.removeAll()
        for (_, player) in dataFromCollection {
            switch player.rating {
            case 5 :
                fiveStarPlayers.append(player)
            case 4 :
                fourStarPlayers.append(player)
            case 3 :
                threeStarPlayers.append(player)
            case 2:
                twoStarPlayers.append(player)
            case 1:
                oneStarPlayers.append(player)
            default:
                print("No default")
            }
        }
        team1Label.text = ""
        team2Label.text = ""
        team1Players = ""
        team2Players = ""
        if dataFromCollection.count % 2 == 0 {
            //
            equalSizeTeam()
        } else {
            unequalSizeTeam()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
