    //
//  BuyAssetTVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 05/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
    
struct B4UAsset {
    var key,wallet,description,ammount:String
    
}

class BuyAssetTVC: UITableViewController {

    var delegate: HashgraphMessages!
    var walletId = ""
    var assetList = [B4UAsset]()
    var chosenAsset = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let message = "AL|\n"
        let result = delegate.messageToHashgraph(message)
        
        print("Result is:\(result)")
        
        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "¬")
        if resultArray.count >= 2 {
            if resultArray[0] == "AL" {
                for i in (1..<resultArray.count) {
                    let items = resultArray[i].components(separatedBy: "|")
                    if items.count >= 4 {
                        let asset = B4UAsset(key: items[0], wallet: items[1], description: items[2], ammount: items[3])
                        assetList.append(asset)
                    }
                }
            }
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
        }

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
        return assetList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assetCell", for: indexPath)

        // Configure the cell...
        let description = cell.viewWithTag(1) as? UILabel
        let ammount = cell.viewWithTag(2) as? UILabel
        let asset = assetList[indexPath.row]
        description!.text = asset.description
        ammount!.text = asset.ammount

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
            if chosenAsset < assetList.count {
                let destViewController = segue.destination as! BuyVC
                destViewController.delegate = delegate
                destViewController.walletId = walletId
                destViewController.asset = assetList[chosenAsset]
            }
        }
    }


}
