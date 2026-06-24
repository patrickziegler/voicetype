pragma ComponentBehavior: Bound

import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    Plasmoid.icon: "microphone-sensitivity-high-symbolic"

    // to help systray decice to show it
    // Plasmoid.status: PlasmaCore.Types.ActiveStatus

    property bool voiceActivation: false

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            id: vacAction
            text: i18n("Voice Activation")
            checkable: true
            checked: root.voiceActivation
            onTriggered: checked => {
                root.voiceActivation = checked
            }
        }
    ]

    fullRepresentation: FullRepresentation {
        plasmoidItem: root
        vacAction: vacAction
    }
}
