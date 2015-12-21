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
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(myISBN!)"
        /*print(urls)*/
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        let texto = NSString(data:datos!, encoding: NSUTF8StringEncoding)
        /*print(texto)*/
        respuesta.text = texto! as String
    }
}

