/*
    Based on the Desktop Change OSD script from KWin.

    SPDX-FileCopyrightText: 2012, 2013 Martin Gräßlin <mgraesslin@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick
import QtQuick.Window
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.activities as Activities
import org.kde.kwin

PlasmaCore.Window {
    id: dialog
    visible: false
    flags: Qt.X11BypassWindowManagerHint | Qt.FramelessWindowHint

    property rect screenGeometry

    width: mainItem.implicitWidth + leftPadding + rightPadding
    height: mainItem.implicitHeight + topPadding + bottomPadding

    x: screenGeometry.x + screenGeometry.width/2 - width/2
    y: screenGeometry.y + screenGeometry.height/2 - height/2 - height

    mainItem: Item {
        function loadConfig() {
            dialogItem.animationDuration = KWin.readConfig("PopupHideDelay", 500);
        }

        id: dialogItem
        property int animationDuration: 500

        implicitWidth: Math.ceil(textElement.implicitWidth)
        implicitHeight: textElement.implicitHeight

        Activities.ActivityInfo {
            id: activityInfo
        }

        Kirigami.Heading {
            id: textElement
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }

        Timer {
            id: timer
            repeat: false
            interval: dialogItem.animationDuration
            onTriggered: dialog.visible = false
        }

        Connections {
            target: Options
            function onConfigChanged() {
                dialogItem.loadConfig()
            }
        }
        Component.onCompleted: dialogItem.loadConfig()
    }

    function show(id) {
        if (Workspace.isEffectActive("overview")) {
            return;
        }
        // nameChanged is not emitted when the id changes, so no binding
        activityInfo.activityId = id;
        textElement.text = activityInfo.name;
        // screen geometry might have changed
        dialog.screenGeometry = Workspace.clientArea(KWin.FullScreenArea, Workspace.activeScreen, Workspace.currentDesktop);
        dialog.visible = true;
        // start the hide timer
        timer.restart();
    }
}
