
ecm_add_qml_module(KirigamiTemplatesPrivatePlugin
    URI
        "org.kde.kirigami.templates.private"
    NO_PLUGIN
    IMPORTS
        "QtQuick"
        "QtQuick.Controls"
        "QtQuick.Layouts"
        "QtQuick.Templates"
)

ecm_target_qml_sources(KirigamiTemplatesPrivatePlugin SOURCES
    "BackButton.qml"
    "BorderPropertiesGroup.qml"
    "ContextIcon.qml"
    "DrawerHandle.qml"
    "ForwardButton.qml"
    "GenericDrawerIcon.qml"
    "IconPropertiesGroup.qml"
    "MenuIcon.qml"
    "PassiveNotificationsManager.qml"
)

ecm_finalize_qml_module(KirigamiTemplatesPrivatePlugin)
