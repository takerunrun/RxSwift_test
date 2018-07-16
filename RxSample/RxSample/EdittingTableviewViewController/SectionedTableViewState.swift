//
//  SectionedTableViewState.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionedTableViewState {
    var sections: [NumberSection]
    
    init(sections: [NumberSection]) {
        self.sections = sections
    }
    
    func executeCommand(command: TableViewEdittingCommand) -> SectionedTableViewState {
        switch command {
        case .AppendItem(let appendEvent):
            var sections = self.sections
            let items = sections[appendEvent.section].items + appendEvent.item
            sections[appendEvent.section] = NumberSection(original: sections[appendEvent.section], items: items)
            return SectionedTableViewState(sections: sections)
        case .AppendItems(let appendEvent):
            var sections = self.sections
            let items = sections[appendEvent.section].items + appendEvent.items
            sections[appendEvent.section] = NumberSection(original: sections[appendEvent.section], items: items)
            return SectionedTableViewState(sections: sections)
        case .DeleteItem(let indexPath):
            var sections = self.sections
            var items = sections[indexPath.section].items
            items.remove(at: indexPath.row)
            sections[indexPath.section] = NumberSection(original: sections[indexPath.section], items: items)
            return SectionedTableViewState(sections: sections)
        }
    }
}

enum TableViewEdittingCommand {
    case AppendItem(item: App, section: Int)
    case AppendItems(items: [App], section: Int)
    case DeleteItem(NSIndexPath)
}

func + <T>(lhs: [T], rhs: T) -> [T] {
    var copy = lhs
    copy.append(rhs)
    return copy
}
