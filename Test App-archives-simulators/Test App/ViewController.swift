//
//  ViewController.swift
//  Test App
//
//  Created by chinmay on 26/01/24.
//

import UIKit
import paymentlib

class ViewController: UIViewController {
    
   
    
 
    var isSDKInitialized = false
    var clientId="99c3dbe7-17df-4f94-a3df-43c04630bdec";
    var clientKey = "y9Qk7Hs/WExLONBP7bI6oahByaLMfDt/Y/lA2lzcPJ8="
    var merchantId = "on8yb988pbROqSQ"
    var merchantName = "Tara"
    var locale = "en"
    var env = "prod"
    var appId = "app.tara"
    var merchantLogoUrl = "https://source.unsplash.com/random/200x200"
    
    var enteredAmount: Double = 0.0
    var enteredOrderID: String = UUID().uuidString
    var mobileNumber:String = "8180011421"
    var email:String? = "sanjayaega@gmail.com"
    let orderIDTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
          let button = UIButton(type:UIButton.ButtonType.custom)
          button.addTarget(self, action: #selector(startPayment), for: .touchUpInside)
          button.setTitle("Test Payment", for: UIControl.State.normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = UIColor.blue
          self.view.addSubview(button)
        
        
        let payIdButton = UIButton(type:UIButton.ButtonType.custom)
        payIdButton.addTarget(self, action: #selector(initSDK), for: .touchUpInside)
        payIdButton.setTitle("INIT SDK", for: UIControl.State.normal)
        payIdButton.translatesAutoresizingMaskIntoConstraints = false
        payIdButton.backgroundColor = UIColor.blue
        self.view.addSubview(payIdButton)
        
        let createPayId = UIButton(type:UIButton.ButtonType.custom)
        createPayId.addTarget(self, action: #selector(linkPayId), for: .touchUpInside)
        createPayId.setTitle("Create Pay Id", for: UIControl.State.normal)
        createPayId.translatesAutoresizingMaskIntoConstraints = false
        createPayId.backgroundColor = UIColor.blue
        createPayId.isHidden = true
        self.view.addSubview(createPayId)
        
        let linkButton = UIButton(type:UIButton.ButtonType.custom)
        linkButton.addTarget(self, action: #selector(manageSOF), for: .touchUpInside)
        linkButton.setTitle("Manage Source of Funds", for: UIControl.State.normal)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.backgroundColor = UIColor.blue
        self.view.addSubview(linkButton)
        
        let getBankList = UIButton(type:UIButton.ButtonType.custom)
        getBankList.addTarget(self, action: #selector(getLinkedBank), for: .touchUpInside)
        getBankList.setTitle("Get Linked Bank Account", for: UIControl.State.normal)
        getBankList.translatesAutoresizingMaskIntoConstraints = false
        getBankList.backgroundColor = UIColor.blue
        
        self.view.addSubview(getBankList)
        
        
          // ... Your existing code ...
          
          // Create a label for the amount field
         let amountLabel = UILabel()
          amountLabel.text = "Amount:"
          amountLabel.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(amountLabel)
          
          // Create a text field for entering the amount
          let amountTextField = UITextField()
          amountTextField.placeholder = "Enter Amount"
          amountTextField.text = "10001.0"
          amountTextField.borderStyle = .roundedRect
          amountTextField.keyboardType = .decimalPad
          amountTextField.translatesAutoresizingMaskIntoConstraints = false
          amountTextField.addTarget(self, action: #selector(amountTextFieldDidChange(_:)), for: .editingChanged)
           
          self.view.addSubview(amountTextField)
          
          let mobileLabel = UILabel()
          mobileLabel.text = "Mobile Number (Without Country Code)"
          mobileLabel.translatesAutoresizingMaskIntoConstraints = false
        
          self.view.addSubview(mobileLabel)
        
        
        let emailLabel = UILabel()
        emailLabel.text = "Email : "
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailLabel)
        
        
        let emailTextField = UITextField()
        emailTextField.placeholder = "Enter Email Id"
        emailTextField.borderStyle = .roundedRect
        emailTextField.text = "chinmay.tayade@indepay.com"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        self.view.addSubview(emailTextField)
        
          let mobileTextField = UITextField()
        mobileTextField.text = "8180011421"
          mobileTextField.placeholder = "Enter Mobile Number"
          mobileTextField.borderStyle = .roundedRect
          mobileTextField.keyboardType = .decimalPad
          mobileTextField.translatesAutoresizingMaskIntoConstraints = false
          mobileTextField.addTarget(self, action: #selector(mobileTextFieldDidChange(_:)), for: .editingChanged)
          self.view.addSubview(mobileTextField)
        
        
          // Create a label for the order ID field
          let orderIDLabel = UILabel()
          orderIDLabel.text = "Order ID:"
          orderIDLabel.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(orderIDLabel)
        
        
          // Create a text field for entering the order ID
         
          orderIDTextField.placeholder = "Enter Order ID"
          orderIDTextField.borderStyle = .roundedRect
          orderIDTextField.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(orderIDTextField)
          
          // Create a button to generate order ID
          let generateOrderIDButton = UIButton(type: .custom)
          generateOrderIDButton.addTarget(self, action: #selector(generateRandomOrderID), for: .touchUpInside)
          generateOrderIDButton.setTitle("Generate Order ID", for: .normal)
          generateOrderIDButton.backgroundColor = UIColor.blue
          generateOrderIDButton.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(generateOrderIDButton)
        let devLabel = UILabel()
                devLabel.text = "Dev"
                devLabel.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(devLabel)

                // Create a UILabel for "Prod"
                let prodLabel = UILabel()
                prodLabel.text = "Prod"
                prodLabel.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(prodLabel)
        
               let modeSwitch = UISwitch()
               modeSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
               modeSwitch.isOn = true
               modeSwitch.translatesAutoresizingMaskIntoConstraints = false
               self.view.addSubview(modeSwitch)
                
        
          // Add Auto Layout constraints
          NSLayoutConstraint.activate(
            [
                
                
                
                devLabel.centerYAnchor.constraint(equalTo: modeSwitch.centerYAnchor),
                           devLabel.trailingAnchor.constraint(equalTo: modeSwitch.leadingAnchor, constant: -10),
                           
                           prodLabel.centerYAnchor.constraint(equalTo: modeSwitch.centerYAnchor),
                           prodLabel.leadingAnchor.constraint(equalTo: modeSwitch.trailingAnchor, constant: 10),
                           
                
                modeSwitch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                            modeSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), // Center horizontally
                            
                mobileLabel.topAnchor.constraint(equalTo: modeSwitch.bottomAnchor, constant: 20),
                mobileLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                mobileTextField.topAnchor.constraint(equalTo: mobileLabel.bottomAnchor, constant: 8),
                mobileTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                mobileTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                
                
                emailLabel.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 20),
                emailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
              amountLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
              amountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              
              amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
              amountTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              amountTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              
              orderIDLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
              orderIDLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              
              orderIDTextField.topAnchor.constraint(equalTo: orderIDLabel.bottomAnchor, constant: 8),
              orderIDTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              orderIDTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              
              generateOrderIDButton.topAnchor.constraint(equalTo: orderIDTextField.bottomAnchor, constant: 20),
              generateOrderIDButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              generateOrderIDButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              generateOrderIDButton.heightAnchor.constraint(equalToConstant: 40),
              
              
              button.topAnchor.constraint(equalTo: generateOrderIDButton.bottomAnchor, constant: 20),
              button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              button.heightAnchor.constraint(equalToConstant: 40),
              
              
              payIdButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
              payIdButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              payIdButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              payIdButton.heightAnchor.constraint(equalToConstant: 40),
              
              createPayId.topAnchor.constraint(equalTo: payIdButton.bottomAnchor, constant: 20),
              createPayId.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              createPayId.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              createPayId.heightAnchor.constraint(equalToConstant: 40),
              linkButton.topAnchor.constraint(equalTo: createPayId.bottomAnchor, constant: 20),
              linkButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              linkButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              linkButton.heightAnchor.constraint(equalToConstant: 40),
              
              getBankList.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 20),
              getBankList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
              getBankList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
              getBankList.heightAnchor.constraint(equalToConstant: 40),
              
              
          ]
        )
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @objc func switchValueChanged(_ sender: UISwitch) {
            resetAppData()
            
            if sender.isOn {
                
                PaymentLib()
                    .initIndepaySDK(clientId: "35e7ab5c-0f07-4856-a674-650ca5fc37ca",
                                          clientKey:"Z+zRdTWBiqArMUhyL8I+HpisUeVD4BVHU4h8/Kr2K6c=",
                                          merchantId: "1Nd83SuyaplUkUn",
                                          merchantName: "Test Merchant", locale: "en", appId: "app.dev",
                                          env: "dev",
                                          merchantLogoUrl: "https://source.unsplash.com/random/200x200")
            } else {
                PaymentLib()
                    .initIndepaySDK(clientId: "99c3dbe7-17df-4f94-a3df-43c04630bdec",
                                          clientKey:"y9Qk7Hs/WExLONBP7bI6oahByaLMfDt/Y/lA2lzcPJ8=",
                                          merchantId: "on8yb988pbROqSQ",
                                          merchantName: "Tara", locale: "en", appId: "app.tara",
                                          env: "prod",
                                          merchantLogoUrl: "https://source.unsplash.com/random/200x200")
            }
    }

    
    @objc func amountTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let amount = Double(text) {
            enteredAmount = amount
        } else {
            enteredAmount = 0.0
        }
        print(enteredAmount);
    }
    
    @objc func mobileTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            mobileNumber = text
        } else {
            mobileNumber = ""
        }
        print(mobileNumber)
    }

    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            email = text
        } else {
            email = nil
        }
        print(email)
    }
    
    @objc func generateRandomOrderID() {
        
        if(!isSDKInitialized){
            initSDK()
        }
        // Get the current timestamp as a string
        let timestamp = String(Date().timeIntervalSince1970)
        
        // Generate a random string of alphanumeric characters
        let randomString = randomAlphanumericString(length: 20)
        
        // Combine the timestamp and random string to create the order ID
        let orderID = randomString
        enteredOrderID = orderID;
        print(enteredOrderID)
        orderIDTextField.text = enteredOrderID;
      
       
    }

    // Function to generate a random alphanumeric string of a given length
    func randomAlphanumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in allowedChars.randomElement()! })
        return randomString
    }

    @objc func orderIDTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            enteredOrderID = text
        } else {
            enteredOrderID = ""
        }
    }
    
    func validateFields() -> Bool {
        // Check if order ID is empty
        if enteredOrderID.isEmpty {
            showAlert(message: "Please enter Order ID")
            return false
        }
        
        // Check if mobile number is empty
        if mobileNumber.isEmpty {
            showAlert(message: "Please enter Mobile Number")
            return false
        }
        
        // Check if email is empty
        if email?.isEmpty ?? true {
            showAlert(message: "Please enter Email")
            return false
        }
        
        if let email = email, !isValidEmail(email) {
                showAlert(message: "Please enter a valid Email")
                return false
        }
        
        // Check if enteredAmount is greater than zero
        if enteredAmount <= 0 {
            showAlert(message: "Please enter a valid Amount")
            return false
        }
        
        // All fields are valid
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    //
    
    
    @objc func startPayment() {
        
//        if(!isSDKInitialized){
//            initSDK()
//        }

        
        PaymentLib().startPayment(
            amount: 10000,
            deeplinkCallback:"tara.page.link",
            referenceId: UUID().uuidString,
            directPaymentType: nil,
            remarks: "Test Order Ignore",
            email: email ?? "",
            firstName: "Chinmay",
            lastName: "Tayade",
            mobileNumber: "8180011428"
        ){ result in
           
            print("callback ayyaa--->>>")
            print(result ?? "nil ayaa--->>>")
            if(result != nil){
                print("result is not null")
                print(result["status"] as! String)
                
            }
        }
        
       
       
    }
    
    @objc func manageSOF() {
        
        PaymentLib().manageSof(
            email: email ?? "",
            firstName: "Chinmay",
            lastName: "Tayade",
            mobileNumber: mobileNumber,
            onResult: {
                data in
               
                print(data)
            }
        )
    }
    
    
    @objc func initSDK() {

        
        if(env=="dev"){
            
            
            PaymentLib()
                .initIndepaySDK(clientId: "35e7ab5c-0f07-4856-a674-650ca5fc37ca",
                                      clientKey:"Z+zRdTWBiqArMUhyL8I+HpisUeVD4BVHU4h8/Kr2K6c=",
                                      merchantId: "1Nd83SuyaplUkUn",
                                      merchantName: "Test Merchant", locale: "en", appId: "app.dev",
                                      env: "dev",
                                      merchantLogoUrl: "https://source.unsplash.com/random/200x200")
        }else{
            
            PaymentLib()
                .initIndepaySDK(clientId: "99c3dbe7-17df-4f94-a3df-43c04630bdec",
                                      clientKey:"y9Qk7Hs/WExLONBP7bI6oahByaLMfDt/Y/lA2lzcPJ8=",
                                      merchantId: "on8yb988pbROqSQ",
                                      merchantName: "Tara", locale: "en", appId: "app.tara",
                                      env: "prod",
                                      merchantLogoUrl: "https://source.unsplash.com/random/200x200")
        }
    }

    
    @objc func linkPayId() {
        
        PaymentLib().getPrimaryBankAccounts(email: email ?? "", firstName: "chinmay", lastName: "tyayade", mobileNumber: mobileNumber) {
         
            response in
           
            print("response Recived")
            print(response)
            print(response["data"]);
        }
    }
    
    func resetAppData() {
   
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }

    
    
    @objc func getLinkedBank() {
        
        PaymentLib().getBankAccounts(email: email ?? "", firstName: "chinmay", lastName: "tayade", mobileNumber: mobileNumber) { response in
           
            print("response Recived")
            print(response)
            print(response["data"]);
            
        }
        
    }
}
