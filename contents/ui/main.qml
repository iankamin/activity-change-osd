/*
    Based on the Desktop Change OSD script from KWin.

    SPDX-FileCopyrightText: 2012, 2013 Martin Gräßlin <mgraesslin@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick
import org.kde.kwin

Loader {
    id: mainItemLoader

    Connections {
        target: Workspace
        function onCurrentActivityChanged(id) {
            if (!mainItemLoader.item) {
                mainItemLoader.source = "osd.qml";
            }
            mainItemLoader.item.show(id);
        }
    }
}
