//
//  BasicTextInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/9.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils
import PinAuto


public final class BasicTextInputCell : StaticTableViewCell,LeadingLabelRow{
  open let labelLabel = UILabel(frame:CGRect.zero)
  open let textView = ExpandableTextView(frame:CGRect.zero)
  open let countLabel = UILabel(frame:CGRect.zero)
  
  
  convenience init() {
    self.init(style: .default, reuseIdentifier: "BasicTextInputCell")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [textView,labelLabel,countLabel]
  }
  var allUITextViewOutlets :[UITextView]{
    return [textView]
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  

  
  open func bindLabel(_ label:String){
    labelLabel.text = label
    labelLabel.isHidden = label.isEmpty
    if label.isEmpty{
      textTopConstraint?.isActive = true
      textBelowLabelConstraint?.isActive = false
    }else{
      textTopConstraint?.isActive = false
      textBelowLabelConstraint?.isActive = true
    }
  }
  
  open func commonInit(){
    staticHeight = 140
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

  open var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }

  
  open var textBelowLabelConstraint:NSLayoutConstraint?
  open var textTopConstraint:NSLayoutConstraint?
  public var paddingLeftConstraint:NSLayoutConstraint?
  public var labelWidthConstraint:NSLayoutConstraint?
  
  open func installConstaints(){
    labelLabel.pa_top.eq(11).install()
    paddingLeftConstraint = labelLabel.pa_leadingMargin.eq(paddingLeft).install()
    labelWidthConstraint = labelLabel.pa_width.eq(labelWidth).install()
    
    textView.pac_horizontalMargin(offset: paddingLeft)
    
    textBelowLabelConstraint =  textView.pa_below(labelLabel, offset: 8).install()
    textBelowLabelConstraint?.isActive = true
    textTopConstraint = textView.pa_top.eq(12).install()
    textTopConstraint?.isActive = false
    
    countLabel.pa_below(textView, offset: 8).install()
    countLabel.pa_trailingMargin.eq(FormMetrics.cellPaddingRight).install()
    countLabel.pa_bottom.eq(10).install()
    
    textView.setContentHuggingPriority(UILayoutPriority(rawValue: 200), for: .vertical)
    
  }
  
  open func setupAttrs(){
    setupLeadingLabel()
    textView.textContainerInset = UIEdgeInsets.zero
    textView.setTextPlaceholderColor(FormColors.hintTextColor)
    textView.setTextPlaceholderFont(UIFont.systemFont(ofSize: FormMetrics.primaryFontSize))
    textView.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    textView.backgroundColor = FormColors.textFieldBackgroundColor
    textView.textColor = FormColors.accentColor
    
    countLabel.textColor = FormColors.hintTextColor
    countLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    
    textView.delegate = self
    
    textView.onTextDidChangeCallback = { text in
      self.countLabel.attributedText = self.createCountDownAttributedText(text)
    }
    countLabel.text = str(i18n("最多%d字"), inputMaxLength)
  }
  
  open func setTextPlaceholder(_ placeholder:String){
    textView.setTextPlaceholder(placeholder)
  }
  
  open var inputText:String{
    get { return textView.text ?? "" }
    set{ textView.text = newValue }
  }
  
  open var inputMaxLength = 100{
    didSet{
      if inputText.isEmpty{
        countLabel.text = str(i18n("最多%d字"), inputMaxLength)
      }else{
        self.countLabel.attributedText = self.createCountDownAttributedText(inputText.trimmed())
      }
    }
  }
  
  func createCountDownAttributedText(_ text:String) -> NSAttributedString{
    let count = text.trimmed().characters.count
    if count <= inputMaxLength{
      return NSAttributedString(string: "\(count)/\(inputMaxLength)")
    }else{
      let attributedText =  NSMutableAttributedString(string:"\(count)",attributes:[
        NSAttributedStringKey.foregroundColor:UIColor.red
        ])
      attributedText.append(NSAttributedString(string: "/ \(inputMaxLength)"))
      return attributedText
    }
  }
  
}


extension BasicTextInputCell: UITextViewDelegate{
  
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //NSLog("\(#function) \(range) \(text)")
    let content = textView.text ?? ""
    let currentCount = content.characters.count
    let postCount = currentCount + text.characters.count
    if range.length == 0 {
      // append
      return postCount <= inputMaxLength
    }else{
      // delete
      return true
    }
  }
}
