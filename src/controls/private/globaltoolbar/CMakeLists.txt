
ecm_add_qml_module(KirigamiPrivateGlobalToolBarPlugin
    URI
        "org.kde.kirigami.private.globaltoolbar"
    NO_PLUGIN
    IMPORTS
        "QtQuick"
        "QtQuick.Controls"
        "QtQuick.Layouts"
        "Qt5Compat.GraphicalEffects"
)

ecm_target_qml_sources(KirigamiPrivateGlobalToolBarPlugin SOURCES
    "AbstractPageHeader.qml"
    "BreadcrumbControl.qml"
    "PageRowGlobalToolBarStyleGroup.qml"
    "PageRowGlobalToolBarUI.qml"
    "TitlesPageHeader.qml"
    "ToolBarPageFooter.qml"
    "ToolBarPageHeader.qml"
)

ecm_finalize_qml_module(KirigamiPrivateGlobalToolBarPlugin)
