/*
 *  SPDX-FileCopyrightText: 2019 Björn Feber <bfeber@protonmail.com>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

/**
 * @brief A section delegate for the primitive ListView component.
 *
 * It's intended to make all listviews look coherent.
 *
 * Example usage:
 *
 * @code
 * import QtQuick
 * import QtQuick.Controls as QQC2
 * import org.kde.kirigami as Kirigami
 *
 * ListView {
 *     section.delegate: Kirigami.ListSectionHeader {
 *         label: section
 *
 *         QQC2.Button {
 *             text: "Button 1"
 *         }
 *         QQC2.Button {
 *             text: "Button 2"
 *         }
 *     }
 * }
 * @endcode
 */
QQC2.ItemDelegate {
    id: listSection

    /**
     * @brief This property sets the text of the ListView's section header.
     * @property string label
     */
    property alias label: listSection.text

    default property alias _contents: rowLayout.data

    hoverEnabled: false

    activeFocusOnTab: false

    // we do not need a background
    background: Item {}

    topPadding: Kirigami.Units.largeSpacing + Kirigami.Units.smallSpacing

    contentItem: RowLayout {
        id: rowLayout
        spacing: Kirigami.Units.largeSpacing

        Kirigami.Heading {
            Layout.fillWidth: rowLayout.children.length === 1
            Layout.alignment: Qt.AlignVCenter

            opacity: 0.7
            level: 5
            type: Kirigami.Heading.Primary
            text: listSection.text
            elide: Text.ElideRight

            // we override the Primary type's font weight (DemiBold) for Bold for contrast with small text
            font.weight: Font.Bold
        }

        Kirigami.Separator {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
