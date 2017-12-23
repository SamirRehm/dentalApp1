//
//  Requests.swift
//  dentalApp
//
//  Created by Choi on 2017-12-22.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Requests: PFQueryTableViewController {
    
    override func queryForTable() -> PFQuery<PFObject> {
        let query: PFQuery = PFUser.query()!
        query.order(byAscending: "createdAt")
        query.whereKey("Confirmation", equalTo: false)
        return query
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        let firstname = object?.object(forKey: "firstname") as? String
        let lastname = object?.object(forKey: "lastname") as? String
        let date = object?.object(forKey: "AppointmentDate") as? String
        cell.nameOfPatient.text = firstname! + " " + lastname!
        cell.apptDate.text = date!
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row + 1 > (self.objects?.count)! {
            return 44
        }
        
        let height = super.tableView(tableView, heightForRowAt: indexPath)
        return height
        
    }
    
    
}
