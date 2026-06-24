#include "voicetypecontrol.hpp"
#include <QDBusConnection>

VoiceTypeControl::VoiceTypeControl(QObject *parent)
: QObject(parent)
, m_iface(
    "org.kde.VoiceType",
    "/org/kde/VoiceType",
    "org.kde.VoiceType",
    QDBusConnection::sessionBus())
{}

void VoiceTypeControl::setVoiceActivation(bool enabled)
{
    m_iface.call("SetVoiceActivation", enabled);
}

void VoiceTypeControl::startRecording()
{
    m_iface.call("StartRecording");
}

void VoiceTypeControl::stopRecording()
{
    m_iface.call("StopRecording");
}
