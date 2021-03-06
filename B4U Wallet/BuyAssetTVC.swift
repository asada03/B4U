    //
//  BuyAssetTVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 05/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
    
class BuyAssetTVC: UITableViewController {

    var delegate: HashgraphMessages!
    var walletId = ""
    var chosenAsset = 0;
    
    var assets = [DataSnapshot]()
    var images = [UIImage!]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storage = Storage.storage()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        let message = "AL|\n"
//        let result = delegate.messageToHashgraph(message)
//
//        print("Result is:\(result)")
//
//        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "¬")
//        if resultArray.count >= 2 {
//            if resultArray[0] == "AL" {
//                for i in (1..<resultArray.count) {
//                    let items = resultArray[i].components(separatedBy: "|")
//                    if items.count >= 4 {
//                        let asset = B4UAsset(key: items[0], wallet: items[1], description: items[2], ammount: items[3])
//                        assetList.append(asset)
//                    }
//                }
//            }
//            else if resultArray[0] == "ER" {
//                // create the alert
//                let alert = UIAlertController(title: "Error", message: "Hubo un error de comunicación. Verifique su conexión a Internet e intente de nuevo.", preferredStyle: UIAlertControllerStyle.alert)
//
//                // add an action (button)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//                // show the alert
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
        
        func indexOfAsset(_ inAsset:DataSnapshot) -> Int!{
            for i in self.assets.indices {
                let asset = self.assets[i]
                if asset.key == inAsset.key {
                    return i
                }
            }
            return nil
        }


        let ref = Database.database().reference().child("Assets")
        // Listen for new comments in the Firebase database
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            self.assets.append(snapshot)
            self.images.append(nil)
            
            let index = self.assets.count - 1
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
            let pathReference = storage.reference(withPath: "\(snapshot.key)/0.jpg")
            
            // Download in memory with a maximum allowed size of 4MB (4 * 1024 * 1024 bytes)
            pathReference.getData(maxSize: 4_194_304) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print(error.localizedDescription)
                } else {
                    // Data for "images/island.jpg" is returned
                    if index < self.images.count {
                        self.images[index] = UIImage(data: data!)
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }
        })
        // Listen for deleted comments in the Firebase database
        ref.observe(.childRemoved, with: { (snapshot) -> Void in
            if let index = indexOfAsset(snapshot){
                self.assets.remove(at: index)
                self.images.remove(at: index)
                //self.tableView.reloadData()
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assetCell", for: indexPath) as! AssetTableViewCell

        // Configure the cell...
        
        let asset = assets[indexPath.row]
        if let value = asset.value as? Dictionary<String,Any> {
            cell.titleLabel.text = value["title"] as? String ?? ""
            cell.priceLabel.text = "\(value["price"] as? Float ?? 0.0)"
        }
        
        if let image = images[indexPath.row] {
            cell.imageView?.image = image
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenAsset = indexPath.row
        self.performSegue(withIdentifier: "buySegue", sender: self)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: HashgraphMessages delegate
    func messageToHashgraph(_ message: String) -> String {
        return delegate.messageToHashgraph(message)
    }
    
    func setInfo(name: String, id: String, balance: String) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buySegue" {
            if chosenAsset < assets.count {
                let destViewController = segue.destination as! BuyVC
                destViewController.delegate = delegate
                destViewController.walletId = walletId
                destViewController.asset = assets[chosenAsset]
            }
        }
    }


}
