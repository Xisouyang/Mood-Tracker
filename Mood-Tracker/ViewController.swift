//
//  ViewController.swift
//  Hello-TableView
//
//  Created by Stephen Ouyang on 11/8/18.
//  Copyright © 2018 Stephen Ouyang. All rights reserved.
//

import UIKit

struct MoodEntry {
    var mood: Mood
    var date: Date
    
    enum Mood: Int {
        case none
        case amazing
        case good
        case neutral
        case bad
        case terrible
        
        var stringValue: String {
            switch self {
            case .none:
                return ""
            case .amazing:
                return "Amazing"
            case .good:
                return "Good"
            case .neutral:
                return "Neutral"
            case .bad:
                return "Bad"
            case .terrible:
                return "Terrible"
            }
        }
        
        var colorValue: UIColor {
            switch self {
            case .none:
                return .clear
            case .amazing:
                return .green
            case .good:
                return .blue
            case .neutral:
                return .gray
            case .bad:
                return .orange
            case .terrible:
                return .red
            }
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var moodEntries: [MoodEntry] = []
    
    @IBAction func pressAddEntry(_ sender: UIBarButtonItem) {
        
        let now = Date()
        let newMood = MoodEntry(mood: .amazing, date: now)
        moodEntries.insert(newMood, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let goodEntry = MoodEntry(mood: .good, date: Date())
        let badEntry = MoodEntry(mood: .bad, date: Date())
        let neutralEntry = MoodEntry(mood: .neutral, date: Date())
        
        moodEntries = [goodEntry, badEntry, neutralEntry]
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        if let identifier = segue.identifier {
            switch identifier {
            case "show entry details":
                guard
                    let selectedCell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: selectedCell) else {
                        return print("failed to locate index path from sender")
                }
                
                guard let entryDetailsViewController = segue.destination as? MoodDetailedViewController else {
                    return print("storyboard not set up correctly, 'show entry details' segue needs to segue to a 'MoodDetailedViewController'")
                }
                
                let entry = moodEntries[indexPath.row]
                entryDetailsViewController.mood = entry.mood
                entryDetailsViewController.date = entry.date
                
            default: break
            }
        }
    }
}

class MoodEntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewMoodColor: UIImageView!
    @IBOutlet weak var labelMoodTitle: UILabel!
    @IBOutlet weak var labelMoodDate: UILabel!
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //initializing a row
        let cell = tableView.dequeueReusableCell(withIdentifier: "mood entry cell", for: indexPath) as! MoodEntryTableViewCell
        
        //putting things inside the row
        let entry = moodEntries[indexPath.row]
        cell.labelMoodTitle?.text = entry.mood.stringValue
        cell.labelMoodDate?.text = String(describing: entry.date)
        cell.imageViewMoodColor.backgroundColor = entry.mood.colorValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = moodEntries[indexPath.row]
        print("Selected mood was \(selectedEntry.mood.stringValue)")
    }
}

