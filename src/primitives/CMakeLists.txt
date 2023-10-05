
add_library(KirigamiPrimitives)
ecm_add_qml_module(KirigamiPrimitives URI "org.kde.kirigami.primitives" VERSION 2.0 GENERATE_PLUGIN_SOURCE)

target_sources(KirigamiPrimitives PRIVATE
    icon.cpp
    icon.h
    shadowedrectangle.cpp
    shadowedrectangle.h
    shadowedtexture.cpp
    shadowedtexture.h

    scenegraph/managedtexturenode.cpp
    scenegraph/managedtexturenode.h
    scenegraph/paintedrectangleitem.cpp
    scenegraph/paintedrectangleitem.h
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

ecm_target_qml_sources(KirigamiPrimitives SOURCES
    ListItemDragHandle.qml
    Separator.qml
    ShadowedImage.qml
)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set(_extra_options DEBUGINFO)
else()
    set(_extra_options PRECOMPILE OPTIMIZED)
endif()

qt6_add_shaders(KirigamiPrimitives "shaders"
    BATCHABLE
    PREFIX "/qt/qml/org/kde/kirigami/primitives/shaders"
    FILES
        shaders/shadowedrectangle.vert
        shaders/shadowedrectangle.frag
        shaders/shadowedrectangle_lowpower.frag
        shaders/shadowedborderrectangle.frag
        shaders/shadowedborderrectangle_lowpower.frag
        shaders/shadowedtexture.frag
        shaders/shadowedtexture_lowpower.frag
        shaders/shadowedbordertexture.frag
        shaders/shadowedbordertexture_lowpower.frag
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
    ${_extra_options}
)

target_link_libraries(KirigamiPrimitives PRIVATE Qt6::Quick KF6Kirigami2)

install(TARGETS KirigamiPrimitives ${KDE_INSTALL_DEFAULT_ARGUMENTS})
ecm_finalize_qml_module(KirigamiPrimitives)
