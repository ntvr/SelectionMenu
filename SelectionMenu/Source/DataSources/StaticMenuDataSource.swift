//
//  StaticDataSource.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Adoption of SelectionMenuDataSource which can be used to setup the SelectionMenu content.
public class StaticMenuDataSource {
    /// Allowed value types for StaticMenuDataSource
    public enum Value {
        /// Selection element represented with image value.
        case image(UIImage)

        /// Selection element represented with text value.
        case text(String)
    }

    /// Type which is used to store all content of the sections.
    public typealias ContentType<T> = [SectionType<T>]

    /// Type of a single section.
    public typealias SectionType<T> = (type: SelectionMenu.SectionType, values: [T])

    public var visualEffect: UIVisualEffect? = UIBlurEffect(style: .light)

    // MARK: - Private properties
    private let sections: ContentType<Value>

    /// Initialize the `StaticMenuDataSource` with given content.
    ///
    /// For example:
    /// ```
    /// let dataSource = StaticMenuDataSource(sections: [
    ///     (type: .singleSelection(selected: 0), [.text("A"), .text("B"), .text("C"), .text("D")]),
    ///     (type: .multiSelection(selected: [1, 3]), [.text("I"), .text("II"), .text("III")]),
    ///     (type: .buttonSelection, [.image(😀), .image(🙂), .image(😐), .image(🙁), .image(😞)])
    /// ])
    /// ```
    public init(sections: ContentType<Value>) {
        self.sections = sections
    }

    /// Initialize the `StaticMenuDataSource` with given content.
    ///
    /// For example:
    /// ```
    /// let dataSource = StaticMenuDataSource(sections:
    ///     (type: .singleSelection(selected: 0), [.text("A"), .text("B"), .text("C"), .text("D")]),
    ///     (type: .multiSelection(selected: [1, 3]), [.text("I"), .text("II"), .text("III")]),
    ///     (type: .buttonSelection, [.image(😀), .image(🙂), .image(😐), .image(🙁), .image(😞)])
    /// )
    /// ```
    ///
    /// - Important:
    /// Unicode characters are used in place of `#imageLiteral(resourceName: "image-name")`
    public convenience init(sections: SectionType<Value>...) {
        self.init(sections: sections)
    }

    /// Initialize the `StaticMenuDataSource` with given strings.
    ///
    /// For example:
    /// ```
    ///  StaticMenuDataSource(textSections:
    ///     (type: .singleSelection(selected: 0), values: ["A", "B", "C"]),
    ///     (type: .multiSelection(selected: [0, 1]), values: ["0", "1", "2"]),
    ///     (type: .buttonSelection, values: ["I", "II"])
    /// )
    /// ```
    public convenience init(textSections: SectionType<String>...) {
        let sections: ContentType<Value> = textSections.map { section in
            return (section.type, section.values.map { .text($0) })
        }

        self.init(sections: sections)
    }

    /// Initialize the `StaticMenuDataSource` with given images.
    ///
    /// For example:
    /// ```
    ///  StaticMenuDataSource(imageSections:
    ///     (type: .singleSelection(selected: 0), values: [😀, 😐, 😞]),
    ///     (type: .multiSelection(selected: [0, 1]), values: [🏎, 🚓]),
    ///     (type: .buttonSelection, values: [🥇, 🥈, 🥉])
    /// )
    /// ```
    ///
    /// - Important:
    /// Unicode characters are used in place of `#imageLiteral(resourceName: "image-name")`
    public convenience init(imageSections: SectionType<UIImage>...) {
        let sections: ContentType<Value> = imageSections.map { section in
            return (section.type, section.values.map { .image($0) })
        }

        self.init(sections: sections)
    }
}

// MARK: - SelectionMenuDataSource
extension StaticMenuDataSource: SelectionMenuDataSource {
    public func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType {
        return sections[section].type
    }

    public func selectionMenuNumberOfSections() -> Int {
        return sections.count
    }

    public func selectionMenu(numberOfElementsIn section: Int) -> Int {
        return sections[section].values.count
    }

    public func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView {
        switch sections[section].values[index] {
        case let .text(title):
            return LabelSelectionElement(text: title)
        case let .image(image):
            let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }
}
