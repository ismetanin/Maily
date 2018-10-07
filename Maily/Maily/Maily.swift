//
//  Maily.swift
//  Maily
//
//  Created by Ivan Smetanin on 07/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

enum Constants {

    static let standardClients: [MailClient] = [
        StandardMailClient.shared,
        // sparrow:[to]?subject=[subject]&body=[body]
        ThirdPartyMailClient(name: "Sparrow", scheme: "sparrow",
                             root: nil, recipientKey: nil,
                             subjectKey: "subject", bodyKey: "body"),

        // googlegmail:///co?to=[to]&subject=[subject]&body=[body]
        ThirdPartyMailClient(name: "Gmail", scheme: "googlegmail",
                             root: "///co", recipientKey: "to",
                             subjectKey: "subject", bodyKey: "body"),

        // x-dispatch:///compose?to=[to]&subject=[subject]&body=[body]
        ThirdPartyMailClient(name: "Dispatch", scheme: "x-dispatch",
                             root: "///compose", recipientKey: "to",
                             subjectKey: "subject", bodyKey: "body"),

        // readdle-spark://compose?subject=[subject]&body=[body]&recipient=[recipient]
        ThirdPartyMailClient(name: "Spark", scheme: "readdle-spark",
                             root: "//compose", recipientKey: "recipient",
                             subjectKey: "subject", bodyKey: "body"),

        // airmail://compose?subject=[subject]&from=[from]&to=[to]&cc=[cc]&bcc=[bcc]&plainBody=[plainBody]&htmlBody=[htmlBody]
        ThirdPartyMailClient(name: "Airmail", scheme: "airmail",
                             root: "//compose", recipientKey: "to",
                             subjectKey: "subject", bodyKey: "plainBody"),

        // ms-outlook://compose?subject=[subject]&body=[body]&to=[to]
        ThirdPartyMailClient(name: "Microsoft Outlook", scheme: "ms-outlook",
                             root: "//compose", recipientKey: "to",
                             subjectKey: "subject", bodyKey: "body"),

        // ymail://mail/compose?subject=[subject]&body=[body]&to=[to]
        ThirdPartyMailClient(name: "Yahoo Mail", scheme: "ymail",
                             root: "//mail/compose", recipientKey: "to",
                             subjectKey: "subject", bodyKey: "body")
    ]

}

open class Maily {

    static var canSendMail: Bool {
        return false
    }

    private static var clients: [MailClient] = Constants.standardClients

    static func sendEmail(recipients: [String] = [], subject: String = "",
                          body: String = "", onCompleted: (() -> Void),
                          onCancel: (() -> Void)) {

    }

}

protocol MailClient {
    var isAvailable: Bool { get }
    func sendEmail(recipient: String?, subject: String?, body: String?, completion: (() -> Void)?)
}

import UIKit

open class ThirdPartyMailClient: MailClient {

    // MARK: - Constants

    private let name: String
    private let scheme: String
    private let root: String?
    private let recipientKey: String?
    private let subjectKey: String?
    private let bodyKey: String?

    // MARK: - Properties

    var isAvailable: Bool {
        var components = URLComponents()
        components.scheme = self.scheme

        guard let url = components.url else {
            return false
        }

        return UIApplication.shared.canOpenURL(url)
    }

    // MARK: - Initialization and deinitialization

    init(name: String, scheme: String,
         root: String?, recipientKey: String?,
         subjectKey: String?, bodyKey: String?) {
        self.name = name
        self.scheme = scheme
        self.root = root
        self.recipientKey = recipientKey
        self.subjectKey = subjectKey
        self.bodyKey = bodyKey
    }

    // MARK: - Public methods

    public func sendEmail(recipient: String?, subject: String?, body: String?, completion: (() -> Void)?) {
        guard let url = self.composeURL(recipient: recipient, subject: subject, body: body) else {
            return
        }
        UIApplication.shared.open(url, options: [:]) { _ in
            completion?()
        }
    }

    // MARK: - Private methods

    private func composeURL(recipient: String?, subject: String?, body: String?) -> URL? {
        var components = URLComponents(string: "\(scheme):\(root ?? "")")
        components?.scheme = self.scheme

        if recipientKey == nil {
            if let recipient = recipient {
                components = URLComponents(string: "\(scheme):\(root ?? "")\(recipient)")
            }
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

import MessageUI

open class StandardMailClient: MailClient {

    var isAvailable: Bool {
        return MFMailComposeViewController.canSendMail()
    }

    static let shared = StandardMailClient()

    private init() {}

    func sendEmail(recipient: String?, subject: String?, body: String?, completion: (() -> Void)?) {
        let controller = MailComposeViewController()
        controller.composingCompletion = completion
        UIApplication.shared.keyWindow?.rootViewController?.present(
            controller,
            animated: true,
            completion: nil
        )
    }

}
open class MailComposeViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {

    var composingCompletion: (() -> Void)?

    open func mailComposeController(_ controller: MFMailComposeViewController,
                                    didFinishWith result: MFMailComposeResult,
                                    error: Error?) {
        composingCompletion?()
    }

}
