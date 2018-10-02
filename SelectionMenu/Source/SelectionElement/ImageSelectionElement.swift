//
//  ImageSelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/09/2018.
//

import Foundation
import UIKit

/// Selection element view with UIImageView centered within it
public class ImageSelectionElement: UIView, SelectionElement {
    /// ImageView contained within background view and centered within it.
    public weak var imageView: UIImageView!

    /// Background having same size as the superview.
    public weak var backgroundView: UIView!

    /// Initializes ContainerSelectionElement
    ///
    /// - Parameter image: Initial image to be set for imageView
    /// - Parameter backgroundRatio: Ratio between backgroundView and element, has to be in between 0 and 1
    public init(image: UIImage? = nil, backgroundRatio: Double = 1.0) {
        assert(0...1 ~= backgroundRatio)

        super.init(frame: .zero)

        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        let imageView = UIImageView(image: image)
        backgroundView.addSubview(imageView)
        self.imageView = imageView

        setupConstraints(with: backgroundRatio)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension ImageSelectionElement {
    public func expand(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = .identity
    }

    public func collapse(animated: Bool, withDuration animationDuration: TimeInterval) {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Stylable
extension ImageSelectionElement {
    public var foregroundColorStylable: UIColor? {
        get { return imageView.tintColor }
        set { imageView.tintColor = newValue ?? imageView.tintColor }
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

private extension ImageSelectionElement {
    func setupConstraints(with backgroundRatio: Double) {
        backgroundView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(backgroundRatio)
        }

        imageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }
    }
}
