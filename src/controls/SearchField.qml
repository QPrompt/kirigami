/*
 *  SPDX-FileCopyrightText: 2019 Carl-Lucien Schwan <carl@carlschwan.eu>
 *  SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.15
import org.kde.kirigami 2.20 as Kirigami

/**
 * @brief This is a standard QtQuick.Controls.TextField following the KDE HIG,
 * which, by default, uses Ctrl+F as the focus keyboard shortcut
 * and "Search…" as a placeholder text.
 *
 * Example usage:
 * @code{.qml}
 * import org.kde.kirigami 2.20 as Kirigami
 *
 * Kirigami.SearchField {
 *     id: searchField
 *     onAccepted: console.log("Search text is " + searchField.text)
 * }
 * @endcode
 * @inherit kirigami::ActionTextField
 */
Kirigami.ActionTextField {
    id: root
    /**
     * @brief This property sets whether the accepted signal is fired automatically
     * when the text is changed.
     *
     * Setting this to @c false will require that the user presses return or enter
     * (similarly to QtQuick.TextInput).
     *
     * default: ``true``
     *
     * @since KDE Frameworks 5.81
     * @since org.kde.kirigami 2.16
     */
    property bool autoAccept: true

    /**
     * @brief This property sets whether to delay automatic acceptance of the search input.
     *
     * Set this to @c true if your search is expensive (such as for online
     * operations or in exceptionally slow data sets) and want to delay it
     * for 2.5 seconds.
     *
     * @note If you must have immediate feedback (filter-style), use the
     * text property directly instead of accepted()
     *
     * default: ``false``
     *
     * @since KDE Frameworks 5.81
     * @since org.kde.kirigami 2.16
     */
    property bool delaySearch: false

    // padding to accommodate search icon nicely
    leftPadding: if (effectiveHorizontalAlignment === TextInput.AlignRight) {
        return _rightActionsRow.width + Kirigami.Units.smallSpacing
    } else {
        return (activeFocus || root.text.length > 0 ? 0 : (searchIcon.width + Kirigami.Units.smallSpacing)) + Kirigami.Units.smallSpacing * 2
    }
    rightPadding: if (effectiveHorizontalAlignment === TextInput.AlignRight) {
        return (activeFocus || root.text.length > 0 ? 0 : (searchIcon.width + Kirigami.Units.smallSpacing)) + Kirigami.Units.smallSpacing * 2
    } else {
        return _rightActionsRow.width + Kirigami.Units.smallSpacing
    }

    Kirigami.Icon {
        id: searchIcon
        opacity: root.activeFocus || text.length > 0 ? 0 : 1
        LayoutMirroring.enabled: root.effectiveHorizontalAlignment === TextInput.AlignRight
        anchors.left: root.left
        anchors.leftMargin: Kirigami.Units.smallSpacing * 2
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: Math.round((root.topPadding - root.bottomPadding) / 2)
        implicitHeight: Kirigami.Units.iconSizes.sizeForLabels
        implicitWidth: Kirigami.Units.iconSizes.sizeForLabels
        color: root.placeholderTextColor

        source: "search"

        Behavior on opacity {
            NumberAnimation {
                duration: Kirigami.Units.longDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    placeholderText: qsTr("Search…")

    Accessible.name: qsTr("Search")
    Accessible.searchEdit: true

    focusSequence: StandardKey.Find
    inputMethodHints: Qt.ImhNoPredictiveText
    EnterKey.type: Qt.EnterKeySearch
    rightActions: [
        Kirigami.Action {
            //ltr confusingly refers to the direction of the arrow in the icon, not the text direction which it should be used in
            icon.name: root.effectiveHorizontalAlignment === TextInput.AlignRight ? "edit-clear-locationbar-ltr" : "edit-clear-locationbar-rtl"
            visible: root.text.length > 0
            text: qsTr("Clear search")
            onTriggered: {
                root.clear();
                // Since we are always sending the accepted signal here (whether or not the user has requested
                // that the accepted signal be delayed), stop the delay timer that gets started by the text changing
                // above, so that we don't end up sending two of those in rapid succession.
                fireSearchDelay.stop();
                root.accepted();
            }
        }
    ]

    Timer {
        id: fireSearchDelay
        interval: root.delaySearch ? Kirigami.Units.humanMoment : Kirigami.Units.shortDuration
        running: false; repeat: false;
        onTriggered: {
            if (root.acceptableInput) {
                root.accepted();
            }
        }
    }
    onAccepted: {
        fireSearchDelay.running = false
    }
    onTextChanged: {
        if (root.autoAccept) {
            fireSearchDelay.restart();
        } else {
            fireSearchDelay.stop();
        }
    }
}
