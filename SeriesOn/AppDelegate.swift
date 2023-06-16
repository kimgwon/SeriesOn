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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 데이터를 가져오는 로직
        if let csvFilePath = Bundle.main.path(forResource: "movies_metadata", ofType: "csv") {
            let movies = DataParser.parseMoviesData(fromCSVFile: csvFilePath)

            // 가져온 데이터를 활용하여 원하는 동작을 수행하거나 콘솔에 출력
            for movie in movies {
                print(movie)
            }
        } else {
            print("Failed to find movies_metadata.csv")
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

