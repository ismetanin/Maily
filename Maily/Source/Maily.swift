//
//  Maily.swift
//  Maily
//
//  Created by Ivan Smetanin on 07/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

open class Maily {

    public static var canSendMail: Bool {
        return !Maily.clients.filter { $0.isAvailable }.isEmpty
    }

    public static var clients: [MailClient] = Constants.standardClients

    public static var cancelButtonTitle: String = "Cancel"

    /// Show an action sheet with available mail clients options.
    ///
    /// - Parameters:
    ///   - recipient: Recipient of the mail
    ///   - subject: Subject of the mail
    ///   - body: Body of the mail
    ///   - onCompleted: Executes when user selects any mail client
    ///   - onCancel: Executes when user selects "Cancel"
    public static func sendMail(recipient: String?,
                                subject: String?,
                                body: String?,
                                onPresented: @escaping (() -> Void),
                                onCancel: @escaping (() -> Void)) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let application = UIApplication.shared
        let clients = Maily.clients.filter { $0.isAvailable }

        for client in clients {
            let action = UIAlertAction(title: client.name, style: .default) { _ in
                client.sendEmail(recipient: recipient, subject: subject, body: body, presentCompletion: {
                    onPresented()
                })
            }
            alert.addAction(action)
        }

        let cancelAction = UIAlertAction(title: Maily.cancelButtonTitle, style: .cancel) { _ in
            onCancel()
        }
        alert.addAction(cancelAction)

        application.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
