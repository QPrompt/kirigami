/*
 *  SPDX-FileCopyrightText: 2018 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import org.kde.kirigami 2.20 as Kirigami
import "private" as P

/**
 * @brief This is the standard layout of a Card.
 *
 * It is recommended to use this class when the concept of Cards is needed
 * in the application.
 *
 * This Card has default items as header and footer. The header is an
 * image that can contain an optional title and icon, accessible via the
 * banner grouped property.
 *
 * The footer will show a series of toolbuttons (and eventual overflow menu)
 * representing the actions list accessible with the list property actions.
 * It is possible even tough is discouraged to override the footer:
 * in this case the actions property shouldn't be used.
 *
 * @inherit org::kde::kirigami::AbstractCard
 * @since 2.4
 */
Kirigami.AbstractCard {
    id: root

    /**
     * @brief This property holds the clickable actions that will be available in the footer
     * of the card.
     *
     * The actions will be represented by a list of ToolButtons with an optional overflow
     * menu, when not all of them will fit in the available Card width.
     *
     * @property list<org::kde::kirigami::Action> Card::actions
     */
    property list<QtObject> actions

    /**
     * @brief This grouped property controls the banner image present in the header.
     *
     * This grouped property has the following sub-properties:
     * * ``source: url``: The source for the image. It understands any URL valid for an Image component.
     * * ``titleIcon: string``: The optional icon to put in the banner, either a freedesktop-compatible
     * icon name (recommended) or any URL supported by QtQuick.Image.
     * * ``title: string``: The title for the banner, shown as contrasting text over the image.
     * * ``titleAlignment: Qt::Alignment``: The alignment of the title inside the image.
     * default: ``Qt.AlignTop | Qt.AlignLeft``
     * * ``titleLevel: int``: The Kirigami.Heading level for the title, which controls the font size.
     * default: ``1``, which is the largest size.
     * * ``titleWrapMode: QtQuick.Text::wrapMode``: Whether the header text should be able to wrap.
     * default: ``Text.NoWrap``
     *
     * It also has the full set of properties that QtQuick.Image has, such as sourceSize and fillMode.
     *
     * @see org::kde::kirigami::private::BannerImage
     * @property Image banner
     */
    readonly property alias banner: bannerImage


    header: P.BannerImage {
        id: bannerImage
        anchors.leftMargin: -root.leftPadding + root.background.border.width
        anchors.topMargin: -root.topPadding + root.background.border.width
        anchors.rightMargin: root.headerOrientation === Qt.Vertical ? -root.rightPadding + root.background.border.width : 0
        anchors.bottomMargin: root.headerOrientation === Qt.Horizontal ? -root.bottomPadding + root.background.border.width : 0
        //height: Layout.preferredHeight
        implicitWidth: root.headerOrientation === Qt.Horizontal ? sourceSize.width : Layout.preferredWidth
        Layout.preferredHeight: (source.toString().length > 0  ? width / (sourceSize.width / sourceSize.height) : Layout.minimumHeight) + anchors.topMargin + anchors.bottomMargin

        readonly property real widthWithBorder: width + root.background.border.width * 2
        readonly property real heightWithBorder: height + root.background.border.width * 2
        readonly property real radiusFromBackground: root.background.radius - root.background.border.width

        corners.topLeftRadius: radiusFromBackground
        corners.topRightRadius: (root.headerOrientation === Qt.Horizontal && widthWithBorder < root.width) ? 0 : radiusFromBackground
        corners.bottomLeftRadius: (root.headerOrientation !== Qt.Horizontal && heightWithBorder < root.height) ? 0 : radiusFromBackground
        corners.bottomRightRadius: heightWithBorder < root.height ? 0 : radiusFromBackground
    }

    onHeaderChanged: {
        if (!header) {
            return;
        }

        header.anchors.leftMargin = Qt.binding(() => -root.leftPadding);
        header.anchors.topMargin = Qt.binding(() =>  -root.topPadding);
        header.anchors.rightMargin = Qt.binding(() => root.headerOrientation === Qt.Vertical ? -root.rightPadding : 0);
        header.anchors.bottomMargin = Qt.binding(() => root.headerOrientation === Qt.Horizontal ? -root.bottomPadding : 0);
    }

    footer: Kirigami.ActionToolBar {
        id: actionsToolBar
        actions: root.actions
        position: QQC2.ToolBar.Footer
        visible: root.footer === actionsToolBar
    }
}
