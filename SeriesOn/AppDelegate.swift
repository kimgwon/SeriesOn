//
//  AppDelegate.swift
//  SeriesOn
//
//  Created by keem on 2023/06/05.
//

import UIKit
import Foundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let AD = UIApplication.shared.delegate as? AppDelegate
    var movies: [Movie] = []
    var credits: [Credit] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 데이터를 가져오는 로직
        if let jsonFilePath = Bundle.main.path(forResource: "movies_metadata", ofType: "json") {
            movies = DataParser.parseMoviesData(fromJSONFile: jsonFilePath)
            AD?.movies = self.movies
        } else {
            print("Failed to find movies_metadata.json")
        }

        // 데이터를 가져오는 로직
        if let jsonFilePath = Bundle.main.path(forResource: "credits", ofType: "json") {
            credits = DataParser.parseCredits(fromJSONFile: jsonFilePath)
            AD?.credits = self.credits
            
        } else {
            print("Failed to find movies_metadata.json")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
