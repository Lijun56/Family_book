//
//  LoginViewController.swift
//  Famility_Book
//
//  Created by Stephen Zhu on 6/11/22.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PassWordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LogIn(_ sender: UIButton) {
        if let email = EmailTextField.text, let password = PassWordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let err = error{
                    let message = err.localizedDescription
                    let alert = UIAlertController(title: "WTF", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                    self.present(alert, animated:true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}
