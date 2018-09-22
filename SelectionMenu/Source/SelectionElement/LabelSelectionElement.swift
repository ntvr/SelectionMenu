//
//  LabelSelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/09/2018.
//

import Foundation
import UIKit

/// Selection element view with UILabel centered within it
class LabelSelectionElement: UIView, SelectionElement {
    /// Label contained within background view and centered within it.
    public weak var label: UILabel!
    /// Background having same size as the superview.
    public weak var backgroundView: UIView!

    /// Initializes ContainerSelectionElement
    public init() {
        super.init(frame: .zero)

        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        let label = UILabel()
        backgroundView.addSubview(label)
        self.label = label

        setupConstraints()
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
    func setupConstraints() {
        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }
    }
}
