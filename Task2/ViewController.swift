//
//  ViewController.swift
//  Task1
//
//  Created by Sabari on 3/31/17.
//  Copyright © 2017 Sabari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calenderCollection1: UICollectionView!
   
    var urlString = Url()
    var session = URLSession()
    var task = URLSessionDataTask()
    var jsonCollection1Data = NSDictionary()
    var jsonCollection2Data = NSDictionary()
    var getArrayjson1 = NSArray()
    var getArrayjson2 = NSArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        session = URLSession.shared
        //set corner radius and border for button
        ShareButton.layer.cornerRadius = 5
        ShareButton.layer.masksToBounds = true
        ShareButton.layer.borderColor = UIColor.lightGray.cgColor
        ShareButton.layer.borderWidth = 1
        self.getCollection1Data()
        self.getCollection2Data()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                if(collectionView == calenderCollection1)
        {
            return getArrayjson2.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
                if(collectionView == calenderCollection1)
        {
            let cell3 = self.calenderCollection1.dequeueReusableCell(withReuseIdentifier: "Calendercell3", for: indexPath) as! CallenderCollectionViewCell3
            cell3.layer.cornerRadius = 5
            cell3.layer.masksToBounds = true
            
            cell3.titleText.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Title") as? String
            cell3.descriptionText.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Description") as? String
            let imageName = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Image") as? String
            
            cell3.mainImage.image = UIImage(named: imageName!)
            return cell3
        }
        return cell
    }
        func getCollection1Data()
    {
        
        let urlValue = URL(string: urlString.collectionUrl)!
        task = session.dataTask(with: urlValue, completionHandler: {(data, response, error)in
            
            if(error != nil)
            {
                print(error!.localizedDescription)
            }
            else
            {
                do
                {
                    self.jsonCollection1Data = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.getArrayjson1 = self.jsonCollection1Data.value(forKey: "Collection1") as! NSArray
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }
        })
        task.resume()
    }
    func getCollection2Data()
    {
        
        let urlValue = URL(string: urlString.collectionUrl2)!
        task = session.dataTask(with: urlValue, completionHandler: {(data, response, error)in
            
            if(error != nil)
            {
                print(error!.localizedDescription)
            }
            else
            {
                do
                {
                    self.jsonCollection2Data = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.getArrayjson2 = self.jsonCollection2Data.value(forKey: "Collection2") as! NSArray
                    DispatchQueue.main.async {
                        self.calenderCollection1.reloadData()
                    }
                    
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }
        })
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getArrayjson1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let monthName = cell.contentView.viewWithTag(1) as! UILabel
        let dayName = cell.contentView.viewWithTag(2) as! UILabel
        
        monthName.text = (self.getArrayjson1[indexPath.row] as AnyObject).value(forKey: "Date") as? String
        dayName.text = (self.getArrayjson1[indexPath.row] as AnyObject).value(forKey: "DayText") as? String
        return cell
        
    }
}

