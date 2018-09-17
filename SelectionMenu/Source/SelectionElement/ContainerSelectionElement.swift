//
//  ContainerSelectionElement.swift
//  FBSnapshotTestCase
//
//  Created by Michal Štembera on 17/09/2018.
//

import Foundation

/// Selection element view with UIImageView centered within it
typealias ImageSelectionElement = ContainerSelectionElement<UIImageView>

/// Selection element view with UILabel centered within it
typealias LabelSelectionElement = ContainerSelectionElement<UILabel>

class ContainerSelectionElement<ContainedView>: UIView, SelectionElement where ContainedView: UIView {
    /// View contained within background view nad centered within it.
    public weak var contentView: ContainedView!
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
        self.contentView = contentView

        setupConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SelectionElement
    public func expand() {
        transform = .identity
    }

    public func collapse() {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Setup
private extension ContainerSelectionElement {
    func setupConstraints() {
        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }

    }
}
