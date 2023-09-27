
add_subdirectory(controls/private)
add_subdirectory(controls/templates)
add_subdirectory(delegates)
add_subdirectory(libkirigami)

if (WIN32)
    # Kirigami apparently adds too many sources so on Windows we end
    # up running into command line length limits. So disable cache
    # generation on Windows for now.
    set(_extra_options NO_CACHEGEN)
endif()

ecm_add_qml_module(KirigamiPlugin URI "org.kde.kirigami" VERSION 2.0
    CLASS_NAME KirigamiPlugin
    DEPENDENCIES
        "QtQuick"
    IMPORTS
        "QtQuick.Controls"
        "QtQuick.Layouts"
        "QtQuick.Templates"
        "Qt5Compat.GraphicalEffects"
        "org.kde.kirigami.delegates"
        "org.kde.kirigami.private"
        "org.kde.kirigami.private.globaltoolbar"
        "org.kde.kirigami.templates"
    ${_extra_options}
)

ecm_create_qm_loader(kirigami_QM_LOADER libkirigami6_qt)
target_sources(KirigamiPlugin PRIVATE ${kirigami_QM_LOADER})

target_include_directories(KirigamiPlugin PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/libkirigami
    ${CMAKE_CURRENT_BINARY_DIR}/libkirigami
)

target_sources(KirigamiPlugin PRIVATE
    colorutils.cpp
    colorutils.h
    columnview.cpp
    columnview.h
    columnview_p.h
    delegaterecycler.cpp
    delegaterecycler.h
    enums.cpp
    enums.h
    formlayoutattached.cpp
    formlayoutattached.h
    icon.cpp
    icon.h
    imagecolors.cpp
    imagecolors.h
    kirigamiplugin.cpp
    kirigamiplugin.h
    mnemonicattached.cpp
    mnemonicattached.h
    overlayzstackingattached.cpp
    overlayzstackingattached.h
    pagepool.cpp
    pagepool.h
    scenepositionattached.cpp
    scenepositionattached.h
    settings.cpp
    settings.h
    shadowedrectangle.cpp
    shadowedrectangle.h
    shadowedtexture.cpp
    shadowedtexture.h
    sizegroup.cpp
    sizegroup.h
    spellcheckattached.cpp
    spellcheckattached.h
    toolbarlayout.cpp
    toolbarlayoutdelegate.cpp
    toolbarlayoutdelegate.h
    toolbarlayout.h
    wheelhandler.cpp
    wheelhandler.h
    inputmethod.cpp

    scenegraph/managedtexturenode.cpp
    scenegraph/managedtexturenode.h
    scenegraph/paintedrectangleitem.cpp
    scenegraph/paintedrectangleitem.h
    ${CMAKE_CURRENT_BINARY_DIR}/libkirigami/loggingcategory.cpp
)
if (HAVE_QTGUI_OPENGL AND NOT KF6_PORTING_TODO)
    target_sources(KirigamiPlugin PRIVATE
        scenegraph/shadowedborderrectanglematerial.cpp
        scenegraph/shadowedborderrectanglematerial.h
        scenegraph/shadowedbordertexturematerial.cpp
        scenegraph/shadowedbordertexturematerial.h
        scenegraph/shadowedrectanglematerial.cpp
        scenegraph/shadowedrectanglematerial.h
        scenegraph/shadowedrectanglenode.cpp
        scenegraph/shadowedrectanglenode.h
        scenegraph/shadowedtexturematerial.cpp
        scenegraph/shadowedtexturematerial.h
        scenegraph/shadowedtexturenode.cpp
        scenegraph/shadowedtexturenode.h
    )
endif()

qt6_add_shaders(KirigamiPlugin "shaders6"
    BATCHABLE
    PRECOMPILE
    OPTIMIZED
    PREFIX "/org/kde/kirigami/shaders"
    FILES
        scenegraph/shaders6/shadowedrectangle.vert
        scenegraph/shaders6/shadowedrectangle.frag
        scenegraph/shaders6/shadowedrectangle_lowpower.frag
        scenegraph/shaders6/shadowedborderrectangle.frag
        scenegraph/shaders6/shadowedborderrectangle_lowpower.frag
        scenegraph/shaders6/shadowedtexture.frag
        scenegraph/shaders6/shadowedtexture_lowpower.frag
        scenegraph/shaders6/shadowedbordertexture.frag
        scenegraph/shaders6/shadowedbordertexture_lowpower.frag
    OUTPUTS
        shadowedrectangle.vert.qsb
        shadowedrectangle.frag.qsb
        shadowedrectangle_lowpower.frag.qsb
        shadowedborderrectangle.frag.qsb
        shadowedborderrectangle_lowpower.frag.qsb
        shadowedtexture.frag.qsb
        shadowedtexture_lowpower.frag.qsb
        shadowedbordertexture.frag.qsb
        shadowedbordertexture_lowpower.frag.qsb
)

ecm_target_qml_sources(KirigamiPlugin SOURCES
    controls/Action.qml
    controls/AbstractApplicationHeader.qml
    controls/AbstractApplicationWindow.qml
    controls/AbstractListItem.qml
    controls/ApplicationWindow.qml
    controls/BasicListItem.qml
    controls/OverlayDrawer.qml
    controls/ContextDrawer.qml
    controls/GlobalDrawer.qml
    controls/Heading.qml
    controls/Separator.qml
    controls/PageRow.qml
    controls/OverlaySheet.qml
    controls/Page.qml
    controls/ScrollablePage.qml
    controls/SwipeListItem.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.1 SOURCES
    controls/AbstractApplicationItem.qml
    controls/ApplicationItem.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.3 SOURCES
    controls/FormLayout.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.4 SOURCES
    controls/AbstractCard.qml
    controls/Card.qml
    controls/CardsListView.qml
    controls/CardsGridView.qml
    controls/CardsLayout.qml
    controls/InlineMessage.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.5 SOURCES
    controls/ListItemDragHandle.qml
    controls/ActionToolBar.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.6 SOURCES
    controls/AboutPage.qml
    controls/LinkButton.qml
    controls/UrlButton.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.7 SOURCES
    controls/ActionTextField.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.8 SOURCES
    controls/SearchField.qml
    controls/PasswordField.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.10 SOURCES
    controls/ListSectionHeader.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.11 SOURCES
    controls/PagePoolAction.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.12 SOURCES
    controls/ShadowedImage.qml
    controls/PlaceholderMessage.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.14 SOURCES
    controls/FlexColumn.qml
    controls/CheckableListItem.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.19 SOURCES
    controls/AboutItem.qml
    controls/NavigationTabBar.qml
    controls/NavigationTabButton.qml
    controls/Dialog.qml
    controls/MenuDialog.qml
    controls/PromptDialog.qml
    controls/Chip.qml
    controls/LoadingPlaceholder.qml
)

ecm_target_qml_sources(KirigamiPlugin VERSION 2.20 SOURCES
    controls/SelectableLabel.qml
    controls/InlineViewHeader.qml
)

qt_target_qml_sources(KirigamiPlugin RESOURCES
    styles/Material/InlineMessage.qml
    styles/Material/Theme.qml
)

if (DESKTOP_ENABLED)
    qt_target_qml_sources(KirigamiPlugin RESOURCES
        styles/org.kde.desktop/AbstractApplicationHeader.qml
        styles/org.kde.desktop/Theme.qml
    )
endif()

target_link_libraries(KirigamiPlugin
    PUBLIC Qt6::Core
    PRIVATE
    ${Kirigami_EXTRA_LIBS}
    Qt6::GuiPrivate
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Concurrent
    KF6Kirigami2
)

if (HAVE_OpenMP)
target_link_libraries(KirigamiPlugin PRIVATE OpenMP::OpenMP_CXX)
endif()

if (NOT BUILD_SHARED_LIBS)
    # Ensure we include any imported plugins into the main plugin when building
    # statically as otherwise the plugin will not be found when importing the
    # main plugin.
    target_link_libraries(KirigamiPlugin PRIVATE
        KirigamiDelegatesPlugin
        KirigamiPrivatePlugin
        KirigamiPrivateGlobalToolBarPlugin
        KirigamiTemplatesPlugin
        KirigamiTemplatesPrivatePlugin
    )
endif()

ecm_finalize_qml_module(KirigamiPlugin DESTINATION ${KDE_INSTALL_QMLDIR})

if (ANDROID)
    install(FILES KF6Kirigami2-android-dependencies.xml
        DESTINATION ${KDE_INSTALL_LIBDIR}
        RENAME KF6Kirigami2_${CMAKE_ANDROID_ARCH_ABI}-android-dependencies.xml
    )
endif()
