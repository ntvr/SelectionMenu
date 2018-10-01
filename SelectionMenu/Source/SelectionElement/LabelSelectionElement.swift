//
//  LabelSelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/09/2018.
//

import Foundation
import UIKit

/// Selection element view with UILabel centered within it
public class LabelSelectionElement: UIView, SelectionElement {
    /// Label contained within background view and centered within it.
    public weak var label: UILabel!
    /// Background having same size as the superview.
    public weak var backgroundView: UIView!

    /// Initializes ContainerSelectionElement
    ///
    /// - Parameter text: Initial text to be set into label
    /// - Parameter backgroundRatio: Ratio between backgroundView and element, has to be in between 0 and 1
    public init(text: String? = nil, backgroundRatio: Double = 1.0) {
        assert(0...1 ~= backgroundRatio)

        super.init(frame: .zero)

        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        let label = UILabel()
        backgroundView.addSubview(label)
        label.text = text
        self.label = label

        setupConstraints(with: backgroundRatio)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension LabelSelectionElement {
    public func expand(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = .identity
    }

    public func collapse(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Stylable
extension LabelSelectionElement {
    public var foregroundColorStylable: UIColor? {
        get { return label.textColor }
        set { label.textColor = newValue ?? label.textColor }
    }

    public var backgroundColorStylable: UIColor? {
        get { return backgroundView.backgroundColor }
        set { backgroundView.backgroundColor = newValue }
    }

    public var circularStylable: Bool {
        get { return backgroundView.circular }
        set { backgroundView.circular = newValue }
    }

    public var shadowedLayerStylable: CALayer? {
        return layer
    }
}

// MARK: - Setup
private extension LabelSelectionElement {
    func setupConstraints(with backgroundRatio: Double) {
        backgroundView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(backgroundRatio)
        }

        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }
    }
}
