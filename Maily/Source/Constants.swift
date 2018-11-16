//
//  Constants.swift
//  Maily
//
//  Created by Ivan Smetanin on 23/10/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

enum Constants {

    public static let standardClients: [MailClient] = [
        StandardMailClient.shared,

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
