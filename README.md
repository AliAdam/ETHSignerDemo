# ETHSignerDemo

### Ethereum signer  APP ,  MVVM  + RxSwift  implementation in iOS 


### MVVM architecture + Router
MVVM (Model-View-ViewModel) is derived from MVC(Model-View-Controller).
It is introduced to solve existing problems of Cocoa's MVC architecture in iOS world.
One of its feature is to make a better seperation of concerns so that it is easier to maintain and extend.

*  Model: It is simillar to `model` layer in MVC (contains data )

* View: UIViews + UIViewControllers 

* ViewModel: A mediator to glue two above layer together (contains  business logic).

* Router: When the user taps  to navigate to the next scene . A router extracts this navigation logic out of the view controller. It is also the best place to pass any data to the next scene. As a result, the view controller is left with just the task of controlling views.

* Builder: initialize ViewController, ViewModel and Router
provide the ViewController to the outside world (via the viewController() method)
if the Scene needs some initial data it is injected into the Builder who then injects it into the ViewModel


An important point in MVVM is that it uses a binder as communication tool between View and ViewModel layers.
A technique named `Data Binding` is used with `RxSwift` . 

### Repository
Implement repository  Pattren to give the viewModel one entry point for loading data from server or from mockups for unit testing .

#### Example
```
protocol BalanceRepository {
    func getBalance(wallet: EthereumWallet, completionHandler: @escaping((Result<String,Error>) -> Void))
}

class RemoteBalanceRepository: BalanceRepository {}

class MockupBalanceRepository: BalanceRepository {}

```

## Modules 
Modules divied the app into  Modules each Module represent a feature of the  app .
 I just divid the APP to two Modules 
 * ```ETHSignerDemo```   The main Module and have all the app screeens 
 *  ```ETHCore```  A static framework Target  Manage the communcation with etherem APIs 



###  Sences (Screens)
Sences divied each Module in the  app into  Sences each Sence has  screens inside it  
each Sence  have it is own  storyboard 
inside Sence each screen have folder contain MVVM classes 

* ```We have only two Sences on the ETHSignerDemo module ``` 
* ```Main```   Splash screen ,   Setup Screen  and Account Screen
*  ```SigningAndVerification```  Signing Screen , Signature Screen and Verification Screeen 

### Storyboard 
each Sence has his own storyboard to make life easer when want to access any view contoller inside Sences 
you can add storyBord name here 
```Extension -> Storyboard Extension -> extension UIStoryboard -> enum Storyboard: String ```

be sure to use your viewcontroller  class as the viewcontroller id on inside StoaryBoard 

```

enum Storyboard: String {
case main
case signing

var filename: String {
return rawValue.capitalized
}
}
```
then  when ever you want to use it call it like this   
```
let viewController : AccountViewController = UIStoryboard.storyboard(.main).instantiateViewController()
```

## Libraries
### ETHSignerDemo Target 
* [RxSwift '5.0.0' + RxCocoa '5.0.0'] to do "data binding" job which binds `ViewModel` and `View`
* [ReachabilitySwift  '4.3.1'] to listen to network status change 
* ['SwiftLint' '0.33.0'] to enforce Swift style and conventions
  * ['QRCodeReader.swift' '10.1.0'] Qr Code reader 

### ETHCore Target 

* ['web3swift' '2.1.6']  Elegant Web3js functionality in Swift. Native ABI parsing and smart contract interactions on Ethereum network
