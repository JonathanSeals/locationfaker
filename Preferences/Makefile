
ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LocationFaker

LocationFaker_FILES = LFKRootListController.m
LocationFaker_INSTALL_PATH = /Library/PreferenceBundles
LocationFaker_FRAMEWORKS = UIKit
LocationFaker_PRIVATE_FRAMEWORKS = Preferences
LocationFaker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LocationFaker.plist$(ECHO_END)
