//
//  ViewController.swift
//  SelectionMenu
//
//  Created by stemberamichal on 08/26/2018.
//  Copyright (c) 2018 stemberamichal. All rights reserved.
//

import UIKit
import SnapKit
import SelectionMenu

class ViewController: UIViewController {

    var menuDataSource: SelectionMenuDataSource?
    weak var menu: SelectionMenu!

    override func loadView() {
        super.loadView()

        let button = UIButton(type: .custom)
        button.setTitle("Menu", for: .normal)
        button.circularStylable = true
        button.foregroundColorStylable = .white
        button.backgroundColorStylable = .blue

        let expandableMenu = SelectionMenu(menuButton: button)
        view.addSubview(expandableMenu)
        self.menu = expandableMenu

        menuDataSource = StaticMenuDataSource(textSections:
            (type: .singleSelection(selected: 0), values: ["A", "B", "C"]),
            (type: .multiSelection(selected: [0, 1]), values: ["0", "1", "2"]),
            (type: .buttonSelection, values: ["I", "II"])
        )

        menu.dataSource = menuDataSource
        menu.collectionsLayout = ManualMenuLayout(verticalSpacing: 5,
                                                  menuButtonHeightRatio: 1.2,
                                                  horizontalAlignment: .leftToRight(spacing: 10),
                                                  verticalAlignment: .topToBottom(direction: .up))

        menu.elementStyle = SelectionElementStyle.blue
        menu.collectionStyle = SelectionCollectionStyle.blue
        menu.delegate = self

        setupConstraints()
    }

    func setupConstraints() {
        menu.snp.remakeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
            make.size.equalTo(66)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - SelectionMenuDelegate
extension ViewController: SelectionMenuDelegate {
    func selectionMenu(_ menu: SelectionMenu, willHide animated: Bool) { }

    func selectionMenu(_ menu: SelectionMenu, willShow animated: Bool) { }

    func selectionMenu(_ menu: SelectionMenu, didSelectSingleIndex index: Int, in section: Int) {
        print("Single selection at index: \(index) in section: \(section)")
    }

    func selectionMenu(_ menu: SelectionMenu, didSelectMultipleIndexes indexes: [Int], in section: Int) {
        print("Multi selection of indexes: \(indexes) in section: \(section)")
    }

    func selectionMenu(_ menu: SelectionMenu, didSelectButtonAt index: Int, in section: Int) {
        print("Button at index: \(index) in section: \(section)")
    }
}
