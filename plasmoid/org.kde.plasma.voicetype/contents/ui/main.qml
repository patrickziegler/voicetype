import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents3

PlasmoidItem {
    id: root

    preferredRepresentation: fullRepresentation

    property bool recording: false
    property bool pushToTalk: true

    property int maxSeconds: 30
    property int remainingSeconds: 30

    Timer {
        id: countdown
        interval: 1000
        repeat: true

        onTriggered: {
            if (root.remainingSeconds > 0) {
                root.remainingSeconds--
            } else {
                root.stopRecording()
            }
        }
    }

    function startRecording() {
        recording = true

        if (pushToTalk) {
            remainingSeconds = maxSeconds
            countdown.start()
        }
    }

    function stopRecording() {
        recording = false
        countdown.stop()
        remainingSeconds = maxSeconds
    }

    compactRepresentation: PlasmaComponents3.ToolButton {
        icon.name: recording
        ? "media-record"
        : "audio-input-microphone"

        onClicked: Plasmoid.expanded = !Plasmoid.expanded
    }

    fullRepresentation: Item {
        Layout.minimumWidth: 340
        Layout.minimumHeight: 260

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            PlasmaComponents3.Label {
                text: "KVoiceType"
                font.bold: true
                font.pointSize: 14
            }

            PlasmaComponents3.Label {
                text: {
                    if (!recording)
                        return "Idle"

                        if (pushToTalk)
                            return "Recording..."

                            return "Waiting for speech..."
                }
            }

            PlasmaComponents3.Button {
                Layout.fillWidth: true

                text: recording
                ? "Stop Recording"
                : "Start Recording"

                onClicked: {
                    if (recording)
                        root.stopRecording()
                        else
                            root.startRecording()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                opacity: 0.3
            }

            RowLayout {
                Layout.fillWidth: true

                PlasmaComponents3.Label {
                    text: "Push-to-talk"
                    Layout.fillWidth: true
                }

                PlasmaComponents3.Switch {
                    id: pushToTalkSwitch

                    checked: root.pushToTalk

                    onToggled: {
                        root.pushToTalk = checked

                        if (!checked) {
                            countdown.stop()
                            root.remainingSeconds = root.maxSeconds
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                visible: root.pushToTalk

                PlasmaComponents3.Label {
                    text: "Time remaining"
                }

                ProgressBar {
                    Layout.fillWidth: true

                    from: 0
                    to: root.maxSeconds

                    value: root.remainingSeconds
                }

                PlasmaComponents3.Label {
                    text: root.remainingSeconds + " s"
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
