import UIKit
import Web3swift

let key = ""
//create keystore with provided private key

if let  keystore =  PlainKeystore.init(privateKey: key) {
    print(keystore.addresses!.first!.address)


    let accountBalance = try! Web3.InfuraRinkebyWeb3().eth.getBalance(address: keystore.addresses!.first!)
    if let formatedBalance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
        print(formatedBalance)
    }

    // signing
    let msgStr = "This is my first Ethereum App"
    let data = msgStr.data(using: .utf8)
    do {
        let message = "This is my first Ethereum App"
        let web3 = Web3.InfuraRinkebyWeb3()
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        let expectedAddress = keystoreManager.addresses![0]
        print(expectedAddress)
        let signRes = try web3.personal.signPersonalMessage(message: message.data(using: .utf8)!, from: expectedAddress, password: "")
        generateQRCode(from:signRes)
        print(signRes)

    } catch  {
        print(error.localizedDescription)

    }


}

func generateQRCode(from data: Data?) -> UIImage? {
      guard let data = data else {
          return nil
      }
      if let filter = CIFilter(name: "CIQRCodeGenerator") {
          filter.setValue(data, forKey: "inputMessage")
          let transform = CGAffineTransform(scaleX: 10, y: 10)

          if let output = filter.outputImage?.transformed(by: transform) {
              return UIImage(ciImage: output)
          }
      }
      return nil
  }


//verify personal message
   func verifyMessage(message: String,signature: Data) -> Bool{

       let web3 = Web3.InfuraRinkebyWeb3()
       let tempKeystore = try! EthereumKeystoreV3(password: "")
       let keystoreManager = KeystoreManager([tempKeystore!])
       web3.addKeystoreManager(keystoreManager)
       let expectedAddress = keystoreManager.addresses![0]
       print(expectedAddress)
       let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: signature)!
       print("V = " + String(unmarshalledSignature.v))
       print("R = " + Data(unmarshalledSignature.r).toHexString())
       print("S = " + Data(unmarshalledSignature.s).toHexString())
       print("Personal hash = " + Web3.Utils.hashPersonalMessage(message.data(using: .utf8)!)!.toHexString())
       let recoveredSigner = web3.personal.ecrecover(personalMessage: message.data(using: .utf8)!, signature: signature)
       guard case .success(let signer) = recoveredSigner else {return false}
       return (expectedAddress == signer);
   }

