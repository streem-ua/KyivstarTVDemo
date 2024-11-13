//
//  ActivityView.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

final class ActivityView: UIView {
    // MARK: - Properties
    private(set) var centerY: NSLayoutConstraint?
    let activityIndicator = UIActivityIndicatorView()
    
    var isAnimating: Bool {
        get {
            activityIndicator.isAnimating
        }
        set {
            newValue ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        addSubview(activityIndicator)
        activityIndicator.center = center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .black
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
}
