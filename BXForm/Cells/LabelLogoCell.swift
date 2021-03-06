//
//  LabelLogoCell.swift
//  Pods
//
//
//

import Foundation
import UIKit
import BXModel
import BXiOSUtils


public final class LabelLogoCell : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let logoImageView = OvalImageView()
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelSpanCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open var allOutlets :[UIView]{
    return [labelLabel,logoImageView]
  }
  
  open func commonInit(){
    staticHeight = 68
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
  
  open var logoWidth:CGFloat = 52{
    didSet{
      logoWidthConstraint?.constant = logoWidth
      staticHeight = logoWidth + 16
    }
  }
  
  public var paddingLeftConstraint:NSLayoutConstraint?
   public var labelWidthConstraint:NSLayoutConstraint?
    fileprivate var paddingRightConstraint:NSLayoutConstraint?
    fileprivate var logoWidthConstraint:NSLayoutConstraint?
  
  
  
  open func installConstaints(){
    installLeadingLabelConstraints()
    logoImageView.pa_aspectRatio(1.0).install()
    logoWidthConstraint =  logoImageView.pa_width.eq(logoWidth).install()
    paddingRightConstraint =  logoImageView.pa_trailingMargin.eq(paddingRight).install()
  }
  
  open func setupAttrs(){
    setupLeadingLabel()
    accessoryType = .disclosureIndicator
    
  }
  

  
}
