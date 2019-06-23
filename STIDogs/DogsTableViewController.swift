//
//  DogsTableViewController.swift
//  STIDogs
//
//  Created by Hari Rao on 6/15/19.
//  Copyright © 2019 hariDasu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DogsTableViewController: UITableViewController {
    var dogBreeds = [String: JSON]()
    var sections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDogBreeds()
        
    }
    
    func getDogBreeds(){
        Alamofire.request("https://dog.ceo/api/breeds/list/all")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let breedData = JSON(response.result.value!)["message"]
                    let breedDict = Dictionary(uniqueKeysWithValues:breedData)
                    let dogsWithSubBreeds = breedDict.filter { key, value in
                        return value.count > 0
                    }
                    self.dogBreeds = dogsWithSubBreeds
                    self.sections = Array(self.dogBreeds.keys)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
        }
    }
    
    
    func getImagesForBreed(dogBreed: String, dogBreedUrl: String, completion: @escaping ([String]?) -> Void) {
        Alamofire.request(dogBreedUrl)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let breedArray = JSON(response.result.value!)["message"]
                    let breedDict = Dictionary(uniqueKeysWithValues:breedArray)
                    let stringbreeds = breedDict.map{ "\($1)" }
                    let filteredResults = stringbreeds.filter{
                        $0.components(separatedBy: "/")[4]==dogBreed
                    }
                    completion(filteredResults);
                case .failure(let error):
                    print(error)
                }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.dogBreeds.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let count = self.dogBreeds[self.sections[section]]?.count else { return 0 }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let dogDict = Dictionary(uniqueKeysWithValues: self.dogBreeds[self.sections[indexPath.section]]!)
        let dogTitle = dogDict["\(indexPath.item)"]
        cell.textLabel?.text = dogTitle?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dogBreed = Array(self.dogBreeds.keys)[indexPath.section]
        let dogBreedCollectionVC = DogBreedCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let dogDict = Dictionary(uniqueKeysWithValues: self.dogBreeds[self.sections[indexPath.section]]!)
        let dogTitle = dogDict["\(indexPath.item)"]
        let dogBreedUrl = "https://dog.ceo/api/breed/\(dogBreed)/images"
        let dogBreedString = "\(dogBreed)-\(dogTitle!)";
        self.getImagesForBreed(dogBreed: dogBreedString, dogBreedUrl: dogBreedUrl){ results in
            dogBreedCollectionVC.imgUrls=results!
            self.navigationController?.pushViewController(dogBreedCollectionVC, animated: true)
        }
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
