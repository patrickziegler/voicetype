.PHONY: install upgrade remove

install:
	kpackagetool6 --type Plasma/Applet --install ./org.kde.plasma.voicetype
	systemctl --user restart plasma-plasmashell.service

upgrade:
	kpackagetool6 --type Plasma/Applet --upgrade ./org.kde.plasma.voicetype
	systemctl --user restart plasma-plasmashell.service

remove:
	kpackagetool6 --type Plasma/Applet --remove org.kde.plasma.voicetype
	systemctl --user restart plasma-plasmashell.service
