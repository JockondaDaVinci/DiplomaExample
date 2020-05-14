//
//  RangeSlider.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 30.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
  var minimumValue: Double = 0.0 {
    didSet {
      lowerValue = minimumValue
      updateLayerFrames()
    }
  }
  
  var maximumValue: Double = 1.0 {
    didSet {
      upperValue = maximumValue
      updateLayerFrames()
    }
  }
  
  var lowerValue: Double = 0.2 {
    didSet {
      updateLayerFrames()
    }
  }
  
  var upperValue: Double = 0.8 {
    didSet {
      updateLayerFrames()
    }
  }
  
  var eventHandler: EventHandler<(min: Double, max: Double)>?
  
  fileprivate var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
    didSet {
      trackLayer.setNeedsDisplay()
    }
  }
  
  fileprivate var trackHighlightTintColor: UIColor = AppDefaults.Colors.buttons {
    didSet {
      trackLayer.setNeedsDisplay()
    }
  }
  
  fileprivate var thumbTintColor: UIColor = UIColor.white {
    didSet {
      lowerThumbLayer.setNeedsDisplay()
      upperThumbLayer.setNeedsDisplay()
    }
  }
  
  fileprivate var curvaceousness: CGFloat = 1.0 {
    didSet {
      trackLayer.setNeedsDisplay()
      lowerThumbLayer.setNeedsDisplay()
      upperThumbLayer.setNeedsDisplay()
    }
  }
  
  private var previousLocation = CGPoint()
  private let trackLayer = RangeSliderTrackLayer()
  private let lowerThumbLayer = RangeSliderThumbLayer()
  private let upperThumbLayer = RangeSliderThumbLayer()
  private var thumbWidth: CGFloat{
    return CGFloat(bounds.height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    trackLayer.rangeSlider = self
    trackLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(trackLayer)
    
    lowerThumbLayer.rangeSlider = self
    lowerThumbLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(lowerThumbLayer)
    
    upperThumbLayer.rangeSlider = self
    upperThumbLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(upperThumbLayer)
    
    updateLayerFrames()
  }
  
  init() {
    super.init(frame: .zero)
    trackLayer.rangeSlider = self
    trackLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(trackLayer)
    
    lowerThumbLayer.rangeSlider = self
    lowerThumbLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(lowerThumbLayer)
    
    upperThumbLayer.rangeSlider = self
    upperThumbLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(upperThumbLayer)
    
    updateLayerFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func updateLayerFrames(){
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
    trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
    trackLayer.setNeedsDisplay()
    
    let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
    lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
    lowerThumbLayer.setNeedsDisplay()
    
    let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
    upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
    upperThumbLayer.setNeedsDisplay()
    
    CATransaction.commit()
  }
  
  func positionForValue(value: Double) -> Double{
    return Double(bounds.width - thumbWidth) * (value - minimumValue) / (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
  }
  
  override var frame: CGRect {
    didSet {
      updateLayerFrames()
    }
  }
  
  func boundValue(value: Double, to lowerValue: Double, upperValue: Double) -> Double{
    return min(max(value, lowerValue), upperValue)
  }
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    previousLocation = touch.location(in: self)
    
    // Hit test the thumb layers
    if lowerThumbLayer.frame.contains(previousLocation) {
      lowerThumbLayer.highlighted = true
    } else if upperThumbLayer.frame.contains(previousLocation) {
      upperThumbLayer.highlighted = true
    }
    
    return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let location = touch.location(in: self)
    
    //  Determine by how much the user has dragged
    let deltaLocation = Double(location.x - previousLocation.x)
    let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
    
    previousLocation = location
    
    //  Update the values
    if lowerThumbLayer.highlighted {
      lowerValue += deltaValue
      lowerValue = boundValue(value: lowerValue, to: minimumValue, upperValue: upperValue)
    } else if upperThumbLayer.highlighted {
      upperValue += deltaValue
      upperValue = boundValue(value: upperValue, to: lowerValue, upperValue: maximumValue)
    }
    
    sendActions(for: .valueChanged)
    return true
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    lowerThumbLayer.highlighted = false
    upperThumbLayer.highlighted = false
    
    eventHandler?((min: lowerValue, max: upperValue))
  }
}

class RangeSliderThumbLayer: CALayer{
  var highlighted: Bool = false{
    didSet{
      setNeedsLayout()
    }
  }
  weak var rangeSlider: RangeSlider?
  
  override func draw(in ctx: CGContext) {
    if let slider = rangeSlider{
      let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
      let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
      let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
      
      //            Fill
      let shadowColor = UIColor.gray
      ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
      ctx.setFillColor(slider.thumbTintColor.cgColor)
      ctx.addPath(thumbPath.cgPath)
      ctx.fillPath()
      
      //            Outline
      ctx.setStrokeColor(shadowColor.cgColor)
      ctx.setLineWidth(0.5)
      ctx.addPath(thumbPath.cgPath)
      ctx.strokePath()
      
      if highlighted{
        ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()
      }
    }
  }
}

class RangeSliderTrackLayer: CALayer {
  weak var rangeSlider: RangeSlider?
  
  override func draw(in ctx: CGContext) {
    if let slider = rangeSlider{
      //            Clip
      let cornerRadius = bounds.height * slider.curvaceousness / 2.0
      let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      ctx.addPath(path.cgPath)
      
      //            Fill the track
      ctx.setFillColor(slider.trackTintColor.cgColor)
      ctx.addPath(path.cgPath)
      ctx.fillPath()
      
      //            Fill the highlighted range
      ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
      let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
      let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
      let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
      ctx.fill(rect)
    }
  }
}
