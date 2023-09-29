/*
 * SPDX-FileCopyrightText: 2010 Marco Martin <notmart@gmail.com>
 * SPDX-FileCopyrightText: 2022 ivan tkachenko <me@ratijas.tk>
 * SPDX-FileCopyrightText: 2023 Arjen Hiemstra <ahiemstra@heimr.nl>
 *
 * SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kirigami.templates.private as KTP

/**
 * A simple item containing an icon, title and subtitle.
 *
 * This is an extension of TitleSubtitle that adds an icon to the side.
 * It is intended as a contentItem for ItemDelegate and related controls.
 *
 * When using it as a contentItem, make sure to bind the appropriate properties
 * to those of the Control. Prefer binding to the Control's properties over
 * setting the properties directly, as the Control's properties may affect other
 * things like setting accessible names.
 *
 * This (and TitleSubtitle) can be combined with other controls in a layout to
 * create complex content items for controls.
 *
 * Example usage creating a CheckDelegate with an extra button on the side:
 *
 * ```qml
 * CheckDelegate {
 *     id: delegate
 *
 *     text: "Example"
 *     icon.name: "document-new"
 *
 *     contentItem: RowLayout {
 *         spacing: Kirigami.Theme.smallSpacing
 *
 *         Kirigami.IconTitleSubtitle {
 *             Layout.fillWidth: true
 *
 *             icon: icon.fromControlsIcon(delegate.icon)
 *             title: delegate.text
 *             selected: delegate.highlighted
 *             font: delegate.font
 *         }
 *
 *         Button {
 *             icon.name: "document-open"
 *             text: "Extra Action"
 *         }
 *     }
 * }
 * ```
 *
 * \sa Kirigami::Delegates::TitleSubtitle
 * \sa Kirigami::Delegates::ItemDelegate
 */
Item {
    id: root

    /**
     * @copydoc Kirigami::TitleSubtitle::title
     */
    required property string title
    /**
     * @copydoc Kirigami::TitleSubtitle::subtitle
     */
    property alias subtitle: titleSubtitle.subtitle
    /**
     * @copydoc Kirigami::TitleSubtitle::color
     */
    property alias color: titleSubtitle.color
    /**
     * @copydoc Kirigami::TitleSubtitle::subtitleColor
     */
    property alias subtitleColor: titleSubtitle.subtitleColor
    /**
     * @copydoc Kirigami::TitleSubtitle::font
     */
    property alias font: titleSubtitle.font
    /**
     * @copydoc Kirigami::TitleSubtitle::subtitleFont
     */
    property alias subtitleFont: titleSubtitle.subtitleFont
    /**
     * @copydoc Kirigami::TitleSubtitle::reserveSpaceForSubtitle
     */
    property alias reserveSpaceForSubtitle: titleSubtitle.reserveSpaceForSubtitle
    /**
     * @copydoc Kirigami::TitleSubtitle::selected
     */
    property alias selected: titleSubtitle.selected
    /**
     * @copydoc Kirigami::TitleSubtitle::showTooltip
     */
    property alias showTooltip: titleSubtitle.showTooltip
    /**
     * @copydoc Kirigami::TitleSubtitle::elide
     */
    property alias elide: titleSubtitle.elide

    /**
     * Grouped property for icon properties.
     *
     * \note By default, IconTitleSubtitle will reserve the space for the icon,
     * even if it is not set. To remove that space, set `icon.width` to 0.
     */
    property KTP.IconPropertiesGroup icon: KTP.IconPropertiesGroup {
        width: titleSubtitle.subtitleVisible ? Kirigami.Units.iconSizes.medium : Kirigami.Units.iconSizes.smallMedium
        height: width
    }

    implicitWidth: iconItem.implicitWidth + titleSubtitle.anchors.leftMargin + titleSubtitle.implicitWidth
    implicitHeight: Math.max(iconItem.implicitHeight, titleSubtitle.implicitHeight)

    Kirigami.Icon {
        id: iconItem

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        source: root.icon.name.length > 0 ? root.icon.name : root.icon.source
        implicitWidth: root.icon.width
        implicitHeight: root.icon.height
        selected: root.selected
        color: root.icon.color
    }

    TitleSubtitle {
        id: titleSubtitle

        anchors {
            left: iconItem.right
            leftMargin: root.icon.width > 0 ? Kirigami.Units.mediumSpacing : 0
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        title: root.title
    }
}
