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
    // Public properties
    public weak var delegate: SelectionCollectionDelegate?
    public var collectionStyle: SelectionCollectionStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }
    public var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    // Subviews
    public private(set) var backgroundView: UIView!
    public private(set) var elements: [SelectionElementView]

    // Private properties
    private var initiallyTouchedElement: SelectionElementView?

    public required init(elements: [SelectionElementView]) {
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
    public func expand() {
        elements.forEach { $0.expand() }
    }

    public func collapse() {
        elements.forEach { $0.collapse() }
    }
}

// MARK: - Tracking touches
extension ButtonSelectionCollection {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        updatedHighlighted(to: touched?.offset)
        initiallyTouchedElement = touched?.element
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        if let touched = touched,
            let initiallyTouchedElement = initiallyTouchedElement,
            touched.element == initiallyTouchedElement {
            updatedHighlighted(to: touched.offset)
        } else {
            updatedHighlighted(to: nil)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let hitView = self.touchedElement(for: touches, with: event),
            let initiallyTouchedElement = initiallyTouchedElement,
            hitView.element == initiallyTouchedElement {
            delegate?.buttonSelectionCollection(self, didTapIndex: hitView.offset)
        }

        elements.forEach { elementStyle.apply(to: $0, selected: false) }
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

    func updatedHighlighted(to index: Int?) {
        let index = index ?? -1

        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, selected: offset == index)
        }
    }

    func updateTheme() {
        collectionStyle.apply(to: self)

        updatedHighlighted(to: nil)
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

