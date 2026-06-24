pragma ComponentBehavior: Bound

import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.workspace.dbus as DBus

PlasmoidItem {
    id: root

    Plasmoid.icon: "microphone-sensitivity-high-symbolic"

    // to help systray decice to show it
    // Plasmoid.status: PlasmaCore.Types.ActiveStatus

    // property bool voiceActivation: false

    DBus.Properties {
        id: voiceType

        busType: DBus.BusType.Session
        service: "org.kde.VoiceType"
        path: "/org/kde/VoiceType"
        iface: "org.kde.VoiceType"

        readonly property bool voiceActivation:
        Boolean(properties.VoiceActivation)

        readonly property string language:
        String(properties.Language)

        readonly property int status:
        Number(properties.Status)

        readonly property string text:
        String(properties.Text)

        readonly property string provider:
        String(properties.Provider)

        readonly property int maximumRecordingDurationSeconds:
        Number(properties.MaximumRecordingDurationSeconds)
    }

    VoiceTypeControl {
        id: voice
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            id: vacAction

            text: i18n("Voice Activation")
            checkable: true
            checked: voiceType.voiceActivation

            onTriggered: checked => {
                voice.setVoiceActivation(checked)
            }
        }
    ]

    fullRepresentation: FullRepresentation {
        plasmoidItem: root
        vacAction: vacAction
    }
}
