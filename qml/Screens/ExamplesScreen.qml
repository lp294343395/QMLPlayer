/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov.
** Contact: wearyinside@gmail.com
**
** This file is part of QML Creator.
**
** QML Creator is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** QML Creator is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with QML Creator. If not, see http://www.gnu.org/licenses/.
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import "../Components"

BlankScreen {
    id: examplesScreen
    title: "Examples"

    ListModel {
        id: examplesListModel
        Component.onCompleted: {
            var groups = projectManager.getExampleGroups()
            for (var i = 0; i < groups.length; i++) {
                var group = groups[i]
                var examples = projectManager.getExamplesFromGroup(group)
                for (var j = 0; j < examples.length; j++) {
                    examplesListModel.append({ "group" : group, "name": examples[j] })
                }
            }
        }
    }

    CListView {
        anchors.fill: parent
        model: examplesListModel
        delegate: CButton {
            anchors.left: parent.left
            anchors.right: parent.right
            text: model.name
            onClicked: {
                if (!stackView.busy) {
                    projectManager.exampleGroup = model.group
                    projectManager.openProject(model.name)
                    stackView.push(Qt.resolvedUrl("FilesScreen.qml"))
                }
            }
        }
        section.property: "group"
        section.delegate: Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: childrenRect.height
            color: "#e8e8e8"

            CLabel {
                anchors.left: parent.left
                anchors.leftMargin: 6 * appWindow.pixelDensity
                text: section
                font.bold: true
            }
        }
    }
}
