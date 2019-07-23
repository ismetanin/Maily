# Maily

Send email to third-party mail clients easy.

## Supported clients

Client             | URL Scheme
------------------ | ---------------
Gmail              | `googlegmail`  
Dispatch           | `x-dispatch`
Spark              | `readdle-spark`
Airmail            | `airmail`  
Microsoft Outlook  | `ms-outlook`
Yahoo Mail         | `ymail`

## Installation

Manually import files from `Source` folder to your project

## Usage

Before start you are required to add all needed schemes to your `LSApplicationQueriesSchemes` in the **Info.plist** file. Without this step you won't be able to find third party clients.

<details>
  <summary>Code to drop into <b>Info.plist</b> </summary>
  <br>

   ```xml
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>ymail</string>
        <string>ms-outlook</string>
        <string>airmail</string>
        <string>readdle-spark</string>
        <string>x-dispatch</string>
        <string>googlegmail</string>
    </array>
   ```

</details>

### Present dialog to send email to available clients

```swift
Maily.shared.sendMail(recipient: "", subject: "", body: "", presentHandler: {}, cancelHandler: {})
```

Before this action you'll probably want to check clients availability, to do this you may call

```swift
Maily.shared.canSendMail
```

To access available client you may just use

```swift
Maily.shared.clients
```

### Localization

To localize action sheet "Cancel" button you can just change `cancelButtonTitle` property in `Maily.shared`.

### Customization

Almost every class, property, and method are `open` so you can just subclass or build Facade over them.

To add new third party client you may can add it to the `Maily.shared.clients`, or contribute to this library.

## Requirements

- iOS 10+
- Xcode 10.2+ (built for Swift 5)

## Author

Ivan Smetanin, smetanin23@yandex.ru

## License

Maily is available under the MIT license. See the [LICENSE](https://github.com/ismetanin/Maily/blob/master/LICENSE) file for more info.
