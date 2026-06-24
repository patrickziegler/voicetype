pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls as QQC2

import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.plasmoid

PlasmaExtras.Representation {
    id: root

    required property PlasmoidItem plasmoidItem
    required property PlasmaCore.Action vacAction

    implicitWidth: Kirigami.Units.gridUnit * 24
    implicitHeight: Kirigami.Units.gridUnit * 24

    // collapseMarginsHint: true

    header: Toolbar {
        plasmoidItem: root.plasmoidItem
        vacAction: root.vacAction
    }
}
