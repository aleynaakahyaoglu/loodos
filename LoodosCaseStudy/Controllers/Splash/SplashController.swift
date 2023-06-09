//
//  SplashController.swift
//  LoodosCaseStudy
//
//  Created by Aleyna on 1.06.2023.
//

import UIKit
import SwiftUI
import Firebase
import Network

class SplashController: UIViewController {
    
    @IBOutlet weak var messageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        configure()
    }
    func monitorNetwork(){
        let message = NWPathMonitor()
        message.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    
                    UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 4.0,
                                   options: .curveLinear, animations: {() -> Void in
                        self.messageTitle.center = CGPoint(x:100, y:70)
                    }, completion: nil)
                    self.messageTitle.text = "Loodos"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.performSegue(withIdentifier: Segues.splashToHomePage, sender: nil)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.messageTitle.text = "İnternet Bağlantınızı Kontrol Edin"
                }
            }
        }
        
        let queue = DispatchQueue(label:"Network")
        message.start(queue: queue)
    }}

    func configure(){
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { changed, error in
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }}
