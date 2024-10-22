#
#  Copyright (c) 2021 true[X], Inc. All rights reserved.
#

MAKE_FILE := $(lastword $(MAKEFILE_LIST))
APPNAME = truex-roku-game-reference-app
IMPORTS =
ROKU_TEST_ID = 1
ROKU_TEST_WAIT_DURATION = 5
# Use globally set IP address and password as fallback
ROKU_DEV_TARGET := $(if $(ROKU_DEV_TARGET_OVERRIDE),$(ROKU_DEV_TARGET_OVERRIDE),$(ROKU_DEV_TARGET))
DEVPASSWORD := $(if $(DEVPASSWORD_OVERRIDE),$(DEVPASSWORD_OVERRIDE),$(DEVPASSWORD))
ZIP_EXCLUDE = -x test\* -x *.sh -x makefile -x dist\* -x channel_components\* -x channel_source\* -x channel_images\* -x *app.mk* -x *README* -x *rokuTarget* -x *.svn* -x *.git* -x *.DS_Store* -x out\* -x packages\* -x design\* -x node_modules/**\* -x node_modules -x .buildpath* -x .project* -x renderer\* -x backup\* -x *.code-workspace
APPSROOT = .
include $(APPSROOT)/app.mk

# The below `-hd` targets are normally used by CI to produce the HD / 720p version of Southback.
# This is done by updating the `ui_resolutions` value in the manifest to `hd`. The Southback layout
# honors this setting and dynamically adjusts the layout.
gen-hd:
	@echo " >> generating hd (720p) version of $(APPNAME)"
	@sed "s/ui_resolutions=.*/ui_resolutions=hd/g" manifest > manifestUpdated
	@mv manifestUpdated manifest

build-hd: gen-hd $(APPNAME)

install-hd: build-hd install

.PHONY: update_truex_lib_uri
update_truex_lib_uri:
	sed -i.back 's|ComponentLibrary id="TruexAdRendererLib" uri=".*"|ComponentLibrary id="TruexAdRendererLib" uri="$(TRUEX_LIB_URI)"|' ./components/TruexAdRendererScene.xml ;\
	sed -i.back 's|"https://ctv.truex.com/roku/v1/release/TruexAdRenderer-availability-v1.brs"|"$(TRUEX_AVAILABILITY_URI)"|' ./source/room_main.brs ;\
	rm -f './components/TruexAdRendererScene.xml.back' './source/room_main.brs.back'

fetch_game_engine:
	git submodule update --init --recursive
