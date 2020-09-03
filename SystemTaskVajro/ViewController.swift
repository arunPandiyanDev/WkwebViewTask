//
//  ViewController.swift
//  SystemTaskVajro
//
//  Created by mac on 02/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var imagesTableview: UITableView!
    
    var iOSApps: AppleMusicAndApp? {
           didSet {
               imagesTableview.reloadData()
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getiOSApp()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iOSApps?.articlesFeed?.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        cell.setUpCell(articlesObject: iOSApps?.articlesFeed?[indexPath.row])
      
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hahaha")
        let vc = WebViewController()
        vc.bodyTextStr = iOSApps?.articlesFeed?[indexPath.row].bodyText ?? ""
        self.present(vc, animated: true, completion: nil)

    }
    
}

extension ViewController {
    func getiOSApp() {
           APIManager.shared.getiOSApps { (error, data) in
               if error != nil {
                   self.showAlert(title: "Opps", message: error ?? "Something went wrong")
                   return
               }
               self.iOSApps = Mapper<AppleMusicAndApp>().map(JSONObject: data?.object)
           }
       }
       func showAlert(title: String = "Error", message: String) {
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alertController, animated: true, completion: nil)
          }
}
