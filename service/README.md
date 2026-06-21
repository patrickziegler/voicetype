# VoiceType Service

## Interaction via DBus

```sh
busctl --user introspect \
    org.kde.VoiceType \
    /org/kde/VoiceType
    
busctl --user get-property \
    org.kde.VoiceType \
    /org/kde/VoiceType \
    org.kde.VoiceType \
    Status
    
busctl --user set-property \
    org.kde.VoiceType \
    /org/kde/VoiceType \
    org.kde.VoiceType \
    VoiceActivation \
    b false

busctl --user call \
    org.kde.VoiceType \
    /org/kde/VoiceType \
    org.kde.VoiceType \
    StartRecording
```

## Output

```
patrick@shuttle:~/workspace/projects/voicetype/build> busctl --user introspect \
>     org.kde.VoiceType \
>     /org/kde/VoiceType
NAME                                TYPE      SIGNATURE RESULT/VALUE     FLAGS
org.freedesktop.DBus.Introspectable interface -         -                -
.Introspect                         method    -         s                -
org.freedesktop.DBus.Peer           interface -         -                -
.GetMachineId                       method    -         s                -
.Ping                               method    -         -                -
org.freedesktop.DBus.Properties     interface -         -                -
.Get                                method    ss        v                -
.GetAll                             method    s         a{sv}            -
.Set                                method    ssv       -                -
.PropertiesChanged                  signal    sa{sv}as  -                -
org.kde.VoiceType                   interface -         -                -
.StartRecording                     method    -         -                -
.StopRecording                      method    -         -                -
.Language                           property  s         "en-US"          emits-change writable
.MaximumRecordingDurationSeconds    property  u         30               emits-change
.Provider                           property  s         "Dummy Provider" emits-change
.Status                             property  u         0                emits-change
.Text                               property  s         ""               emits-change
.VoiceActivation                    property  b         true             emits-change writable
```
