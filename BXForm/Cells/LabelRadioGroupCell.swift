//
//  LabelRadioGroupCell.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 11/07/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit
import BXModel
import BXiOSUtils


public final class LabelRadioGroupCell<T:RadioOption> : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let radioGroup = RadioGroup<T>()


  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelRadioGroupCell")
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
    return [labelLabel,radioGroup]
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

  public var paddingLeftConstraint:NSLayoutConstraint?
  public var labelWidthConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?



  open func installConstaints(){
    installLeadingLabelConstraints()
    radioGroup.pa_centerY.install()
    paddingRightConstraint =  radioGroup.pa_trailingMargin.eq(paddingRight).install()
  }

  open func setupAttrs(){
    setupLeadingLabel()
    accessoryType = .none

  }



}
