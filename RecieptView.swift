//
//  RecieptView.swift
//  SayanInAppPayment
//
//  Created by Amir on 8/28/1397 AP.
//  Copyright © 1397 Sayan. All rights reserved.
//

import UIKit

class RecieptView: UIView {
    var contentView: UIView!
    var paymentEnqueryRes : PaymentEnqueryRes?
    @IBOutlet weak var Amoun: UILabel!
    @IBOutlet weak var CardAcqId: UILabel!
    @IBOutlet weak var TerminalId: UILabel!
    @IBOutlet weak var Rrn: UILabel!
    @IBOutlet weak var Trace: UILabel!
    @IBOutlet weak var TransDate: UILabel!
    
     override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
     
        
        
    }
    
    convenience init(frame: CGRect,model : PaymentEnqueryRes) {
        
        self.init(frame: frame)
        commonInit()
        self.tag = 981
        self.Amoun.text =  model.Amount.Seperate()
        self.CardAcqId.text = model.CardAcqId
        self.TerminalId.text = model.TerminalId
        self.Rrn.text = model.RetrivalRefNo
        self.Trace.text = model.SystemTraceNo
        self.TransDate.text = model.PersianTransactionDate
        self.paymentEnqueryRes = model
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func CompeleteBtn(_ sender: UIButton) {

        self.superview?.removeFromSuperview()
        
    
    }
    func commonInit(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Reciept", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.contentView.frame = self.bounds
        self.contentView.bounds = self.bounds
       
      addSubview(contentView)
    }
    
    
    
    
    
}
