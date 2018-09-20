//
//  ButtonSelectionCollection.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ButtonSelectionCollection
public class ButtonSelectionCollection: UIControl, SelectionCollection {

    public weak var delegate: SelectionCollectionDelegate?

    public var sectionType: SelectionMenu.SectionType

    public var elementStyle: SelectionElementStyling = NoStyle() {
        didSet { updateTheme() }
    }

    // Subviews
    /// Background view which can be used for corner radius to not not mess up shadows.
    public private(set) var backgroundView: UIView!

    /// Contained elements.
    public private(set) var elements: [SelectionElementView]

    // Private properties
    private var initiallyTouchedElement: SelectionElementView?

    /// Initializes SingleSelectionCollection
    ///
    /// - Parameter elements: Elements that should be contained in ButtonSelectionCollection.
    public required init(sectionType: SelectionMenu.SectionType, elements: [SelectionElementView]) {
        self.sectionType = sectionType
        self.elements = elements
        super.init(frame: .zero)

        initSubviews(with: elements)
        setupConstrains()
        updateTheme()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension ButtonSelectionCollection {
    public func expand(animated: Bool) {
        elements.forEach { $0.expand(animated: animated) }
    }

    public func collapse(animated: Bool) {
        elements.forEach { $0.collapse(animated: animated) }
    }
}

// MARK: - Stylable
extension ButtonSelectionCollection {
    public var foregroundColorStylable: UIColor? {
        get { return nil }
        set { return }
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

// MARK: - Tracking touches
extension ButtonSelectionCollection {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        updateHighlighted(to: touched?.offset)
        initiallyTouchedElement = touched?.element
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        if let touched = touched,
            let initiallyTouchedElement = initiallyTouchedElement,
            touched.element == initiallyTouchedElement {
            updateHighlighted(to: touched.offset)
        } else {
            updateHighlighted(to: nil)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let hitView = self.touchedElement(for: touches, with: event),
            let initiallyTouchedElement = initiallyTouchedElement,
            hitView.element == initiallyTouchedElement {
            delegate?.buttonSelectionCollection(self, didTapIndex: hitView.offset)
        }

        elements.forEach { elementStyle.apply(to: $0, in: sectionType, selected: false) }
        initiallyTouchedElement = nil
    }

    private func touchedElement(for touches: Set<UITouch>,
                        with event: UIEvent?) -> (offset: Int, element: SelectionElementView)? {
        guard let touch = touches.first else {
            return nil
        }

        let hitViews = elements.enumerated().filter { _, element -> Bool in
            let location = touch.location(in: element)
            return element.point(inside: location, with: event)
        }

        return hitViews.first
    }
}

// MARK: - Setup + Theme
private extension ButtonSelectionCollection {
    func initSubviews(with elements: [SelectionElementView]) {
        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        elements.forEach { element in
            addSubview(element)
        }
    }

    func updateHighlighted(to index: Int?) {
        let index = index ?? -1

        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, in: sectionType, selected: offset == index)
        }
    }

    func updateTheme() {
        updateHighlighted(to: nil)
    }

    func setupConstrains() {
        var leftEdge = snp.left
        elements.forEach { element in
            element.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(element.snp.height)
                make.left.equalTo(leftEdge)

                leftEdge = element.snp.right
            }
        }
        elements.last?.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }

        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


