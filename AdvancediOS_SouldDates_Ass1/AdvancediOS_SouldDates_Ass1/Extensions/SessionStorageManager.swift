//
//  SessionStorageManager.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 12/9/2023.
//

import Foundation

class SessionStorageManager {
    
    private static let SESSION_MATCH_SEEKER_KEY = "matchSeekerKey"
    private static let SESSION_ID_KEY = "sessionIdKey"
    private static let DREAM_LIST_KEY = "dreamListKey"
    private static let defaults = UserDefaults.standard
    
    //stores the matchSeeker that was used during the session into user defaults.
    //this also includes dating preferences
    static func setMatchSeekerToUserDefaults(currentMatchSeeker: MatchSeeker)  {
        defaults.set(try? PropertyListEncoder().encode(currentMatchSeeker), forKey: SESSION_MATCH_SEEKER_KEY)
    }
    
    //reads the matchSeeker object from userDefaults
    static func readMatchSeekerFromUserDefaults() -> MatchSeeker? {
        if let savedMatchSeeker = defaults.value(forKey: SESSION_MATCH_SEEKER_KEY) as? Data {
            if let matchSeeker = try? PropertyListDecoder().decode(MatchSeeker.self, from: savedMatchSeeker) {
                return matchSeeker
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    static func saveDreamList(dreamlist: [MatchSeeker]) {
        defaults.set(try? PropertyListEncoder().encode(dreamlist), forKey: DREAM_LIST_KEY)
    }
    
    static func loadDreamList() -> [MatchSeeker] {
        if let savedDreamList = defaults.value(forKey: DREAM_LIST_KEY) as? Data {
            if let dreamList = try? PropertyListDecoder().decode([MatchSeeker].self, from: savedDreamList) {
                return dreamList
            } else {
                return []
            }
        }
        else {
            return []
        }
    }
    
    //this will clear saved data from user defaults when a match seeker resets the settings.
    static func clearEverthing() {
        defaults.removeObject(forKey: DREAM_LIST_KEY)
        defaults.removeObject(forKey: SESSION_MATCH_SEEKER_KEY)
    }
    
}
