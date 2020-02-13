//
//  ASLayoutSpec+Ex.swift
//  MVC
//
//  Created by Hyeon su Ha on 13/02/2020.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

enum LayoutSpecBuildableOptions {
  
  case safeArea
  case layoutMargins
}

protocol LayoutSpecBuildable {
  
  var layoutSpec: ASLayoutSpec { get }
}

private var layoutSpecBuildableConstrainedSizeKey: String = "LayoutSpecBuildable.constrainedSize"

extension LayoutSpecBuildable where Self: ASDisplayNode {
  
  var constraintedSize: ASSizeRange {
    get {
      return (objc_getAssociatedObject(
        self,
        &layoutSpecBuildableConstrainedSizeKey
        ) as? ASSizeRange) ?? ASSizeRangeUnconstrained
    }
    set {
      objc_setAssociatedObject(
        self,
        &layoutSpecBuildableConstrainedSizeKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }
  
  func automaticallyManagesLayoutSpecBuilder(changeSet: LayoutSpecBuildableOptions...) {
    self.automaticallyManagesSubnodes = true
    self.automaticallyRelayoutOnSafeAreaChanges = changeSet.contains(.safeArea)
    self.automaticallyRelayoutOnLayoutMarginsChanges = changeSet.contains(.layoutMargins)
    self.layoutSpecBlock = { [weak self] (_, sizeRange) -> ASLayoutSpec in
      self?.constraintedSize = sizeRange
      return self?.layoutSpec ?? ASLayoutSpec()
    }
  }
}

extension ASLayoutElementStyle {
  
  @discardableResult
  func shrink(value: CGFloat = 1.0) -> Self {
    self.flexShrink = value
    return self
  }
  
  @discardableResult
  func grow(value: CGFloat = 1.0) -> Self {
    self.flexGrow = value
    return self
  }
  
  @discardableResult
  func nonShrink() -> Self {
    self.flexShrink = 0.0
    return self
  }
  
  @discardableResult
  func nonGrow() -> Self {
    self.flexGrow = 0.0
    return self
  }
  
  @discardableResult
  func width(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.width = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func height(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.height = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func maxWidth(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.maxWidth = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func maxHeight(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.maxHeight = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func minWidth(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.minWidth = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func minHeight(_ value: CGFloat, unit: ASDimensionUnit = .points) -> Self {
    self.minHeight = ASDimension.init(unit: unit, value: value)
    return self
  }
  
  @discardableResult
  func size(_ value: CGSize) -> Self {
    self.preferredSize = value
    return self
  }
  
  @discardableResult
  func maxSize(_ value: CGSize) -> Self {
    self.maxSize = value
    return self
  }
  
  @discardableResult
  func minSize(_ value: CGSize) -> Self {
    self.minSize = value
    return self
  }
  
  @discardableResult
  func spacingAfter(_ value: CGFloat) -> Self {
    self.spacingAfter = value
    return self
  }
  
  @discardableResult
  func spacingBefore(_ value: CGFloat) -> Self {
    self.spacingBefore = value
    return self
  }
}
