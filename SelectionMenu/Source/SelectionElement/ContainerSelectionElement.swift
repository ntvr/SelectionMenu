//
//  ContainerSelectionElement.swift
//  FBSnapshotTestCase
//
//  Created by Michal Štembera on 17/09/2018.
//

import Foundation

/// Selection element view with UIImageView centered within it
public typealias ImageSelectionElement = ContainerSelectionElement<UIImageView>

/// Selection element view with UILabel centered within it
public typealias LabelSelectionElement = ContainerSelectionElement<UILabel>
extension ContainerSelectionElement where ContainedView == UILabel {
    public var foregroundColorStylable: UIColor? {
        get { return containedView.textColor }
        set { containedView.textColor = newValue }
    }
}

open class ContainerSelectionElement<ContainedView: UIView>: UIView, SelectionElement {
    /// View contained within background view nad centered within it.
    public weak var containedView: ContainedView!
    /// Background having same size as the superview.
    public weak var backgroundView: UIView!

    /// Initializes ContainerSelectionElement
    public init() {
        super.init(frame: .zero)

        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        let contentView = ContainedView()
        backgroundView.addSubview(contentView)
        self.containedView = contentView

        setupConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SelectionElement
    public func expand(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = .identity
    }

    public func collapse(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Stylable
extension ContainerSelectionElement {
    public var foregroundColorStylable: UIColor? {
        get { return containedView.tintColor }
        set { containedView.tintColor = newValue ?? containedView.tintColor }
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
private extension ContainerSelectionElement {
    func setupConstraints() {
        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        containedView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }
    }
}
