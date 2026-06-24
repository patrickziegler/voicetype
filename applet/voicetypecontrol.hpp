#pragma once

#include <QObject>
#include <QDBusInterface>

#include <qqmlintegration.h>

class VoiceTypeControl : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit VoiceTypeControl(QObject *parent = nullptr);

    Q_INVOKABLE void setVoiceActivation(bool enabled);
    Q_INVOKABLE void startRecording();
    Q_INVOKABLE void stopRecording();

private:
    QDBusInterface m_iface;
};
