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

        let labelButton = LabelMenuButton(text: "Menu")
        labelButton.backgroundColor = .red
        labelButton.label.textColor = .white

        let expandableMenu = SelectionMenu(menuButton: labelButton)
        view.addSubview(expandableMenu)
        self.menu = expandableMenu

        menuDataSource = StaticMenuDataSource(sections:
            (type: .singleSelection(selected: 0), [.text("A"), .text("B"), .text("C"), .text("D")]),
            (type: .singleSelection(selected: 1), [.text("1"), .text("2")])
        )

        menu.dataSource = menuDataSource   
        menu.delegate = self
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


