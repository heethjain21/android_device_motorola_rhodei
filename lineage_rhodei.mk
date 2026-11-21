#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from rhodei device
$(call inherit-product, device/motorola/rhodei/device.mk)

# Tester builds need USB ADB before Setup Wizard can show an auth prompt.
ifeq ($(RHODEI_TESTER_ADB),true)
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
WITH_ADB_INSECURE := true
TARGET_UNOFFICIAL_BUILD_ID := ADB-TESTER
PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG := true
PRODUCT_SYSTEM_PROPERTIES += persist.sys.usb.config=adb
endif
else ifneq ($(and $(filter userdebug eng,$(TARGET_BUILD_VARIANT)),$(strip $(RHODEI_ADB_PUBLIC_KEY))),)
PRODUCT_ADB_KEYS := $(strip $(RHODEI_ADB_PUBLIC_KEY))
PRODUCT_SYSTEM_PROPERTIES += persist.sys.usb.config=adb
endif

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_rhodei
PRODUCT_DEVICE := rhodei
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g62 5G

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="rhodei_g-user 13 T1SSIS33.1-75-7-16 3686b-585454 release-keys" \
    BuildFingerprint=motorola/rhodei_g/rhodei:13/T1SSIS33.1-75-7-16/3686b-585454:user/release-keys \
    DeviceProduct=rhodei_g
