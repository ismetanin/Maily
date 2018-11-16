//
//  StandardMailClient.swift
//  Maily
//
//  Created by Ivan Smetanin on 23/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MessageUI

open class StandardMailClient: MailClient {

    public var isAvailable: Bool {
        return MFMailComposeViewController.canSendMail()
    }
    public var name: String {
        return "Mail"
    }

    static let shared = StandardMailClient()

    private init() {}

    public func sendEmail(recipient: String?, subject: String?, body: String?, presentCompletion: (() -> Void)?) {
        let controller = MFMailComposeViewController()
        UIApplication.shared.keyWindow?.rootViewController?.present(
            controller,
            animated: true,
            completion: {
                presentCompletion?()
            }
        )
    }

}
