//
//  MailClient.swift
//  Maily
//
//  Created by Ivan Smetanin on 23/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

public protocol MailClient {
    var isAvailable: Bool { get }
    var name: String { get }
    func sendEmail(recipient: String?, subject: String?, body: String?, presentCompletion: (() -> Void)?)
}
