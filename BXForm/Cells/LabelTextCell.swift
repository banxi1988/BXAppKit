//
//  LabelTextCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/24.
//
//

import Foundation
// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//LabelTextCell:stc

open class LabelTextCell : StaticTableViewCell, LeadingLabelRow{
  open let labelLabel = UILabel(frame:.zero)
  open let inputTextField = UITextField(frame:.zero)

  public var textField:UITextField{
    return inputTextField
  }
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AbelTextCellCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
  open func bind(label:String,text:String){
    labelLabel.text  = label
    inputTextField.text  = text
  }
  
  open func bind(label:String,placeholder:String){
    labelLabel.text  = label
    inputTextField.placeholder  = placeholder
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [labelLabel,inputTextField]
  }
  var allUILabelOutlets :[UILabel]{
    return [labelLabel]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [inputTextField]
  }
  
  func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open var paddingLeft:CGFloat = FormMetrics.cellPaddingLeft{
    didSet{
      paddingLeftConstraint?.constant = paddingLeft
    }
  }
  
  open var paddingRight:CGFloat = FormMetrics.cellPaddingRight{
    didSet{
      paddingRightConstraint?.constant = paddingRight
    }
  }
  
  open var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }
  
  fileprivate var paddingLeftConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  fileprivate var labelWidthConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    labelLabel.pa_centerY.install()
     paddingLeftConstraint = labelLabel.pa_leadingMargin.eq(paddingLeft).install()
    labelWidthConstraint = labelLabel.pa_width.eq(labelWidth).install()
    
    inputTextField.pa_centerY.install()
    inputTextField.pa_height.eq(32).install()
    paddingRightConstraint = inputTextField.pa_trailingMargin.eq(paddingRight).install()
    inputTextField.pa_after(labelLabel,offset:8).install()
    
  }
  
  func setupAttrs(){
    setupLeadingLabel()
    
    inputTextField.textAlignment = .right
    
  }
  


  open var inputText:String{
    get{ return inputTextField.text?.trimmed() ?? "" }
    set{ inputTextField.text = newValue }
  }
  
  public var placeholder:String?{
    get{ return inputTextField.placeholder }
    set{
      if let str = newValue{
        inputTextField.attributedPlaceholder = NSAttributedString(string: str,attributes:[
          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
          NSAttributedStringKey.foregroundColor: FormColors.hintTextColor
          ])
      }else{
        inputTextField.attributedPlaceholder = nil
      }
    }
  }
}

