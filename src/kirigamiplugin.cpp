/*
 *  SPDX-FileCopyrightText: 2009 Alan Alpert <alan.alpert@nokia.com>
 *  SPDX-FileCopyrightText: 2010 Ménard Alexis <menard@kde.org>
 *  SPDX-FileCopyrightText: 2010 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

#include "kirigamiplugin.h"

#include <QIcon>
#if defined(Q_OS_ANDROID)
#include <QResource>
#endif
#include <QQmlContext>
#include <QQuickItem>
#include <QQuickStyle>

#include "platform/styleselector.h"

#ifdef KIRIGAMI_BUILD_TYPE_STATIC
#include "loggingcategory.h"
#include <QDebug>
#endif

// we can't do this in the plugin object directly, as that can live in a different thread
// and event filters are only allowed in the same thread as the filtered object
class LanguageChangeEventFilter : public QObject
{
    Q_OBJECT
public:
    bool eventFilter(QObject *receiver, QEvent *event) override
    {
        if (event->type() == QEvent::LanguageChange && receiver == QCoreApplication::instance()) {
            Q_EMIT languageChangeEvent();
        }
        return QObject::eventFilter(receiver, event);
    }

Q_SIGNALS:
    void languageChangeEvent();
};

KirigamiPlugin::KirigamiPlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
    auto filter = new LanguageChangeEventFilter;
    filter->moveToThread(QCoreApplication::instance()->thread());
    QCoreApplication::instance()->installEventFilter(filter);
    connect(filter, &LanguageChangeEventFilter::languageChangeEvent, this, &KirigamiPlugin::languageChangeEvent);
}

QUrl KirigamiPlugin::componentUrl(const QString &fileName) const
{
    return Kirigami::Platform::StyleSelector::componentUrl(fileName);
}

void KirigamiPlugin::registerTypes(const char *uri)
{
#if defined(Q_OS_ANDROID)
    QResource::registerResource(QStringLiteral("assets:/android_rcc_bundle.rcc"));
#endif

    Q_ASSERT(QLatin1String(uri) == QLatin1String("org.kde.kirigami"));

    Kirigami::Platform::StyleSelector::setBaseUrl(baseUrl());

    if (QIcon::themeName().isEmpty() && !qEnvironmentVariableIsSet("XDG_CURRENT_DESKTOP")) {
#if defined(Q_OS_ANDROID)
        QIcon::setThemeSearchPaths({QStringLiteral("assets:/qml/org/kde/kirigami"), QStringLiteral(":/icons")});
#else
        QIcon::setThemeSearchPaths({Kirigami::Platform::StyleSelector::resolveFilePath(QStringLiteral(".")), QStringLiteral(":/icons")});
#endif
        QIcon::setThemeName(QStringLiteral("breeze-internal"));
    } else {
        QIcon::setFallbackSearchPaths(QIcon::fallbackSearchPaths() << Kirigami::Platform::StyleSelector::resolveFilePath(QStringLiteral("icons")));
    }

    qmlRegisterType(componentUrl(QStringLiteral("Action.qml")), uri, 2, 0, "Action");
    qmlRegisterType(componentUrl(QStringLiteral("AbstractApplicationHeader.qml")), uri, 2, 0, "AbstractApplicationHeader");
    qmlRegisterType(componentUrl(QStringLiteral("AbstractApplicationWindow.qml")), uri, 2, 0, "AbstractApplicationWindow");
    qmlRegisterType(componentUrl(QStringLiteral("ApplicationWindow.qml")), uri, 2, 0, "ApplicationWindow");
    qmlRegisterType(componentUrl(QStringLiteral("OverlayDrawer.qml")), uri, 2, 0, "OverlayDrawer");
    qmlRegisterType(componentUrl(QStringLiteral("ContextDrawer.qml")), uri, 2, 0, "ContextDrawer");
    qmlRegisterType(componentUrl(QStringLiteral("GlobalDrawer.qml")), uri, 2, 0, "GlobalDrawer");
    qmlRegisterType(componentUrl(QStringLiteral("Heading.qml")), uri, 2, 0, "Heading");
    qmlRegisterType(componentUrl(QStringLiteral("Separator.qml")), uri, 2, 0, "Separator");
    qmlRegisterType(componentUrl(QStringLiteral("PageRow.qml")), uri, 2, 0, "PageRow");

    qmlRegisterType(componentUrl(QStringLiteral("OverlaySheet.qml")), uri, 2, 0, "OverlaySheet");
    qmlRegisterType(componentUrl(QStringLiteral("Page.qml")), uri, 2, 0, "Page");
    qmlRegisterType(componentUrl(QStringLiteral("ScrollablePage.qml")), uri, 2, 0, "ScrollablePage");
    qmlRegisterType(componentUrl(QStringLiteral("SwipeListItem.qml")), uri, 2, 0, "SwipeListItem");

    // 2.1
    qmlRegisterType(componentUrl(QStringLiteral("AbstractApplicationItem.qml")), uri, 2, 1, "AbstractApplicationItem");
    qmlRegisterType(componentUrl(QStringLiteral("ApplicationItem.qml")), uri, 2, 1, "ApplicationItem");

    // 2.3
    qmlRegisterType(componentUrl(QStringLiteral("FormLayout.qml")), uri, 2, 3, "FormLayout");

    // 2.4
    qmlRegisterType(componentUrl(QStringLiteral("AbstractCard.qml")), uri, 2, 4, "AbstractCard");
    qmlRegisterType(componentUrl(QStringLiteral("Card.qml")), uri, 2, 4, "Card");
    qmlRegisterType(componentUrl(QStringLiteral("CardsListView.qml")), uri, 2, 4, "CardsListView");
    qmlRegisterType(componentUrl(QStringLiteral("CardsGridView.qml")), uri, 2, 4, "CardsGridView");
    qmlRegisterType(componentUrl(QStringLiteral("CardsLayout.qml")), uri, 2, 4, "CardsLayout");
    qmlRegisterType(componentUrl(QStringLiteral("InlineMessage.qml")), uri, 2, 4, "InlineMessage");

    // 2.5
    qmlRegisterType(componentUrl(QStringLiteral("ListItemDragHandle.qml")), uri, 2, 5, "ListItemDragHandle");
    qmlRegisterType(componentUrl(QStringLiteral("ActionToolBar.qml")), uri, 2, 5, "ActionToolBar");

    // 2.6
    qmlRegisterType(componentUrl(QStringLiteral("AboutPage.qml")), uri, 2, 6, "AboutPage");
    qmlRegisterType(componentUrl(QStringLiteral("LinkButton.qml")), uri, 2, 6, "LinkButton");
    qmlRegisterType(componentUrl(QStringLiteral("UrlButton.qml")), uri, 2, 6, "UrlButton");

    // 2.7
    qmlRegisterType(componentUrl(QStringLiteral("ActionTextField.qml")), uri, 2, 7, "ActionTextField");

    // 2.8
    qmlRegisterType(componentUrl(QStringLiteral("SearchField.qml")), uri, 2, 8, "SearchField");
    qmlRegisterType(componentUrl(QStringLiteral("PasswordField.qml")), uri, 2, 8, "PasswordField");

    // 2.10
    qmlRegisterType(componentUrl(QStringLiteral("ListSectionHeader.qml")), uri, 2, 10, "ListSectionHeader");

    // 2.11
    qmlRegisterType(componentUrl(QStringLiteral("PagePoolAction.qml")), uri, 2, 11, "PagePoolAction");

    // 2.12
    qmlRegisterType(componentUrl(QStringLiteral("ShadowedImage.qml")), uri, 2, 12, "ShadowedImage");
    qmlRegisterType(componentUrl(QStringLiteral("PlaceholderMessage.qml")), uri, 2, 12, "PlaceholderMessage");

    // 2.14
    qmlRegisterType(componentUrl(QStringLiteral("FlexColumn.qml")), uri, 2, 14, "FlexColumn");
    qmlRegisterType(componentUrl(QStringLiteral("CheckableListItem.qml")), uri, 2, 14, "CheckableListItem");

    // 2.19
    qmlRegisterType(componentUrl(QStringLiteral("AboutItem.qml")), uri, 2, 19, "AboutItem");
    qmlRegisterType(componentUrl(QStringLiteral("NavigationTabBar.qml")), uri, 2, 19, "NavigationTabBar");
    qmlRegisterType(componentUrl(QStringLiteral("NavigationTabButton.qml")), uri, 2, 19, "NavigationTabButton");
    qmlRegisterType(componentUrl(QStringLiteral("Dialog.qml")), uri, 2, 19, "Dialog");
    qmlRegisterType(componentUrl(QStringLiteral("MenuDialog.qml")), uri, 2, 19, "MenuDialog");
    qmlRegisterType(componentUrl(QStringLiteral("PromptDialog.qml")), uri, 2, 19, "PromptDialog");
    qmlRegisterType(componentUrl(QStringLiteral("Chip.qml")), uri, 2, 19, "Chip");
    qmlRegisterType(componentUrl(QStringLiteral("LoadingPlaceholder.qml")), uri, 2, 19, "LoadingPlaceholder");

    // 2.20
    qmlRegisterType(componentUrl(QStringLiteral("SelectableLabel.qml")), uri, 2, 20, "SelectableLabel");
    qmlRegisterType(componentUrl(QStringLiteral("InlineViewHeader.qml")), uri, 2, 20, "InlineViewHeader");
}

void KirigamiPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(uri);
    connect(this, &KirigamiPlugin::languageChangeEvent, engine, &QQmlEngine::retranslate);
}

#ifdef KIRIGAMI_BUILD_TYPE_STATIC
KirigamiPlugin &KirigamiPlugin::getInstance()
{
    static KirigamiPlugin instance;
    return instance;
}

void KirigamiPlugin::registerTypes(QQmlEngine *engine)
{
    if (engine) {
        engine->addImportPath(QLatin1String(":/"));
    } else {
        qCWarning(KirigamiLog)
            << "Registering Kirigami on a null QQmlEngine instance - you likely want to pass a valid engine, or you will want to manually add the "
               "qrc root path :/ to your import paths list so the engine is able to load the plugin";
    }
}
#endif

#include "kirigamiplugin.moc"
#include "moc_kirigamiplugin.cpp"
