//
//  PrimaryButtonTableViewCell.swift
//  VV3CV4
//
//  Created by Haizhen Lee on 15/11/3.
//  Copyright © 2015年 vv3c. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils

// -PrimaryButtonCell
// primary[l42,t50,r42,h44]:b;span[r0,b8]:b

public final class PrimaryButtonCell : StaticTableViewCell{
  open let primaryButton = UIButton(type:.system)
  open let spanButton = UIButton(type:.system)
  open var primaryButtonTrailing: NSLayoutConstraint!
  open var primaryButtonLeading: NSLayoutConstraint!
  open var primaryButtonHeight:NSLayoutConstraint!
  open var buttonTop: NSLayoutConstraint!
  
  public init() {
    super.init(style: .default, reuseIdentifier: "PrimaryButtonCell")
    commonInit()
  
  }
  
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [primaryButton,spanButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [primaryButton,spanButton]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
 
  open var buttonHorizontalInset:CGFloat{
    get{
      return primaryButtonLeading.constant
    }set{
      primaryButtonLeading.constant = newValue
      primaryButtonTrailing.constant = -newValue
    }
  }
  
  open var buttonHeight:CGFloat{
    get{
      return primaryButtonHeight.constant
    }set{
      primaryButtonHeight.constant = newValue
    }
  }
  
  open var buttonMarginTop:CGFloat{
    get{
      return buttonTop.constant
    }set{
      buttonTop.constant = newValue
    }
  }
 
  open func commonInit(){
    frame = CGRect(x: 0, y: 0, width:screenWidth - 30, height: 160)
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    primaryButtonHeight = primaryButton.pa_height.eq(42).install()
    primaryButtonTrailing =  primaryButton.pa_trailingMargin.eq(FormMetrics.cellPaddingRight).install()
    primaryButtonLeading =  primaryButton.pa_leadingMargin.eq(FormMetrics.cellPaddingLeft).install()
    buttonTop =  primaryButton.pa_top.eq(50).install()
    
    spanButton.pa_before(primaryButton, offset: 0).install()  // pinTrailingEqualWithSibling(primaryButton)
    spanButton.pa_above(primaryButton, offset: 8).install() //pinAboveSibling(primaryButton, margin: 8)
    
  }
  
  func setupAttrs(){
    backgroundColor = FormColors.backgroundColor
    primaryButton.setupAsPrimaryActionButton()
    setPrimaryActionTitle(i18n("完成"))
    spanButton.isHidden = true //  currently only for login
    primaryButton.isEnabled = true
    primaryButton.isUserInteractionEnabled = true
  }
  
  open func setPrimaryActionTitle(_ title:String){
    primaryButton.setTitle(title, for: .normal)
  }
}
