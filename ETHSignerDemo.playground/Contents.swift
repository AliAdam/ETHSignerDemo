import UIKit
import Web3swift

let str = ""
//create keystore with provided private key
if let  keystore =  PlainKeystore.init(privateKey: str) {
    print(keystore.addresses!.first!.address)

    let accountBalance = try! Web3.InfuraRinkebyWeb3().eth.getBalance(address: keystore.addresses!.first!)
    if let formatedBalance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
        print(formatedBalance)
    }
}
