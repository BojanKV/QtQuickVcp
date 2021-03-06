/****************************************************************************
**
** Copyright (C) 2016 Alexander Rössler
** License: LGPL version 2.1
**
** This file is part of QtQuickVcp.
**
** All rights reserved. This program and the accompanying materials
** are made available under the terms of the GNU Lesser General Public License
** (LGPL) version 2.1 which accompanies this distribution, and is available at
** http://www.gnu.org/licenses/lgpl-2.1.html
**
** This library is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
** Lesser General Public License for more details.
**
** Contributors:
** Alexander Rössler <mail AT roesser DOT systems>
**
****************************************************************************/
import QtQuick 2.0
import QtQuick.Controls 1.2
import Machinekit.Application 1.0

ApplicationAction {
    property bool reset: false
    property bool _ready: status.synced && command.connected

    id: root
    text: qsTr("Power")
    //iconName: "system-shutdown"
    iconSource: "qrc:Machinekit/Application/Controls/icons/system-shutdown"
    shortcut: "F2"
    tooltip: qsTr("Reset Machine [%1]").arg(shortcut)
    checkable: true
    onTriggered: {
        if (!checked) {
            if (status.task.taskState === ApplicationStatus.TaskStateEstop) {
                command.setTaskState('execute', ApplicationCommand.TaskStateEstopReset);
            }
            command.setTaskState('execute', ApplicationCommand.TaskStateOn);
        }
        else {
            command.setTaskState('execute', ApplicationCommand.TaskStateEstop);
            if (reset) {
                command.setTaskState('execute', ApplicationCommand.TaskStateEstopReset);
                command.setTaskState('execute', ApplicationCommand.TaskStateOn);
            }
        }
    }

    checked: _ready && (status.task.taskState !== ApplicationStatus.TaskStateOn)
    enabled: _ready
}
