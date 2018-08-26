//
//  MultiSelectionCollection.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MultiSelectionCollection
class MultiSelectionCollection: UIControl, SelectionCollection {
    var elements: [SelectionElementView]!
    var backgroundView: UIView!
    var selectedIndexes: [Int] = []

    weak var delegate: SelectionCollectionDelegate?

    var collectionStyle: SelectionCollectionStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }
    var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    required init(elements: [SelectionElementView]) {
        super.init(frame: .zero)

        initSubviews(with: elements)
        setupConstrains()
        updateTheme()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MultiSelectionCollection {
    func initSubviews(with elements: [SelectionElementView]) {
        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        elements.forEach { element in
            addSubview(element)
        }
        self.elements = elements
    }

    func updateTheme() {
        collectionStyle.apply(to: self)

        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, selected: selectedIndexes.contains(offset))
        }
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

// MARK: - Expandable
extension MultiSelectionCollection {
    func expand() {
        elements.forEach { $0.expand() }
    }

    func collapse() {
        elements.forEach { $0.collapse() }
    }
}

// MARK: - External API
extension MultiSelectionCollection {
    func setSelected(indexes: [Int]) {
        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, selected: indexes.contains(offset))
        }

        self.selectedIndexes = indexes
    }
}

// MARK: - Tracking touches
extension MultiSelectionCollection {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let hitViews = elements.enumerated().filter { _, element -> Bool in
            let location = touch.location(in: element)
            return element.point(inside: location, with: event)
        }
        guard let hitView = hitViews.first else {
            return // Nothing was hit
        }

        if let index = selectedIndexes.index(of: hitView.offset) {
            elementStyle.apply(to: hitView.element, selected: false)
            selectedIndexes.remove(at: index)
        } else {
            elementStyle.apply(to: hitView.element, selected: true)
            selectedIndexes.append(hitView.offset)
        }

        let selectedElements = elements.enumerated()
            .filter { selectedIndexes.contains($0.offset) }
            .map { $1 }

        delegate?.multiSelectionCollection(self, changedSelectionTo: selectedElements, at: selectedIndexes)
    }
}
