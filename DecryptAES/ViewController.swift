//
//  ViewController.swift
//  DecryptAES
//
//  Created by Barbara Shiller on 12/21/17.
//  Copyright © 2017 Ben Shiller. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    @IBOutlet weak var inputBox: UITextView!
    @IBOutlet weak var keyBox: UITextField!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var outputBox: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    extension String {
        func base64Decoded() -> String? {
            if let data = Data(base64Encoded: self) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
    }
    
    @IBAction func decryptButtonPushed(_ sender: UIButton) {
        view.endEditing(true)
        // check inputs
        do {
            if inputBox.hasText && keyBox.hasText {
                let encryptedMessage = String(inputBox.text)
                //let target = "\n\n\n"
                if encryptedMessage.contains("\r\n\r\n") {
                    //let endOfCiphertext = encryptedMessage.index(encryptedMessage.endIndex, offsetBy: -18)
                    //let ciphertext = String(encryptedMessage.prefix(upTo: endOfCiphertext))
                    var splitMessage = encryptedMessage.split(separator: "\r\n")
                    let ciphertextAsData = Data(base64Encoded: String(splitMessage[0]))
                    let ivAsArray = Data(base64Encoded: String(splitMessage[1]))?.bytes
                    let keyAsArray: Array<UInt8> = keyBox.text!.bytes
                    
                }
                else {
                    outputBox.text = "Please paste the message and enter the key."
                }
            }
            else {
                outputBox.text = "Please paste the message and enter the key."
            }
        }
        catch {
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputBox.text = "Paste encrypted message here..."
        keyBox.placeholder = "Enter key here"
        outputBox.text = "Decrypted message will display here..."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

