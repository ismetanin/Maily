//
//  MailyExampleTests.swift
//  MailyExampleTests
//
//  Created by Ivan Smetanin on 08/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import XCTest
import Maily
@testable import MailyExample

final class MailyExampleTests: XCTestCase {

    func testThatAllNeededInterfaceDeclarationsVisible() {
        _ = Maily.shared.cancelButtonTitle
        _ = Maily.shared.canSendMail
        _ = Maily.shared.clients
        Maily.shared.sendMail(recipient: nil, subject: nil, body: nil, presentHandler: nil, cancelHandler: nil)
        XCTAssert(true)
    }

    func testThatMailyOverridable() {
        final class MailyChild: Maily {
            override var cancelButtonTitle: String {
                get { return "" }
                set {}
            }
            override var canSendMail: Bool {
                return false
            }
            override var clients: [MailClient] {
                get { return [] }
                set {}
            }
            override func sendMail(
                recipient: String?,
                subject: String?,
                body: String?,
                presentHandler: (() -> Void)?,
                cancelHandler onCancel: (() -> Void)?
            ) {

            }
            override init() {
                super.init()
            }
        }
        _ = MailyChild()
        XCTAssert(true)
    }

    func testThatMailClientImplementable() {
        final class SomeMailClient: MailClient {
            var isAvailable: Bool = true
            var name: String = ""
            func sendEmail(recipient: String?, subject: String?, body: String?, presentHandler: (() -> Void)?) {}
        }
        _ = SomeMailClient()
        XCTAssert(true)
    }

    func testThatThirdPartyMailClientCreatable() {
        _ = ThirdPartyMailClient(name: "", scheme: "", root: "", recipientKey: nil, subjectKey: nil, bodyKey: nil)
    }

}
