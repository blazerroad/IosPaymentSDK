
# 1.	Introduction
In order to provide e-banking services, Neevar has implemented a paid in-app payment library. This system allows customers to pay for goods / services through all the Shetab cards in the Internet platform.
This document describes the communication protocol for mobile payment gateway and merchant app (provider of goods / services).

# 2.	Scope
The scope of this document describes the purchase process of a mobile payment gateway and includes a full description of the methods and specifications of the web services used by the acceptors and the list of the error codes for payment gateway.

# 3.	Prerequisites
At the same time as we conclude a contract between the acceptor and the service provider company and defining the acceptor in Shparak System the necessary information (the acceptor's number, the terminal number and the communication key) will become available to acceptors.

•	The security key for encryption and authentication will be used as described in the document.

•	Acceptors are obliged only send transactions through pre-announced IP addresses

•	All information that described above will be provided to the acceptor’s Agent confidentially.


# 4.	Overall description of payment procedure
## Library call
To initiate payment, the client must call the payment library with the required parameters. By calling the library, the payment page is displayed to the cardholder, and if the transaction is successful, the result and the transaction token are returned to the caller system.
## Receive the operation response from the library
After receiving the result of the operation, the acceptor’s App sends the received information to the server and confirms the correctness of the operation.
## Complete the purchase process by sending Advice or reverse transaction
In case the transaction is successful, the acceptor will send the Advice or reverse transaction.

 # 5.	How to use the library to perform a transaction on iOS
The folder that is available to acceptors contains 2 files and a sample implementation code folder. Two SayanInAppPayment.framework files are located in the FrameworkWithBitCode and FrameworkWihtoutBitCode folders, which can use the file, depending on the setting of acceptors App.

First, transfer the SayanInAppPayment.framework file to your project
At the beginning of your file that calls payment, insert the following:

```swift
import SayanInAppPayment
```
Call the method below when you click the payment button on your App:
```swift
SayanPaymentSdk.instance.Payment(orderId: $INT$, amount: $INT$, phoneNo: $STRING$,view: self.view) { (res) in
            CODE
        }

```

After calling the method below the payment page is displayed and the payment process is done. Finally, the method introduced in the CallBack variable will be called on the acceptor’s App side.
The following table describes the error conditions in the IOS framework. Obviously other error codes will be in accordance with the current document.

| Error code | Description |
| --- | --- |
| -1001 | "Error receiving token" |
| -1002 | "Error retrieving inquiry information" |
| -1003 | "Error retrieving inquiry password information" |
| -1004 | "Error receiving inquiry service response" |

# Highlights on calling Reverse Service

•	The acceptor will only be able to send reverse transaction after 30 minutes after the successful transaction or sending advice, and after the expiration of the deadline, there is no possibility to call the service; in this case, if the acceptor of the transaction has verified the successful transaction, and otherwise the transaction will be reversed.

•	In case of both advice and revers service sent simultaneously or calling multiple times, and the response of these services are successful the criterion for determining the transaction status is the successful response of the reverse transaction.

•	The acceptor is required to determine transaction status at a limited time after the end of the successful transaction.

•	In the closing hours of the day (23-24), if the Reverse service is called, if the purchase transaction is carried out on a financial day and the transaction is returned on the next financial day, due to the routine of SHPARAK transactions, in some cases, the transaction amount Returns to the account holder no later than three days after the transaction date (it will not be returned immediately).

•	The acceptor should repeat the call of the service if it does not receive the response






