//
//  DogTabsViewController.swift
//  STIDogs
//
//  Created by Hari Rao on 6/15/19.
//  Copyright © 2019 hariDasu. All rights reserved.
//

import UIKit

class DogTabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = RandomDogViewController()
        let dogIcon = UIImage(imageLiteralResourceName: "dogIcon")
        firstViewController.tabBarItem =  UITabBarItem(title: "Random Dog", image: dogIcon, selectedImage:  dogIcon)
        let pawsIcon = UIImage(imageLiteralResourceName: "pawsIcon")
        let secondViewController = UINavigationController(rootViewController: DogsTableViewController());
        secondViewController.tabBarItem =  UITabBarItem(title: "Dog Breeds", image: pawsIcon, selectedImage:  pawsIcon)
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
