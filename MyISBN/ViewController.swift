//
//  ViewController.swift
//  MyISBN
//
//  Created by León Felipe Guevara Chávez on 2015-12-20.
//  Copyright © 2015 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var respuesta: UITextView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var myURL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func limpiarCampos() {
        isbn.text = ""
        respuesta.text = ""
    }

    @IBAction func buscarISBN() {
        let myISBN:String? = isbn.text!
        let mISBN = myISBN!
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        /*print(urls)*/
        let url = NSURL(string: urls + myISBN!)
        let datos:NSData? = NSData(contentsOfURL: url!)
        let texto = NSString(data:datos!, encoding: NSUTF8StringEncoding)
        /*print(texto)*/
        respuesta.text = texto! as String
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dict1 = json as! NSDictionary
            let dict2 = dict1["ISBN:" + mISBN] as! NSDictionary
            self.titulo.text = dict2["title"] as! NSString as String
            self.autor.text = dict2["by_statement"] as! NSString as String
            let dict3 = dict2["cover"] as! NSDictionary
            self.myURL.text = dict3["small"] as!NSString as String
        }
        catch _ {
            
        }
    }
    
}

