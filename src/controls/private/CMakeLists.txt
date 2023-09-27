add_subdirectory(globaltoolbar)

ecm_add_qml_module(KirigamiPrivatePlugin
    URI
        "org.kde.kirigami.private"
    NO_PLUGIN
    IMPORTS
        "QtQuick"
        "QtQuick.Controls"
        "QtQuick.Controls.impl"
        "QtQuick.Layouts"
        "QtQuick.Templates"
        "Qt5Compat.GraphicalEffects"
)

ecm_target_qml_sources(KirigamiPrivatePlugin SOURCES
    "ActionIconGroup.qml"
    "ActionMenuItem.qml"
    "ActionsMenu.qml"
    "BannerImage.qml"
    "CardsGridViewPrivate.qml"
    "ContextDrawerActionItem.qml"
    "CornerShadow.qml"
    "DefaultCardBackground.qml"
    "DefaultChipBackground.qml"
    "DefaultPageTitleDelegate.qml"
    "EdgeShadow.qml"
    "GlobalDrawerActionItem.qml"
    "MobileDialogLayer.qml"
    "PrivateActionToolButton.qml"
    "SwipeItemEventFilter.qml"
)

ecm_finalize_qml_module(KirigamiPrivatePlugin)
