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
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var myURL: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
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
    }

    @IBAction func buscarISBN() {
        let myISBN:String? = isbn.text!
        let mISBN = myISBN!
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        /*print(urls)*/
        let url = NSURL(string: urls + myISBN!)
        let datos = NSData(contentsOfURL: url!)
        
        /*print(texto)*/
        do {
            var autoresLibro : String = ""
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dict1 = json as! NSDictionary
            let dict2 = dict1["ISBN:" + mISBN] as! NSDictionary
            self.titulo.text = dict2["title"] as! NSString as String
            let autores = dict2["rauthors"] as! NSArray
            for autorLibro in autores {
                let autorTemp = (autorLibro as! NSDictionary)["name"] as! String
                autoresLibro += autorTemp
                autoresLibro += "; "
            }
            if (autoresLibro != "") {
                self.autor.text = autoresLibro
            } else {
                self.autor.text = "Sin autor registrado"
            }
            let dict3 = dict2["cover"] as! NSDictionary
            self.myURL.text = dict3["small"] as!NSString as String
            let urlImage = NSURL(string: self.myURL.text!)
            let datos2 = NSData(contentsOfURL: urlImage!)
            if datos2 != nil {
                myImage.image = UIImage(data: datos2!)
            }
        }
        catch _ {
            let alert = UIAlertController(title: "Oops!", message: "Verifica que tengas conexión", preferredStyle: .Alert)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

