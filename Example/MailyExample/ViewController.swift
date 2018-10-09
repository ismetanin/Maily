//
//  ViewController.swift
//  MailyExample
//
//  Created by Ivan Smetanin on 08/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit
import Maily

class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var recipientTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!

    // MARK: - IBActions

    @IBAction func sendButtonAction(_ sender: UIButton) {
        sendEmail()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private methods

    private func sendEmail() {
        if Maily.canSendMail {
            Maily.sendMail(
                recipient: recipientTextField.text, subject: subjectTextField.text, body: bodyTextField.text,
                onCompleted: {
                    print("completed")
                },
                onCancel: {
                    print("cancel")
                }
            )
        } else {
            let alert = UIAlertController(title: "Error", message: "Can't find any email clients", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

