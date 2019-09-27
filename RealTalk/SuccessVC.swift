//
//  SuccessVC.swift
//  RealTalk
//
//  Created by Mark Scarsi on 9/24/19.
//  Copyright © 2019 RealTalk. All rights reserved.
//

import UIKit

class SuccessVC: UIViewController {
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print ("IN VIEW DID APPEAR")
        let image1 = UIImage(named: "grass.png")
        let imageView = UIImageView(image: image1)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.view.addSubview(imageView)
        
        print ("AFTER GRASS SHIT")
        sleep(3)
        performSegue(withIdentifier: "SuccessToHome", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SuccessToHome"){
            let displayVC = segue.destination as! HomeVC
            displayVC.user = self.user!
        }
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
