//
//  CancelView.swift
//  SayanInAppPayment
//
//  Created by Amir on 8/30/1397 AP.
//  Copyright © 1397 Sayan. All rights reserved.
//

import UIKit

class CancelView: UIView {
    var contentView: UIView!
    var paymentEnqueryRes : PaymentEnqueryRes?
   
    override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,model : PaymentEnqueryRes) {
        
        self.init(frame: frame)
        commonInit()
        self.tag = 981
        self.paymentEnqueryRes = model
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Cancel", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.contentView.frame = self.bounds
        self.contentView.bounds = self.bounds
        addSubview(contentView)
    }
    
    
   
    @IBAction func BtnTouched(_ sender: UIButton) {
        self.superview?.removeFromSuperview()
       
    }
    
}
