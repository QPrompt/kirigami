
ecm_add_qml_module(KirigamiDelegatesPlugin
    URI
        "org.kde.kirigami.delegates"
    NO_PLUGIN
    IMPORTS
        "QtQuick"
        "QtQuick.Controls"
        "QtQuick.Layouts"
        "QtQuick.Templates"
        "org.kde.kirigami.templates.private"
)

ecm_target_qml_sources(KirigamiDelegatesPlugin SOURCES
    "IconTitleSubtitle.qml"
    "TitleSubtitle.qml"

    "SubtitleDelegate.qml"
    "CheckSubtitleDelegate.qml"
    "RadioSubtitleDelegate.qml"
    "SwitchSubtitleDelegate.qml"
)

ecm_finalize_qml_module(KirigamiDelegatesPlugin)
