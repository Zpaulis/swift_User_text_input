//
//  ViewController.swift
//  swift_User_text_input
//
//  Created by Paulis Zabarovskis on 02/06/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
//MARK - Outlets
    @IBOutlet weak var ClientNameTextField: UITextField!
    @IBOutlet weak var clientNameValueLabel: UILabel!
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var clientSurnameTextValueLabel: UILabel!
    
    
    
 //MARK: - Data
    var clientName: String?
    var surname: String?
    var tap:UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   // Configure protocols
        self.ClientNameTextField?.delegate = self
        self.surnameTextField?.delegate = self
        self.ClientNameTextField?.addTarget(self, action: #selector(self.didChanged(_:)), for: .editingChanged)
        self.surnameTextField?.addTarget(self, action: #selector(self.didChanged(_:)), for: .editingChanged)

   // Initialise UI elements
        self.ClientNameTextField?.text = self.clientName
        self.surnameTextField?.text = self.surname

   // Set read only (false) or editable (true)
        self.ClientNameTextField?.isUserInteractionEnabled = true
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set client name as first responder (ievieto kursoru) resign - noņem kursoru, can becam - pārbauda, vai var
        self.ClientNameTextField?.becomeFirstResponder()
    }
    
//MARK: - UITextFieldDelegate
  // 1. Vai gribam rediģēt tekstu
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print ("textFieldShouldBeginEditing")
        return  true
    }
// 2. Rediģēšana ir uzsākta - Keyboard visible
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print ("textFieldDidBeginEditing")
        
  // Assign tap for disable keyboard
        if let tap = self.tap {
            self.view.addGestureRecognizer(tap)
        }
    }

// 3. Vai drīkst beigt rediģēšanu - Default true
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print ("textFieldShouldEndEditing")
        // Remove tap for disable keyboard
              if let tap = self.tap {
                  self.view.removeGestureRecognizer(tap)
              }

    return true
    }
// 4. Rediģēšana pabeigta. Keyboard is hidden
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print ("textFieldDidEndEditing")

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isAccepted: Bool = true
        let allovedSymbolsForClientName = "abc"
        let allovedCharsetForClientName = CharacterSet.init(charactersIn: allovedSymbolsForClientName)
 // Check text field
        if textField == self.ClientNameTextField {
          
            if string.count > 0 && string.rangeOfCharacter(from: allovedCharsetForClientName) == nil {
     // Wrong symbol
           isAccepted = false
            }
        }
        
        
        return isAccepted
    }
    
    
    @IBAction func didChanged(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            return
        }
        if textField == self.ClientNameTextField {
            // Save data
            self.clientName = self.ClientNameTextField?.text
            // Display in label
            self.clientNameValueLabel?.text = self.clientName
            
            // Validācija, search, ....
        }
        if textField == self.surnameTextField {
            // Save data
            self.surname = self.surnameTextField?.text
            self.clientSurnameTextValueLabel?.text = self.surname
        }

        
    }
    // can be called from objectiveC code
    @objc func dismissKeyboard() {
        print("DISMISS")
  // Metode kursora noņemšanai konkrētam objektam
        //      self.ClientNameTextField?.resignFirstResponder()
        
        // kursora noņemšana jebkuram objektam (ressign first responder if exist) true - force ressist
        self.view.endEditing(false)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return key pressed")
        if textField == self.ClientNameTextField {
            // Enter nospiests prmajā laukā
            // pārliekk kursoru turp - atpakaļ
            self.surnameTextField?.becomeFirstResponder()
        }else {
            self.ClientNameTextField?.becomeFirstResponder()

        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == self.ClientNameTextField {
            // Krustiņš nospiests prmajā laukā
        }else {

        }
print("NEDZĒS!")
        return true
    }
    
    
}

