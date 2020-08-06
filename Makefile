ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone::6.0
THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = locationfaker
locationfaker_FILES = Tweak.xm
locationfaker_FRAMEWORKS = CoreLocation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload; killall -9 locationd"
include $(THEOS_MAKE_PATH)/aggregate.mk
