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

    @IBOutlet weak var settingToggle: UISegmentedControl!
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
                if settingToggle.selectedSegmentIndex == 0 { // Encrypt
                    let plaintext = String(inputBox.text).bytes
                    let keyAsArray: Array<UInt8> = keyBox.text!.bytes
                    let paddedKey = Padding.pkcs7.add(to: keyAsArray, blockSize: 32)
                    let iv: Array<UInt8> = AES.randomIV(AES.blockSize)
                    let encrypted = try AES(key: paddedKey, blockMode: .OFB(iv: iv), padding: .noPadding).encrypt(plaintext)
                    let encryptedBase64 = encrypted.toBase64()
                    let ivBase64 = iv.toBase64()
                    outputBox.text = encryptedBase64! + "\r\n\r\n\r\n" + ivBase64!
                }
                if settingToggle.selectedSegmentIndex == 1 { // Decrypt
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
            }
            else {
                outputBox.text = "Please paste the message and enter the key."
            }
        }
        catch {
            outputBox.text = "There was an error."
        }
    }
    
    @IBAction func settingChanged(_ sender: Any) {
        if settingToggle.selectedSegmentIndex == 0 {
            decryptButton.setTitle("Encrypt", for: UIControlState.normal)
            inputBox.text = "Type message here..."
            outputBox.text = "Encrypted text will appear here."
        }
        if settingToggle.selectedSegmentIndex == 1 {
            decryptButton.setTitle("Decrypt", for: UIControlState.normal)
            inputBox.text = "Paste encrypted text here."
            outputBox.text = "Decrypted text will appear here."
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

