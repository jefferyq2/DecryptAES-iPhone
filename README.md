# DecryptAES-iPhone
An iOS app to encrypt and decrypt messages using [AES-256](https://csrc.nist.gov/csrc/media/publications/fips/197/final/documents/fips-197.pdf) bit encryption sent via this app or my [EncryptedText](https://github.com/shillerben/EncryptedText) project.
This app uses the [Output FeedBack (OFB)](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Output_Feedback_(OFB)) mode of operation for encrypting and decrypting with AES.

## Requirements
* up-to-date version of Xcode
* iPhone with iOS 9.0+ (optional)

## Installation
1. Clone this project into a local directory on your computer using Xcode.
2. Plug your iOS device into your computer and select it as the target device for the project.
  * Or select an emulator as the target device.
3. Launch the app on your device or emulator.
  * Note: Be sure to use a valid Apple ID account to sign the project. It may take a while to install on the device.
  
## Usage
### Encrypting a message
1. Select "Encrypt" at the top of the screen.
2. Type in a message that you want to encrypt into the top text box.
3. Enter a password to encrypt the message with and tap the "Encrypt" button.
4. Copy the ciphertext from the bottom text box and paste into any messaging service.
### Decrypting a message
1. Select "Decrypt" at the top of the screen.
2. Paste the ciphertext into the top text box.
  * Note: The message has to have been encrypted using either this app or my [EncryptedText](https://github.com/shillerben/EncryptedText) project.
3. Enter the correct password into the password box and tap the "Decrypt" button.
4. The plaintext will be displayed in the bottom text box.

## Disclaimer
* Standard messaging rates may apply.
* I make no promises that the encryption used in this program is uncrackable. This program uses [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) to perform the encryption and decryption.
