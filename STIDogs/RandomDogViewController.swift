//
//  RandomDogViewController.swift
//  STIDogs
//
//  Created by Hari Rao on 5/28/19.
//  Copyright © 2019 hariDasu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class RandomDogViewController: UIViewController {
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let getDoggoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Get Random Doggo", for: [.normal] )
        button.addTarget(self, action: #selector(getRandomDoggo), for: .touchUpInside)
        return button
    }()
    
    let dogImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    @objc func getRandomDoggo () {
        Alamofire.request("https://dog.ceo/api/breeds/image/random")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let imageData = JSON(response.result.value!)["message"].string
                    self.dogImage.load(url: NSURL(string: imageData!)! as URL)
                case .failure(let error):
                    print(error)
                }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        topView.addSubview(getDoggoButton)
        getDoggoButton.snp.makeConstraints {
            (make) -> Void in
            make.bottom.equalTo(topView).offset(-100)
            make.left.equalTo(topView).offset(20)
            make.right.equalTo(topView).offset(-20)
        }
        topView.addSubview(dogImage)
        dogImage.snp.makeConstraints{
            (make) -> Void in
            make.center.equalTo(topView)
        }
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
