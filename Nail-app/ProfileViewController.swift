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
    var keys : [String]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var jsonDict : [String : Any]
        if dataSource == nil {
            return
        }
//        jsonDict = dataSource!["header"] as! [String:Any]
        self.keys = Array(dataSource!.keys)
        
    
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic =  self.dataSource![(keys?.first)!] as! [String : Any]
        return (dic.keys.count)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Auth TOKEN"
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
        cell?.textLabel?.text = keys?[indexPath.row]

        guard let data = dataSource![ keys![indexPath.row]] else {
            return cell!
        }
        
        cell?.detailTextLabel?.text = String(describing : data)
    
        
        return cell!
    }
    
    
    
    
}
