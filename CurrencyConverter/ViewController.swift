//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mac on 6.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtCad: UILabel!
    @IBOutlet weak var txtTRY: UILabel!
    @IBOutlet weak var txtUSD: UILabel!
    @IBOutlet weak var txtJPY: UILabel!
    @IBOutlet weak var txtGBP: UILabel!
    @IBOutlet weak var txtCHF: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1 request $ session
        //2 response $ data
        //3 parsing $ json serialization
    }
//1
    @IBAction func getRatesButtonPressed(_ sender: UIButton) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=76b8bbd405071895b6f6a1267c4a03fd")
        // because of using shared that means it is creating singletoon object ;
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)

            }
            else {
                //2
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        //async;
                        DispatchQueue.main.async {
                         // print(jsonResponse)
                            
                            if let rates = jsonResponse["rates"] as? [String:Any] {
                                
                                if let cad = rates["CAD"] as? Double,let chf = rates["CHF"] as? Double,let gbp = rates["GBP"] as? Double,let jpy = rates["JPY"] as? Double, let usd = rates["USD"] as? Double ,let tryx = rates["TRY"] as? Double{
                                    self.txtCad.text = "cad: \(cad)"
                                    self.txtTRY.text = "try: \(tryx)"
                                    self.txtUSD.text = "usd: \(usd)"
                                    self.txtJPY.text = "jpy: \(jpy)"
                                    self.txtGBP.text = "gbp: \(gbp)"
                                    self.txtCHF.text = "chf: \(chf)"

                                    
                                }
                            }
                        }
                        
                    } catch {
                        print("some error occured: \(error)")
                    }
                }
            }
        }
        task.resume()
    }
    
}

