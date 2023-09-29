/*
 *  SPDX-FileCopyrightText: 2017 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQml
import QtQuick.Templates as T

import org.kde.kirigami as Kirigami
import org.kde.kirigami.templates as KT
import org.kde.kirigami.templates.private as KTP

/**
 * @brief An item that provides the features of AbstractApplicationWindow without the window itself.
 *
 * This allows embedding into a larger application.
 * Unless you need extra flexibility it is recommended to use ApplicationItem instead.
 *
 * Example usage:
 * @code
 * import org.kde.kirigami 2.4 as Kirigami
 *
 * Kirigami.AbstractApplicationItem {
 *  [...]
 *     globalDrawer: Kirigami.GlobalDrawer {
 *         actions: [
 *            Kirigami.Action {
 *                text: "View"
 *                icon.name: "view-list-icons"
 *                Kirigami.Action {
 *                        text: "action 1"
 *                }
 *                Kirigami.Action {
 *                        text: "action 2"
 *                }
 *                Kirigami.Action {
 *                        text: "action 3"
 *                }
 *            },
 *            Kirigami.Action {
 *                text: "Sync"
 *                icon.name: "folder-sync"
 *            }
 *         ]
 *     }
 *
 *     contextDrawer: Kirigami.ContextDrawer {
 *         id: contextDrawer
 *     }
 *
 *     pageStack: Kirigami.PageRow {
 *         ...
 *     }
 *  [...]
 * }
 * @endcode
 *
 * @inherit QtQuick.Item
 */
Item {
    id: root

//BEGIN properties
    /**
     * @brief This property holds the stack used to allocate the pages and to manage the
     * transitions between them.
     *
     * Put a container here, such as QtQuick.Controls.StackView.
     */
    property Item pageStack

    /**
     * @brief This property exists for compatibility with Applicationwindow.
     *
     * default: ``Window.activeFocusItem``
     */
    readonly property Item activeFocusItem: Window.activeFocusItem

    /**
     * @brief This property holds the font for this item.
     *
     * default: ``Kirigami.Theme.defaultFont``
     */
    property font font: Kirigami.Theme.defaultFont

    /**
     * @brief This property holds the locale for this item.
     */
    property Locale locale

    /**
     * @brief This property holds an item that can be used as a menuBar for the application.
     */
    property T.MenuBar menuBar

    /**
    * @brief This property holds an item that can be used as a title for the application.
    *
    * Scrolling the main page will make it taller or shorter (through the point of going away).
    *
    * It's a behavior similar to the typical mobile web browser addressbar.
    *
    * The minimum, preferred and maximum heights of the item can be controlled with
    *
    * * ``Layout.minimumHeight``: default is 0, i.e. hidden
    * * ``Layout.preferredHeight``: default is Kirigami.Units.gridUnit * 1.6
    * * ``Layout.maximumHeight``: default is Kirigami.Units.gridUnit * 3
    *
    * To achieve a titlebar that stays completely fixed, just set the 3 sizes as the same.
    *
    * @property kirigami::templates::AbstractApplicationHeader header
    */
    property KT.AbstractApplicationHeader header

    /**
     * @brief This property holds an item that can be used as a footer for the application.
     */
    property Item footer

    /**
     * @brief This property sets whether the standard chrome of the app is visible.
     *
     * These are the action button, the drawer handles and the application header.
     *
     * default: ``true``
     */
    property bool controlsVisible: true

    /**
     * @brief This property holds the drawer for global actions.
     *
     * Thos drawer can be opened by sliding from the left screen edge
     * or by dragging the ActionButton to the right.
     *
     * @note It is recommended to use the GlobalDrawer here.
     * @property org::kde::kirigami::OverlayDrawer globalDrawer
     */
    property OverlayDrawer globalDrawer

    /**
     * @brief This property tells us whether the application is in "widescreen" mode.
     *
     * This is enabled on desktops or horizontal tablets.
     *
     * @note Different styles can have their own logic for deciding this.
     */
    property bool wideScreen: width >= Kirigami.Units.gridUnit * 60

    /**
     * @brief This property holds the drawer for context-dependent actions.
     *
     * The drawer that will be opened by sliding from the right screen edge
     * or by dragging the ActionButton to the left.
     *
     * @note It is recommended to use the ContextDrawer class here.
     *
     * The contents of the context drawer should depend from what page is
     * loaded in the main pageStack
     *
     * Example usage:
     * @code
     * import org.kde.kirigami 2.4 as Kirigami
     *
     * Kirigami.ApplicationItem {
     *  [...]
     *     contextDrawer: Kirigami.ContextDrawer {
     *         id: contextDrawer
     *     }
     *  [...]
     * }
     * @endcode
     *
     * @code
     * import org.kde.kirigami 2.4 as Kirigami
     *
     * Kirigami.Page {
     *   [...]
     *     contextualActions: [
     *         Kirigami.Action {
     *             icon.name: "edit"
     *             text: "Action text"
     *             onTriggered: {
     *                 // do stuff
     *             }
     *         },
     *         Kirigami.Action {
     *             icon.name: "edit"
     *             text: "Action text"
     *             onTriggered: {
     *                 // do stuff
     *             }
     *         }
     *     ]
     *   [...]
     * }
     * @endcode
     *
     * When this page will be the current one, the context drawer will visualize
     * contextualActions defined as property in that page.
     *
     * @property org::kde::kirigami::ContextDrawer contextDrawer
     */
    property OverlayDrawer contextDrawer

    /**
     * @brief This property holds the list of all children of this item.
     * @internal
     * @property list<Object> __data
     */
    default property alias __data: contentItemRoot.data

    /**
     * @brief This property holds the Item of the main part of the Application UI.
     */
    readonly property Item contentItem: Item {
        id: contentItemRoot
        parent: root
        anchors {
            fill: parent
            topMargin: controlsVisible ? (root.header ? root.header.height : 0) + (root.menuBar ? root.menuBar.height : 0) : 0
            bottomMargin: controlsVisible && root.footer ? root.footer.height : 0
            leftMargin: root.globalDrawer && root.globalDrawer.modal === false ? root.globalDrawer.contentItem.width * root.globalDrawer.position : 0
            rightMargin: root.contextDrawer && root.contextDrawer.modal === false ? root.contextDrawer.contentItem.width * root.contextDrawer.position : 0
        }
    }

    /**
     * @brief This property holds the color for the background.
     *
     * default: ``Kirigami.Theme.backgroundColor``
     */
    property color color: Kirigami.Theme.backgroundColor

    /**
     * @brief This property holds the background of the Application UI.
     */
    property Item background

    property alias overlay: overlayRoot
//END properties

//BEGIN functions
    /**
     * @brief This function shows a little passive notification at the bottom of the app window
     * lasting for few seconds, with an optional action button.
     *
     * @param message The text message to be shown to the user.
     * @param timeout How long to show the message:
     *            possible values: "short", "long" or the number of milliseconds
     * @param actionText Text in the action button, if any.
     * @param callBack A JavaScript function that will be executed when the
     *            user clicks the button.
     */
    function showPassiveNotification(message, timeout, actionText, callBack) {
        notificationsObject.showNotification(message, timeout, actionText, callBack);
    }

    /**
     * @brief This function hides the passive notification at specified index, if any is shown.
     * @param index Index of the notification to hide. Default is 0 (oldest notification).
    */
    function hidePassiveNotification(index = 0) {
        notificationsObject.hideNotification(index);
    }

    /**
     * @brief This property gets application windows object anywhere in the application.
     * @returns a pointer to this item.
     */
    function applicationWindow() {
        return root;
    }
//END functions

//BEGIN signals handlers
    onMenuBarChanged: {
        menuBar.parent = root.contentItem
        if (menuBar.z === undefined) {
            menuBar.z = 1;
        }
        if (menuBar instanceof T.ToolBar) {
            menuBar.position = T.ToolBar.Footer
        } else if (menuBar instanceof T.DialogButtonBox) {
            menuBar.position = T.DialogButtonBox.Footer
        }
        menuBar.width = Qt.binding(() => root.contentItem.width)
        // FIXME: (root.header.height ?? 0) when we can depend from 5.15
        menuBar.y = Qt.binding(() => -menuBar.height - (root.header.height ? root.header.height : 0))
    }

    onHeaderChanged: {
        header.parent = root.contentItem
        if (header.z === undefined) {
            header.z = 1;
        }
        if (header instanceof T.ToolBar) {
            header.position = T.ToolBar.Header
        } else if (header instanceof T.DialogButtonBox) {
            header.position = T.DialogButtonBox.Header
        }
        header.width = Qt.binding(() => root.contentItem.width)
        header.y = Qt.binding(() => -header.height)
    }

    onFooterChanged: {
        footer.parent = root.contentItem
        if (footer.z === undefined) {
            footer.z = 1;
        }
        if (footer instanceof T.ToolBar) {
            footer.position = T.ToolBar.Footer
        } else if (footer instanceof T.DialogButtonBox) {
            footer.position = T.DialogButtonBox.Footer
        }
        footer.width = Qt.binding(() => root.contentItem.width)
        footer.y = Qt.binding(() => root.contentItem.height)
    }

    onBackgroundChanged: {
        background.parent = root.contentItem
        if (background.z === undefined) {
            background.z = -1;
        }
        background.anchors.fill = background.parent
    }

    onPageStackChanged: pageStack.parent = root.contentItem;
//END signals handlers

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    KTP.PassiveNotificationsManager {
        id: notificationsObject
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        z: 1
    }

    Item {
        anchors.fill: parent
        parent: root.parent || root
        z: 999999
        Rectangle {
            z: -1
            anchors.fill: parent
            color: "black"
            visible: contextDrawer && contextDrawer.modal
            parent: contextDrawer ? contextDrawer.background.parent.parent : overlayRoot
            opacity: contextDrawer ? contextDrawer.position * 0.6 : 0
        }
        Rectangle {
            z: -1
            anchors.fill: parent
            color: "black"
            visible: globalDrawer && globalDrawer.modal
            parent: globalDrawer ? globalDrawer.background.parent.parent : overlayRoot
            opacity: globalDrawer ? globalDrawer.position * 0.6 : 0
        }
        Item {
            id: overlayRoot
            z: -1
            anchors.fill: parent
        }
        Window.onWindowChanged: {
            if (globalDrawer) {
                globalDrawer.visible = globalDrawer.drawerOpen;
            }
            if (contextDrawer) {
                contextDrawer.visible = contextDrawer.drawerOpen;
            }
        }
    }

    Binding {
        when: globalDrawer !== undefined && root.visible
        target: globalDrawer
        property: "parent"
        value: overlay
        restoreMode: Binding.RestoreBinding
    }
    Binding {
        when: contextDrawer !== undefined && root.visible
        target: contextDrawer
        property: "parent"
        value: overlay
        restoreMode: Binding.RestoreBinding
    }

    implicitWidth: Kirigami.Settings.isMobile ? Kirigami.Units.gridUnit * 30 : Kirigami.Units.gridUnit * 55
    implicitHeight: Kirigami.Settings.isMobile ? Kirigami.Units.gridUnit * 45 : Kirigami.Units.gridUnit * 40
    visible: true
}
