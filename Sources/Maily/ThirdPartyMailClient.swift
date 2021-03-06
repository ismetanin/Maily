//
//  ThirdPartyMailClient.swift
//  Maily
//
//  Created by Ivan Smetanin on 23/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

open class ThirdPartyMailClient: MailClient {

    // MARK: - Properties

    open var name: String

    open var isAvailable: Bool {
        var components = URLComponents()
        components.scheme = self.scheme

        guard let url = components.url else {
            return false
        }

        return UIApplication.shared.canOpenURL(url)
    }

    private let scheme: String
    private let root: String?
    private let recipientKey: String?
    private let subjectKey: String?
    private let bodyKey: String?

    // MARK: - Initialization and deinitialization

    public init(
        name: String,
        scheme: String,
        root: String?,
        recipientKey: String?,
        subjectKey: String?,
        bodyKey: String?
    ) {
        self.name = name
        self.scheme = scheme
        self.root = root
        self.recipientKey = recipientKey
        self.subjectKey = subjectKey
        self.bodyKey = bodyKey
    }

    // MARK: - Open methods

    open func sendEmail(recipient: String?, subject: String?, body: String?, presentHandler: (() -> Void)?) {
        guard let url = self.composeURL(recipient: recipient, subject: subject, body: body) else {
            return
        }
        UIApplication.shared.open(url, options: [:]) { _ in
            presentHandler?()
        }
    }

    // MARK: - Private methods

    private func composeURL(recipient: String?, subject: String?, body: String?) -> URL? {
        var components = URLComponents(string: "\(scheme):\(root ?? "")")
        components?.scheme = self.scheme

        if recipientKey == nil, let recipient = recipient {
            components = URLComponents(string: "\(scheme):\(root ?? "")\(recipient)")
        }

        var queryItems: [URLQueryItem] = []

        if let recipient = recipient, let recipientKey = recipientKey {
            queryItems.append(URLQueryItem(name: recipientKey, value: recipient))
        }

        if let subject = subject, let subjectKey = subjectKey {
            queryItems.append(URLQueryItem(name: subjectKey, value: subject))
        }

        if let body = body, let bodyKey = bodyKey {
            queryItems.append(URLQueryItem(name: bodyKey, value: body))
        }

        if queryItems.isEmpty == false {
            components?.queryItems = queryItems
        }

        return components?.url
    }

}
