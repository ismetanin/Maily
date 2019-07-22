//
//  StandardMailClient.swift
//  Maily
//
//  Created by Ivan Smetanin on 23/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MessageUI

open class StandardMailClient: MailClient {

    public static let shared = StandardMailClient()

    public init() {}

    // MARK: - Properties

    open var isAvailable: Bool {
        return MFMailComposeViewController.canSendMail()
    }
    open var name: String = "Mail"

    // MARK: - Open methods

    open func sendEmail(recipient: String?, subject: String?, body: String?, presentHandler: (() -> Void)?) {
        let controller = MFMailComposeViewController()
        UIApplication.shared.keyWindow?.rootViewController?.present(
            controller,
            animated: true,
            completion: {
                presentHandler?()
            }
        )
    }

}
