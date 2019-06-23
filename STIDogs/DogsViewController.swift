//
//  DogsViewController.swift
//  STIDogs
//
//  Created by Hari Rao on 6/15/19.
//  Copyright © 2019 hariDasu. All rights reserved.
//

import UIKit
import SnapKit

class DogsViewController: UIViewController {

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("many dogs")
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        // Do any additional setup after loading the view.
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
