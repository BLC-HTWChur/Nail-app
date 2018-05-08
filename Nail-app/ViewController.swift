//
//  ViewController.swift
//  Nail-app
//
//  Created by Blended Learning Center on 18.01.18.
//  Copyright © 2018 Blended Learning Center. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var dataSource  : [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showToken(_ sender: Any) {
        
        
        let item = "org.moodle.moodle_mobile_app"
        let singleton = false
        print("IN PLUGIN SWIFT , singleton : \(singleton)")
        
        let activityVC = UIActivityViewController(activityItems: [item, singleton.description], applicationActivities: nil)
        DispatchQueue.main.async {
            self.present(activityVC, animated: true, completion: nil)
        }
        
        
        activityVC.completionWithItemsHandler = {
            activityType , completed, returnedItems, error in
            
            print("COMPLETED : \(completed)")
            if returnedItems == nil || (returnedItems!.count <= 0) {
                print("No Item found from extension")
                self.showAlert()
                return
            }
            let itemEx : NSExtensionItem = returnedItems?.first as! NSExtensionItem
            self.extractDataFromExtension(item: itemEx)
        }
        
    }
    
    func extractDataFromExtension(item : NSExtensionItem){
        let itemProvider = item.attachments?.first as! NSItemProvider
        
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeJSON as String){
            itemProvider.loadItem(forTypeIdentifier: kUTTypeJSON as String, options: nil, completionHandler: { (data, error) -> Void in
                if error != nil {
                    print("error on extracting data from extension , \(error.localizedDescription)")
                    return
                }
                let jsonData = data as! Data
                do{
                    self.dataSource = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    print(self.dataSource!)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toProfile", sender: self)
                    }
                } catch{
                    print(error)
                    return
                }
            })
            
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No Login Data found", message: "Please login on the edu id app first to proceed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close App", style: .default, handler: { (alertAction) in
            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        }))
        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "open eduid app", style: .default, handler: { (_) in
            let url = "eduid-iOS://"
            if UIApplication.shared.canOpenURL(URL(string: url)!){
                UIApplication.shared.open(URL(string: url)! , options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "toProfile" {
            return
        }
        
        let destinationVC = segue.destination as! ProfileViewController
        destinationVC.dataSource = self.dataSource
        
    }
    
}

