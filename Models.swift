//
//  Models.swift
//  SayanInAppPayment
//
//  Created by Amir on 8/21/1397 AP.
//  Copyright © 1397 Sayan. All rights reserved.
//

import Foundation



struct KeyChangeApiResponse
{
    let ErrorCode : Int
    let WorkingKey : String
}

extension KeyChangeApiResponse: Decodable {
    
    private enum KeyChangeApiResponseCodingKeys: String, CodingKey {
        case ErrorCode = "ErrorCode"
        case WorkingKey = "WorkingKey"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KeyChangeApiResponseCodingKeys.self)
        
        ErrorCode = try container.decode(Int.self, forKey: .ErrorCode)
        WorkingKey = try container.decode(String.self, forKey: .WorkingKey)
        
        
    }
}

struct CardNo
{
    let CardNoMask : String
    let CardNoToken : String
    let ExpireDate : String
}

extension CardNo: Decodable {
    
    private enum CardNoCodingKeys: String, CodingKey {
        case CardNoMask = "CardNoMask"
        case CardNoToken = "CardNoToken"
        case ExpireDate = "ExpireDate"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CardNoCodingKeys.self)
        
        CardNoMask = try container.decode(String.self, forKey: .CardNoMask)
        CardNoToken = try container.decode(String.self, forKey: .CardNoToken)
        ExpireDate = try container.decode(String.self, forKey: .ExpireDate)
        
        
    }
}

struct CardNosApiResponse
{
    let ErrorCode : Int
    let CardNos : [CardNo]
}


extension CardNosApiResponse: Decodable {
    
    private enum CardNosApiResponseKeys: String, CodingKey {
        case ErrorCode = "ErrorCode"
        case CardNos = "CardNos"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CardNosApiResponseKeys.self)
        
        ErrorCode = try container.decode(Int.self, forKey: .ErrorCode)
        CardNos = try container.decode([CardNo].self, forKey: .CardNos)
        
    }
}


struct PaymentRequestRes
{
    let Status : Int
    let IsSucceed : Bool
    let InquiryToken : String
    
}

extension PaymentRequestRes: Decodable {
    
    private enum PaymentRequestResKeys: String, CodingKey {
        case Status = "Status"
        case IsSucceed = "IsSucceed"
        case InquiryToken = "InquiryToken"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaymentRequestResKeys.self)
        
        Status = try container.decode(Int.self, forKey: .Status)
        IsSucceed = try container.decode(Bool.self, forKey: .IsSucceed)
        InquiryToken = try container.decode(String.self, forKey: .InquiryToken)
        
    }
}

struct PaymentRequestApiResponse
{
    let ErrorCode : Int
    let PaymentRequestResponse : PaymentRequestRes
}


extension PaymentRequestApiResponse: Decodable {
    
    private enum PaymentRequestApiResponseKeys: String, CodingKey {
        case ErrorCode = "ErrorCode"
        case PaymentRequestResponse = "PaymentRequestResponse"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaymentRequestApiResponseKeys.self)
        
        ErrorCode = try container.decode(Int.self, forKey: .ErrorCode)
        PaymentRequestResponse = try container.decode(PaymentRequestRes.self, forKey: .PaymentRequestResponse)
        
    }
}


public struct PaymentEnqueryRes
{
    let CardAcqId : String?
    let Token : String?
    let TerminalId : String?
    let RetrivalRefNo : String?
    let SystemTraceNo : String?
    let PersianTransactionDate : String?
    let ResCode : String?
    let Message : String?
    let EnableRetryPayment : Bool
    let Status : Int
    let Amount : Int
    let OrderId : String?
}

extension PaymentEnqueryRes: Decodable {
    
    private enum PaymentEnqueryResKeys: String, CodingKey {
        case CardAcqId = "CardAcqId"
        case Token = "Token"
        case TerminalId = "TerminalId"
        case RetrivalRefNo = "RetrivalRefNo"
        case SystemTraceNo = "SystemTraceNo"
        case PersianTransactionDate = "PersianTransactionDate"
        case ResCode = "ResCode"
        case Message = "Message"
        case EnableRetryPayment = "EnableRetryPayment"
        case Status = "Status"
        case OrderId = "OrderId"
        case Amount = "Amount"
        
    }
    
    public   init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaymentEnqueryResKeys.self)
        
        CardAcqId = try container.decode(String?.self, forKey: .CardAcqId)
        Token = try container.decode(String?.self, forKey: .Token)
        TerminalId = try container.decode(String?.self, forKey: .TerminalId)
        RetrivalRefNo = try container.decode(String?.self, forKey: .RetrivalRefNo)
        SystemTraceNo = try container.decode(String?.self, forKey: .SystemTraceNo)
        PersianTransactionDate = try container.decode(String?.self, forKey: .PersianTransactionDate)
        ResCode = try container.decode(String?.self, forKey: .ResCode)
        Message = try container.decode(String?.self, forKey: .Message)
        EnableRetryPayment = try container.decode(Bool.self, forKey: .EnableRetryPayment)
        Status = try container.decode(Int.self, forKey: .Status)
        OrderId = try container.decode(String?.self, forKey: .OrderId)
        Amount = try container.decode(Int.self, forKey: .Amount)
        
    }
}


struct PaymentEnqueryApiResponse
{
    let ErrorCode : Int
    let PaymentReceiptModel : PaymentEnqueryRes
}


extension PaymentEnqueryApiResponse: Decodable {
    
    private enum PaymentEnqueryApiResponseKeys: String, CodingKey {
        case ErrorCode = "ErrorCode"
        case PaymentReceiptModel = "PaymentReceiptModel"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaymentEnqueryApiResponseKeys.self)
        
        ErrorCode = try container.decode(Int.self, forKey: .ErrorCode)
        PaymentReceiptModel = try container.decode(PaymentEnqueryRes.self, forKey: .PaymentReceiptModel)
        
    }
}








class PaymentRequestModel
{
    var CardNo : String? = ""
    var Pin : String? = ""
    var Cvv2 : String? = ""
    var Expiredate : String? = ""
    var OrderId : Int = 0
    var Amount  : Int = 0
    init (cardNo : String,pin : String,cvv2 : String,expireDate : String,orderId : Int,amount : Int)
    {
        self.CardNo  = cardNo
        self.Pin = pin
        self.Cvv2 = cvv2
        self.Expiredate = expireDate
        self.OrderId = orderId
        self.Amount = amount
        
    }
    
}


class CardWizardMemento
{
    var TextTitle : String? = ""
    var ValueText : String? = ""
    var OrginalData : String? = ""
    var StepId : Int? = 0
    var View : MainView
    var PaymentResult : PaymentEnqueryRes?
    
    init(textTitle : String,valueText : String,stepId : Int, view : MainView)
    {
        self.TextTitle = textTitle
        self.ValueText = valueText
        self.StepId  = stepId
        self.View = view
    }
    
    func GetValue() -> String?
    {
        return self.ValueText
    }
    
    func Action()
    {
        self.View.DoBtn.setTitle("بعدی", for: .normal)
        self.View.Inputtxt.isSecureTextEntry = false
        self.View.Inputtxt.placeholder = ""
        self.View.ViewCardNos.isHidden = true
        self.View.Inputtxt.isEnabled = true
        self.View.Inputtxt.isHidden = false
        self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.View.NewCardNoBtn.isHidden = true
        self.View.ExpireDate.isHidden = true
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.View.Inputtxt.alpha = 0.0
        }){ (Bool) -> Void in
            
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.View.Inputtxt.alpha = 1.0
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.View.InputTitle.alpha = 0.0
        }){ (Bool) -> Void in
            self.View.InputTitle.text = self.TextTitle
            self.View.Inputtxt.text = self.ValueText
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.View.InputTitle.alpha = 1.0
            }, completion: nil)
        }
    }
    
    
    
    func TextEditing(value: String)
    {
        
    }
    
    func Validate() -> Bool
    {
        return true;
    }
}

class BackWizardMemento : CardWizardMemento
{
    override func Action()
    {
        super.Action()
        CardWizardCaretaker.instance.Clear()
        self.View.removeFromSuperview()
        
    }
}

class CardNoWizardMemento : CardWizardMemento
{
    
    override func Action()
    {
        super.Action()
        if(self.ValueText != nil && self.ValueText!.count > 0)
        {
             self.View.Inputtxt.becomeFirstResponder()
            self.View.ViewCardNos.isHidden = false
            return;
        }
        self.View.CardNoContainer.isHidden = false
        Loading.Show(view: self.View, expectedCompleteAfter: 1)
        NetworkManagers.instance.CardNos { (res) in
            Loading.Hide(view: self.View)
            if(res.count == 0)
            {
                 self.View.NewCardNoBtn.isHidden = true
                self.View.Inputtxt.becomeFirstResponder()
                return;
            }
             self.View.NewCardNoBtn.isHidden = false
            self.View.endEditing(true)
            self.View.Inputtxt.isEnabled = false
            self.View.model = res
            self.View.CardNoList.reloadData()
        }
    }
    
    
    override func GetValue() -> String?
    {
        if(self.OrginalData == nil || self.OrginalData!.count == 0)
        {
            let   cardNo =  self.ValueText?.replacingOccurrences(of: "-", with: "") ?? ""
            return "C\(String(describing: cardNo))"
        }
        return   self.OrginalData
    }
    
    
    func matches(text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: ".{1,4}$|.{1,4}")
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    override func TextEditing(value: String)
    {
        self.OrginalData = ""
        var rt = value.replacingOccurrences(of: "-", with: "")
        rt  = String(rt.prefix(16))
        let lblTxt = rt.padding(toLength: 16, withPad: "x", startingAt: 0)
        let lbtTxM = matches(text: lblTxt)
        let r = matches(text: rt)
        let t =    r.joined(separator: "-")
        let lblTxT =    lbtTxM.joined(separator: "    ")
        
        if (!t.contains("*"))
        {
             self.View.Inputtxt.text = t
        }
       
        self.View.CardNoLbl.text = lblTxT
        if(rt.count < 6  && type(of:  self.View.CardView.layer.sublayers![0]) == type(of: CAGradientLayer()))
        {
            self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/shetab.png")!)
            self.View.CardView.layer.sublayers?.remove(at: 0)
        }
        if(rt.count == 6)
        {
            let gradientLayer = CAGradientLayer()
            
            gradientLayer.frame = self.View.CardView.bounds
            
            gradientLayer.name = "grat"
            
            if   type(of:  self.View.CardView.layer.sublayers![0]) == type(of: gradientLayer)
            {
                self.View.CardView.layer.sublayers?.remove(at: 0)
            }
            if(rt == "504706")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.7019607843, green: 0.1803921569, blue: 0.1843137255, alpha: 1).cgColor, #colorLiteral(red: 0.9333333333, green: 0.1921568627, blue: 0.2156862745, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/shahr.png")!)
            }
            if(rt == "610433")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.9450980392, green: 0.5764705882, blue: 0.6580381306, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/melat.png")!)
                
            }
            
            if(rt == "636214")
            {
         
                gradientLayer.colors = [#colorLiteral(red: 0.7803921569, green: 0.5490196078, blue: 0.06274509804, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/ayande.png")!)
                
            }
            
            if(rt == "627412")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.5058823529, green: 0.1921568627, blue: 0.5254901961, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.7529411765, blue: 0.7450980392, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/eghtesad.png")!)
                
            }
            
            if(rt == "627381")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.737254902, green: 0.7294117647, blue: 0.7333333333, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/ansar.png")!)
                
            }
            
            if(rt == "505785")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.9137254902, green: 0.8431372549, blue: 0.9921568627, alpha: 1).cgColor, #colorLiteral(red: 0.8666666667, green: 0.8352941176, blue: 0.9294117647, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/iranzamin.png")!)
                
            }
        
            if(rt == "622106")
            {
                
                gradientLayer.colors = [#colorLiteral(red: 0.7058823529, green: 0.2, blue: 0.07843137255, alpha: 1).cgColor, #colorLiteral(red: 0.9843137255, green: 0.5411764706, blue: 0.2823529412, alpha: 1).cgColor]
                self.View.BankLogo.load(url: URL(string: "http://5.160.81.106:6063/banklogo/parsian.png")!)
                
            }
            
            gradientLayer.locations = [0.25, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            gradientLayer.cornerRadius = 10
            
            self.View.CardView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
    }
    
    override func Validate() -> Bool {
        let rt = self.ValueText?.replacingOccurrences(of: "-", with: "")
        if(rt?.count ?? 0 < 16)
        {
            self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.9103549123, green: 0.4283533096, blue: 0.4046019316, alpha: 1)
            self.View.InputTitle.text = "شماره کارت صحیح نیست"
            return false;
        }
        return true;
    }
}


class ExpireDateWizardMemento : CardWizardMemento
{
    override func Action()
    {
        super.Action()
        self.View.CardNoContainer.isHidden = true
             self.View.ExpireDate.isHidden = false
        self.View.Inputtxt.isEnabled = false
        self.View.endEditing(true)
        
    }
    
    func matches(text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: ".{1,2}$|.{1,2}")
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    override func GetValue() -> String?
    {
        let expiredate = self.ValueText?.replacingOccurrences(of: " ", with: "") ?? ""
        let expd =  "\(String( describing: expiredate.suffix(2)))\(String(describing: expiredate.prefix(2)))"
        return expd;
    }
    
    
    override func TextEditing(value: String)
    {
        var rt = value.replacingOccurrences(of: " ", with: "")
        rt  = String(rt.prefix(4))
        let lblTxt = rt.padding(toLength: 4, withPad: "x", startingAt: 0)
        let lbtTxM = matches(text: lblTxt)
        let r = matches(text: rt)
        let t =    r.joined(separator: "  ")
        let lblTxT =    lbtTxM.joined(separator: "  ")
        self.View.Inputtxt.text = t
        self.View.ExpireDateLbl.text = lblTxT
    }
    
    override func Validate() -> Bool {
        let  rt = self.ValueText?.replacingOccurrences(of: " ", with: "") ?? "20"
        let mn  = Int( String(describing: rt.prefix(2))) ?? 20
        if(mn > 12 || rt.count < 4 )
        {
            self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.9103549123, green: 0.4283533096, blue: 0.4046019316, alpha: 1)
            self.View.InputTitle.text = "تاریخ انقضا صحیح نیست"
            return false;
        }
        return true;
    }
    
    
}

class Pin2WizardMemento : CardWizardMemento
{
    override func Action()
    {
        super.Action()
        self.View.Inputtxt.becomeFirstResponder()
        self.View.DoBtn.setTitle("پرداخت", for: .normal)
        self.View.Inputtxt.isSecureTextEntry = true
    }
    
    override func TextEditing(value: String)
    {
        let vv  = value.prefix(12)
        self.View.Inputtxt.text = String(vv)
    }
    
    
    override func Validate() -> Bool {
        let  rt = self.ValueText ?? ""
        if(rt.count > 12 || rt.count  <  5)
        {
            self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.9103549123, green: 0.4283533096, blue: 0.4046019316, alpha: 1)
            self.View.InputTitle.text = "رمز دوم صحیح نیست"
            return false;
        }
        return true;
    }
    
}

class Cvv2WizardMemento : CardWizardMemento
{
    override func Action()
    {
        
        super.Action()
        self.View.Inputtxt.becomeFirstResponder()
        self.View.Inputtxt.isSecureTextEntry = true
        
    }
    
    override func TextEditing(value: String)
    {
        let vv  = value.prefix(5)
        let rt = "";
        
        let lblTxt = rt.padding(toLength: vv.count, withPad: "*", startingAt: 0)
        
        self.View.Cvv2lbl.text = lblTxt;
        self.View.Inputtxt.text = String(vv)
        
        
    }
    
    override func Validate() -> Bool {
        let  rt = self.ValueText ?? ""
        if(rt.count > 5 || rt.count < 3 )
        {
            self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.9103549123, green: 0.4283533096, blue: 0.4046019316, alpha: 1)
            self.View.InputTitle.text = "CVV2 صحیح نیست"
            return false;
        }
        return true;
    }
    
    
}

struct EnquiryModel
{
    let token : String
    let amount : Int
    var tryCount : Int
    
    init(token : String,amount : Int,tryCount : Int)
    {
        self.token = token
        self.amount = amount
        self.tryCount = tryCount
    }
}

class FinalizePaymentHandeling : CardWizardMemento
{
    let cancelStatus = [-1001,-1002,-1003,-1004]
    override func Action()
    {
        self.View.Inputtxt.isHidden = true
        if self.PaymentResult == nil
        {
            LoadCancelNib()
            return;
        }
        if cancelStatus.contains(self.PaymentResult!.Status)
        {
            LoadCancelNib()
            return;
        }
      
       
        if(self.PaymentResult!.ResCode != "00")
        {
            if !self.PaymentResult!.EnableRetryPayment
            {
                LoadCancelNib()
                return;
            }
            
            self.View.endEditing(true)
            self.View.ContainerView.backgroundColor = #colorLiteral(red: 0.9103549123, green: 0.4283533096, blue: 0.4046019316, alpha: 1)
            var lbl = "در عملیات پرداخت شما خطایی رخ داده است"
            if self.PaymentResult!.Message != nil &&  self.PaymentResult!.Message!.count > 0
            {
                lbl = self.PaymentResult!.Message!
            }
            self.View.InputTitle.text = lbl
            self.View.DoBtn.setTitle("اصلاح اطلاعات", for: .normal)
            CardWizardCaretaker.instance.ResetState()
            return ;
        }
        
        LoadRecieptNib()
    }
    func LoadCancelNib()
    {
        self.View.endEditing(true)
        CardWizardCaretaker.instance.Clear()
        let screenSize: CGRect = self.View.bounds
        let recp = CancelView(frame: screenSize,model: self.PaymentResult!)
        self.View.addSubview(recp)
            SayanPaymentSdk.instance.delegate(self.PaymentResult!)
    }
    func LoadRecieptNib()
    {
         self.View.endEditing(true)
        CardWizardCaretaker.instance.Clear()
        let screenSize: CGRect = self.View.bounds
        let recp = RecieptView(frame: screenSize,model: self.PaymentResult!)
        self.View.addSubview(recp)
            SayanPaymentSdk.instance.delegate(self.PaymentResult!)
    }
}
class DoPaymentWizardMemento : CardWizardMemento
{
    override func Action()
    {
        let v = CardWizardCaretaker.instance.ValidateAll()
        if !v
        {

            self.View.Inputtxt.isHidden = true;
            self.View.DoBtn.setTitle("اصلاح اطلاعات", for: .normal)
            CardWizardCaretaker.instance.ResetState()
            return;
        }
        
        super.Action()
        
         self.View.endEditing(true)
        Loading.Show(view: self.View, expectedCompleteAfter: 0)
        let wzM = CardWizardCaretaker.instance.GetWizardValue()
        let model = PaymentRequestModel(cardNo: wzM.CardNo, pin: wzM.Pin, cvv2: wzM.CVV2, expireDate: wzM.ExpireDate, orderId: self.View.orderId, amount: self.View.amount)
        
        print(model)
        NetworkManagers.instance.PaymentRequest(requestModel: model) { (res) in
            let enq = res?.InquiryToken ?? ""
            if(enq.count < 5)
            {
                NetworkManagers.instance.KeyChange(callback: { (res) in
                    Loading.Hide(view: self.View)
                    let m = PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-2", Message: "خطا در دریافت توکن", EnableRetryPayment: false, Status: -1001, Amount: self.View.amount , OrderId: String(self.View.orderId))
                    CardWizardCaretaker.instance.FinalizePayment(model: m)
                    return ;
                })
                
            }
            let model = EnquiryModel(token: enq, amount: self.View.amount, tryCount: 0)
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.Enquiry(sender:)), userInfo:  model, repeats: false);
            
        }
        
    }
    @objc func Enquiry(sender: Timer)
    {
        var m = sender.userInfo as? EnquiryModel
        if(m == nil)
        {
            Loading.Hide(view: self.View)
            let m = PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-2", Message: "خطا در بازیافت اطلاعات استعلام", EnableRetryPayment: false, Status: -1002, Amount: self.View.amount , OrderId: String(self.View.orderId))
            CardWizardCaretaker.instance.FinalizePayment(model: m)
            return ;
        }
        NetworkManagers.instance.PaymentEnquery(token: m!.token, callback: { (enres) in
            if(enres?.ErrorCode == -4002)
            {
                NetworkManagers.instance.KeyChange(callback: { (res) in
                    Loading.Hide(view: self.View)
                    let m = PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-2", Message: "خطا در بازیابی اطلاعات رمز استعلام", EnableRetryPayment: false, Status: -1003, Amount: self.View.amount , OrderId: String(self.View.orderId))
                    CardWizardCaretaker.instance.FinalizePayment(model: m)
                    return ;
                })
            }
            if(enres?.PaymentReceiptModel.Status == 4 )
            {
                m!.tryCount = m!.tryCount  + 1
                
                if(m!.tryCount > 10)
                {
                    Loading.Hide(view: self.View)
                    let m = PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-2", Message: "خطا دریافت پاسخ سرویس استعلام", EnableRetryPayment: false, Status: -1004, Amount: self.View.amount , OrderId: String(self.View.orderId))
                    CardWizardCaretaker.instance.FinalizePayment(model: m)
                    return ;
                }
                
                Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.Enquiry(sender:)), userInfo:  m, repeats: false);
                return;
                
            }
            
            Loading.Hide(view: self.View)
            CardWizardCaretaker.instance.FinalizePayment(model: enres!.PaymentReceiptModel)
            
        })
    }
    
   
    
  
}

struct CardWizardValues
{
    let CardNo : String
    let CVV2  : String
    let ExpireDate : String
    let Pin : String
    
}

class CardWizardCaretaker
{
    static let instance = CardWizardCaretaker()
    var savedStates : [CardWizardMemento] = []
    private var currentState : Int = 0;
    private  init() {}
    
    func Add(memnto : CardWizardMemento)
    {
        savedStates.append(memnto)
    }
    
    func GetWizardValue() -> CardWizardValues
    {
        let tc = self
        let cardNo = tc.GetValue(stepId: 0) ?? ""
        let cvv2 = tc.GetValue(stepId: 1) ?? ""
        let expiredate = tc.GetValue(stepId: 2) ?? ""
        let pin = tc.GetValue(stepId: 3) ?? ""
        let wz = CardWizardValues(CardNo: cardNo, CVV2: cvv2, ExpireDate: expiredate, Pin: pin)
        return wz;
    }
    func FinalizePayment(model : PaymentEnqueryRes?)
    {
        let m = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == -2
        })
        
        m?.PaymentResult = model
        m?.Action()
    }
    
    func SetOrginalData(value: String,stepId : Int)
    {
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == stepId
        })
        res?.OrginalData  = value
    }
    
    func Get()
    {
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        res?.Action();
    }
    
    func ResetState()
    {
        self.currentState = -1;
    }
    func Next()
    {
        self.currentState =  self.currentState  + 1
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        res?.Action();
    }
    
    func Next(input : String)
    {
        if(self.currentState > 5 )
        {
            return
        }
        self.UpdateValue(stepId: self.currentState, value: input)
        let current = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        let valid = current?.Validate() ?? true
        if(!valid)
        {
            return;
        }
        self.currentState =  self.currentState  + 1
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        res?.Action();
    }
    
    func Clear()
    {
        self.savedStates.forEach { (res) in
            res.ValueText = ""
            res.TextEditing(value: "")
            
        }
        self.currentState = 0 ;
    }
    
    func ValidateAll() -> Bool
    {
        var valid : Bool = false;
        for res in self.savedStates
        {
            valid = res.Validate()
            if !valid
            {
                break;
            }
        }
        return valid;
    }
    
    func Pervouse()
    {
        if(self.currentState <= 0 )
        {
            self.Get(stepId: -1)
        }
        self.currentState =  self.currentState  - 1
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        res?.Action();
    }
    
    func Get(stepId : Int)
    {
        self.currentState =  stepId
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == stepId
        })
        res?.Action();
    }
    
    func GetValue(stepId : Int) -> String?
    {
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == stepId
        })
        return res?.GetValue()
    }
    
    func ValueChange(value : String)
    {
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == self.currentState
        })
        res?.TextEditing(value: value);
    }
    
    func UpdateValue(stepId : Int,value : String)
    {
        let res = self.savedStates.first(where: { (r) -> Bool in
            r.StepId == stepId
        })
        res?.ValueText = value
    }
}


public class SayanPaymentSdk
{
    public static let instance = SayanPaymentSdk()
    private var paymentView : MainView?
    var delegate : (PaymentEnqueryRes?) -> Void
    private  init()
    {
        self.delegate = {_ in }
    }
    public func Payment(orderId: Int,amount : Int,phoneNo : String,view : UIView,callback: @escaping (PaymentEnqueryRes?) -> Void)
    {
        
        if (orderId == 0 )
        {
            callback(PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-1", Message: "شماره سفارش صحیح نیست", EnableRetryPayment: false, Status: 11, Amount: amount, OrderId: String(orderId)))
            return;
        }
        if(amount < 1000 || amount > 50000000)
        {
            callback(PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-1", Message: "مبلغ صحیح نیست", EnableRetryPayment: false, Status: 12, Amount: amount, OrderId: String(orderId)))
            return;
        }
        
        if(phoneNo.count != 11 && String(phoneNo.prefix(1)) != "0" )
        {
            callback(PaymentEnqueryRes(CardAcqId: nil, Token: nil, TerminalId: nil, RetrivalRefNo: nil, SystemTraceNo: nil, PersianTransactionDate: nil, ResCode: "-1", Message: "شماره همراه ۱۱ رقم و با صفر اول ارسال گردد", EnableRetryPayment: false, Status: 10, Amount: amount, OrderId: String(orderId)))
            return;
        }
       
        if(self.paymentView == nil)
        {
            self.paymentView = MainView(frame: view.bounds, amount: amount, orderId: orderId)
        }
        if let viewWithTag = self.paymentView!.viewWithTag(981) {
            
            viewWithTag.removeFromSuperview()
        }
        
        self.paymentView!.layoutIfNeeded()
        self.paymentView!.amount = amount
        self.paymentView!.orderId = orderId
        self.paymentView!.InitView()
        self.delegate = callback
        view.addSubview(self.paymentView!)
        CardWizardCaretaker.instance.Get()
        let s = StringService()
        let rphoneNo = s.getPhoneNo()
        let key = s.getWorkingKey()
        if rphoneNo.count == 0 || rphoneNo != phoneNo  || key.count == 0
        {
            s.setPhoneNo(value: phoneNo)
            Loading.Show(view: self.paymentView!, expectedCompleteAfter: 1)
            NetworkManagers.instance.KeyChange(callback: { (res) in
                 Loading.Hide(view: self.paymentView!)
                if (res == nil || res != 0 )
                {
                    
                    
                    self.paymentView!.removeFromSuperview()
                }
                CardWizardCaretaker.instance.Get()
               
            })
        }
      
    }
    
    func InitView(orderId: Int,amount : Int,phoneNo : String,view : UIView,callback: @escaping (PaymentEnqueryRes?) -> Void)
    {
       
    }
}

extension Int{
    func Seperate() -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value : self))!
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



