pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.plasmoid

PlasmaExtras.PlasmoidHeading {
    id: root

    required property PlasmoidItem plasmoidItem
    required property PlasmaCore.Action vacAction

    leftPadding: mirrored ? 0 : Kirigami.Units.smallSpacing
    rightPadding: mirrored ? Kirigami.Units.smallSpacing : 0

    implicitHeight: Kirigami.Units.gridUnit * 1.8

    contentItem: RowLayout {
        spacing: Kirigami.Units.smallSpacing

        PlasmaComponents3.Switch {
            text: i18n("Enable voice activation")
            icon.name: "microphone"
            checked: root.plasmoidItem.voiceActivation
            focus: root.plasmoidItem.expanded
            onToggled: vacAction.trigger()
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
