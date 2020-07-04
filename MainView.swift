//
//  MainView.swift
//  SayanInAppPayment
//
//  Created by Amir on 8/20/1397 AP.
//  Copyright © 1397 Sayan. All rights reserved.
//

import UIKit

class MainView: UIView ,UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    let month = ["ماه", "01","02","03","04","05","06","07","08","09","10","11","12"]
     let year = ["سال","97","98","99","00","01","02","03","04","05","06","07","08","09","10","11","12"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.month.count
        } else {
            return self.year.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
            if component == 0 {
                return month[row]
            } else {
                return year[row]
            }
      }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0
        {
            return;
        }
        let rt = self.Inputtxt.text!.replacingOccurrences(of: " ", with: "")
        if component == 0 {
            let str = String( rt.suffix(2))
            self.Inputtxt.text = month[row] + str
        } else {
            let str = String( rt.prefix(2))
            self.Inputtxt.text = str + year[row]
        }
        
          CardWizardCaretaker.instance.ValueChange(value: self.Inputtxt.text!)
        
    }
    
    var model : [CardNo] = []
    var amount : Int = 0
    var orderId : Int = 0
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return model.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        var cell: CustomOneCell! = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? CustomOneCell
        if cell == nil {
             let bundle = Bundle(for: type(of: self))
            tableView.register(UINib(nibName: "CardNoCellView", bundle: bundle), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier,for:indexPath ) as? CustomOneCell
           
        }
         cell.CardNo.text = model[indexPath.row].CardNoMask
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          CardWizardCaretaker.instance.ValueChange(value:  model[indexPath.row].CardNoMask)
        CardWizardCaretaker.instance.Next(input:  model[indexPath.row].CardNoMask)
         CardWizardCaretaker.instance.SetOrginalData(value: "T\(model[indexPath.row].CardNoToken)", stepId: 0)
      
    }
    
    @IBOutlet weak var NewCardNoBtn: UIButton!
    @IBOutlet weak var CardNoContainer: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var CardView: UIView!
    
    @IBOutlet var ExpireDate: UIPickerView!
    @IBOutlet weak var BankLogo: UIImageView!
    @IBOutlet weak var CardNoList: UITableView!
    
    @IBOutlet weak var ViewCardNos: UIButton!
    @IBOutlet weak var ExpireDateLbl: UILabel!
    @IBOutlet weak var Cvv2lbl: UILabel!
    @IBOutlet weak var CardNoLbl: UILabel!
    @IBOutlet weak var DoBtn: UIButton!
    @IBOutlet weak var Inputtxt: UITextField!
    
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var InputTitle: UILabel!
    var contentView: UIView!
    
    
     override init(frame: CGRect) {
          super.init(frame: frame)
        setUpView()
        
    }
    
    init(frame: CGRect, amount : Int, orderId : Int) {
        super.init(frame: frame)
        setUpView()
        self.amount = amount
        self.orderId = orderId
        
    }
    
    @IBAction func CardNoEdit(_ sender: UIButton) {
        CardWizardCaretaker.instance.Get(stepId: 0)
    }
    
    @IBAction func Cvv2Edit(_ sender: UIButton) {
         CardWizardCaretaker.instance.Get(stepId: 1)
    }
    
    @IBAction func ExpireDateEdit(_ sender: UIButton) {
         CardWizardCaretaker.instance.Get(stepId: 2)
    }
    
    
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    @IBAction func TextBoxEditing(_ sender: UITextField) {
        CardWizardCaretaker.instance.ValueChange(value: sender.text!)
    }
    
    @IBAction func NextBtnTouched(_ sender: UIButton) {
        CardWizardCaretaker.instance.Next(input: Inputtxt.text!)
       
    }
    
    @IBAction func InputCardNoTouched(_ sender: UIButton) {
          Inputtxt.isEnabled = true
          NewCardNoBtn.isHidden = true
        Inputtxt.text = ""
        self.Inputtxt.becomeFirstResponder()
        self.ViewCardNos.isHidden = false
      
    }
    @IBAction func ViewCardNoListTouched(_ sender: UIButton) {
           self.endEditing(true)
         self.ViewCardNos.isHidden = true
        Inputtxt.isEnabled = false
          NewCardNoBtn.isHidden = false
        Inputtxt.text = ""
    }
    @IBAction func BackBtnTouched(_ sender: UIButton) {
         CardWizardCaretaker.instance.Pervouse()
    }
    
    func InitView()
    {
        self.amountLbl.text = "مبلغ : \(self.amount.Seperate())" 

    }
    private func setUpView() {
        var  nibName = "2XView"
        if(self.bounds.height < 570)
        {
            nibName = "View"
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.contentView.frame = self.bounds
        self.contentView.bounds = self.bounds
    
        let cellNib = UINib(nibName: "CardNoCellView", bundle: bundle)
        cellNib.instantiate(withOwner: CustomOneCell(), options: nil)
        self.CardNoList.register(cellNib, forCellReuseIdentifier: "Cell")
        contentView.layoutIfNeeded()
        addSubview(contentView)
         
        self.CardNoList.dataSource = self
        self.CardNoList.delegate = self
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.layoutIfNeeded()
        
        self.ExpireDate.delegate = self
        self.ExpireDate.dataSource = self
        
          CardWizardCaretaker.instance.Add(memnto: BackWizardMemento(textTitle: "", valueText: "", stepId: -1,view : self))
        CardWizardCaretaker.instance.Add(memnto: CardNoWizardMemento(textTitle: "شماره کارت را وارد نمایید", valueText: "", stepId: 0,view : self))
         CardWizardCaretaker.instance.Add(memnto: Cvv2WizardMemento(textTitle: "CVV2 را وارد نمایید", valueText: "", stepId: 1,view : self))
         CardWizardCaretaker.instance.Add(memnto: ExpireDateWizardMemento(textTitle: "تاریخ انقضا را وارد نمایید", valueText: "", stepId: 2,view : self))
         CardWizardCaretaker.instance.Add(memnto: Pin2WizardMemento(textTitle: "رمز دوم را وارد نمایید", valueText: "", stepId: 3,view : self))
         CardWizardCaretaker.instance.Add(memnto: DoPaymentWizardMemento(textTitle: "در حال انجام تراکنش", valueText: "", stepId: 4,view : self))
        CardWizardCaretaker.instance.Add(memnto: FinalizePaymentHandeling(textTitle: "در حال انجام تراکنش", valueText: "", stepId: -2,view : self))
        
        
        
         CardWizardCaretaker.instance.Get()
        

        
       
        
    }
    

    
}

