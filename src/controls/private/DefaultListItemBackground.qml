/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import org.kde.kirigami 2.12

Rectangle {
    id: background
    color: {
        if (listItem.alternatingBackground && index % 2)
            return listItem.alternateBackgroundColor
        else if (listItem.checked || listItem.highlighted || (listItem.hoverEnabled && listItem.pressed && !listItem.checked && !listItem.sectionDelegate))
            return listItem.activeBackgroundColor
        return listItem.backgroundColor
    }

    visible: listItem.ListView.view === null || listItem.ListView.view.highlight === null
    Rectangle {
        id: internal
        anchors.fill: parent
        visible: !Settings.tabletMode && listItem.hoverEnabled
        color: listItem.activeBackgroundColor
        opacity: {
            if ((listItem.highlighted || listItem.ListView.isCurrentItem) && !listItem.pressed) {
                return .6
            } else if (listItem.hovered && !listItem.pressed) {
                return .3
            } else {
                return 0
            }
        }
    }

    property var leadingWidth

    Separator {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: Units.largeSpacing
            rightMargin: Units.largeSpacing
        }
        visible: {
            // Whether there is visual feedback (do not show the separator)
            let visualFeedback = listItem.highlighted || listItem.pressed || listItem.checked || listItem.ListView.isCurrentItem

            // Show the separator when activeBackgroundColor is set to "transparent",
            // when the item is hovered. Check commit 344aec26.
            let bgTransparent = !listItem.hovered || listItem.activeBackgroundColor.a === 0

            // Whether the next item is a section delegate or is from another section (do not show the separator)
            let anotherSection = listItem.ListView.view === null || listItem.ListView.nextSection === listItem.ListView.section

            // Whether this item is the last item in the view (do not show the separator)
            let lastItem = listItem.ListView.view === null || listItem.ListView.count - 1 !== index

            return listItem.separatorVisible && !visualFeedback && bgTransparent
                && !listItem.sectionDelegate && anotherSection && lastItem
        }
        weight: Separator.Weight.Light
    }
}

