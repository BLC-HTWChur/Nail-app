//
//  ProfileViewController.swift
//  Nail-app
//
//  Created by Blended Learning Center on 18.01.18.
//  Copyright © 2018 Blended Learning Center. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource : [String: Any]?
    var keysHeader : [String]?
    var keysPayload : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var jsonDict : [String : Any]
        if dataSource == nil {
            return
        }
        jsonDict = dataSource!["header"] as! [String:Any]
        keysHeader = Array(jsonDict.keys) as [String]
        jsonDict = dataSource!["payload"] as! [String: Any]
        keysPayload = Array(jsonDict.keys) as [String]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.flashScrollIndicators()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dataSource?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 0
        case 1:
            return (keysHeader?.count)!
        case 2:
            return (keysPayload?.count)!
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID TOKEN"
        case 1:
            return "HEADER"
        case 2:
            return "PAYLOAD"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        switch indexPath.section {
        case 1:
            let ds = dataSource!["header"] as! [String:Any]
            
            cell?.textLabel?.text = keysHeader?[indexPath.row]
            cell?.detailTextLabel?.text = ds[keysHeader![indexPath.row]] as? String
        case 2:
            let ds = dataSource!["payload"] as! [String : Any]
            
            cell?.textLabel?.text = keysPayload?[indexPath.row]
            cell?.detailTextLabel?.text = String (describing: ds[keysPayload![indexPath.row]]!)
        default:
            print("")
        }
        
        return cell!
    }
    
    
    
    
}
