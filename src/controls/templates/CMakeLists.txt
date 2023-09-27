add_subdirectory(private)

ecm_add_qml_module(KirigamiTemplatesPlugin
    URI
        "org.kde.kirigami.templates"
    NO_PLUGIN
    IMPORTS
        "QtQuick"
        "QtQuick.Controls"
        "QtQuick.Layouts"
        "QtQuick.Templates"
        "org.kde.kirigami.templates.private"
)

set_source_files_properties(
    "AppHeaderSizeGroup.qml"

    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

ecm_target_qml_sources(KirigamiTemplatesPlugin SOURCES
    "AbstractApplicationHeader.qml"
    "AbstractCard.qml"
    "AppHeaderSizeGroup.qml"
    "Chip.qml"
    "InlineMessage.qml"
    "OverlayDrawer.qml"
    "OverlaySheet.qml"
)

ecm_finalize_qml_module(KirigamiTemplatesPlugin)
