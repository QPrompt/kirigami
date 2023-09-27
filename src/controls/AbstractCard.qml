/*
 *  SPDX-FileCopyrightText: 2018 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import org.kde.kirigami.private as KP
import org.kde.kirigami.templates as KT

/**
 * @brief AbstractCard is the base for cards.
 *
 * A Card is a visual object that serves as an entry point for more detailed information.
 * An abstractCard is empty, providing just the look and the base properties and signals
 * for an ItemDelegate. It can be filled with any custom layout of items,
 * its content is organized in 3 properties: header, contentItem and footer.
 * Use this only when you need particular custom contents, for a standard layout
 * for cards, use the Card component.
 *
 * @see org::kde::kirigami::Card
 * @inherit org::kde::kirigami::templates::AbstractCard
 * @since 2.4
 */
KT.AbstractCard {
    id: root

    background: KP.DefaultCardBackground {
        clickFeedback: root.showClickFeedback
        hoverFeedback: root.hoverEnabled
    }
}
