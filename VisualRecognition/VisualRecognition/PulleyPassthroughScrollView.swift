//
//  PulleyPassthroughScrollViewDelegate.swift
//  Visual Recognition
//
//  Created by Nicholas Bourdakos on 3/17/17.
//  Copyright © 2017 Nicholas Bourdakos. All rights reserved.
//

import UIKit

protocol PulleyPassthroughScrollViewDelegate: class {
    
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView
}

class PulleyPassthroughScrollView: UIScrollView {
    
    weak var touchDelegate: PulleyPassthroughScrollViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if let touchDel = touchDelegate
        {
            if touchDel.shouldTouchPassthroughScrollView(scrollView: self, point: point)
            {
                return touchDel.viewToReceiveTouch(scrollView: self).hitTest(touchDel.viewToReceiveTouch(scrollView: self).convert(point, from: self), with: event)
            }
        }
        
        return super.hitTest(point, with: event)
    }
}
