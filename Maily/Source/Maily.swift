//
//  Maily.swift
//  Maily
//
//  Created by Ivan Smetanin on 07/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

open class Maily {

    public static let shared = Maily()

    public init() {}

    open var canSendMail: Bool {
        return !clients.filter { $0.isAvailable }.isEmpty
    }

    open var clients: [MailClient] = Constants.standardClients

    /// Title for cancel button in action sheet
    open var cancelButtonTitle: String = "Cancel"

    /// Shows an action sheet with available mail clients options.
    ///
    /// - Parameters:
    ///   - recipient: Recipient of the mail
    ///   - subject: Subject of the mail
    ///   - body: Body of the mail
    ///   - onCompleted: Executes when user selects any mail client
    ///   - onCancel: Executes when user selects "Cancel"
    open func sendMail(
        recipient: String?,
        subject: String?,
        body: String?,
        presentHandler: (() -> Void)?,
        cancelHandler: (() -> Void)?
    ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let application = UIApplication.shared
        let availableClients = clients.filter { $0.isAvailable }

        for client in availableClients {
            let action = UIAlertAction(title: client.name, style: .default) { _ in
                client.sendEmail(recipient: recipient, subject: subject, body: body, presentHandler: {
                    presentHandler?()
                })
            }
            alert.addAction(action)
        }

        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        alert.addAction(cancelAction)

        application.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
