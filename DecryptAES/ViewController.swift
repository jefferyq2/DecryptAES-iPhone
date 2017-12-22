//
//  ViewController.swift
//  DecryptAES
//
//  Created by Barbara Shiller on 12/21/17.
//  Copyright © 2017 Ben Shiller. All rights reserved.
//
//  CryptoSwift is developed by Marcin Krzyżanowski here: https://github.com/krzyzanowskim/CryptoSwift
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
    
    @IBAction func decryptButtonPushed(_ sender: UIButton) {
        view.endEditing(true)
        // check inputs
        do {
            if inputBox.hasText {
                let encryptedMessage = String(inputBox.text)
                if encryptedMessage.contains("\r\n\r\n") {
                    var splitMessage = encryptedMessage.split(separator: "\r\n")
                    let ciphertext = Data(base64Encoded: String(splitMessage[0]))?.bytes
                    let ivAsArray = Data(base64Encoded: String(splitMessage[1]))?.bytes
                    if ivAsArray?.count == 16 {
                        let keyAsArray: Array<UInt8> = keyBox.text!.bytes
                        let paddedKey = Padding.pkcs7.add(to: keyAsArray, blockSize: 32)
                        let aes = try AES(key: paddedKey, blockMode: .OFB(iv: ivAsArray!), padding: .noPadding)
                        let plaintextAsArray = try aes.decrypt(ciphertext!)
                        let plaintext = String(data: Data(plaintextAsArray), encoding: .utf8)
                        if plaintext != nil {
                            outputBox.text = plaintext
                        }
                        else {
                            outputBox.text = "Password is incorrect."
                        }
                    }
                    else {
                        outputBox.text = "IV is incorrect."
                    }
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
            outputBox.text = "There was an error."
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

