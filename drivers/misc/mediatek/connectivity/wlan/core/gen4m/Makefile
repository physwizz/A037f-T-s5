ifeq ($(CONFIG_MTK_PLATFORM),)
	CONFIG_MTK_PLATFORM := mt$(WLAN_CHIP_ID)
endif
MTK_PLATFORM := $(subst ",,$(CONFIG_MTK_PLATFORM))

ifeq ($(TARGET_PRODUCT),)
$(warning TARGET_PRODUCT is empty! using default option.)
endif

# disable logs!
ccflags-y += -DDBG_DISABLE_ALL_LOG=1

# ---------------------------------------------------
# OS option
# ---------------------------------------------------
os=$(CONFIG_MTK_SUPPORT_OS)

ifeq ($(os),)
os=linux
endif

ccflags-y += -Wno-unused-value
ccflags-y += -Wno-unused-result
ccflags-y += -Wno-format
ccflags-y += -Wno-parentheses

ifeq ($(os), none)
ccflags-y += -I/usr/include/
ccflags-y += -DCFG_VIRTUAL_OS
ccflags-y += -DCFG_REMIND_IMPLEMENT
endif

ifndef TOP
    TOP := $(srctree)/..
endif
$(info os option: $(os))
# ---------------------------------------------------
# ALPS Setting
# ---------------------------------------------------

ifeq ($(KBUILD_MODPOST_FAIL_ON_WARNINGS),)
    # Force build fail on modpost warning
    KBUILD_MODPOST_FAIL_ON_WARNINGS=y
endif

DRIVER_BUILD_DATE=$(shell date +%Y%m%d%H%M%S)
ccflags-y += -DDRIVER_BUILD_DATE='"$(DRIVER_BUILD_DATE)"'
# ---------------------------------------------------
# Compile Options
# ---------------------------------------------------
WLAN_CHIP_LIST:=-UMT6620 -UMT6628 -UMT5931 -UMT6630 -UMT6632 -UMT7663 -UCONNAC -USOC2_1X1 -USOC2_2X2 -UUT_TEST_MODE -UMT7915 -USOC3_0 -UMT7961 -USOC5_0 -USOC7_0
# '-D' and '-U' options are processed in the order they are given on the command line.
# All '-imacros file' and '-include file' options are processed after all '-D' and '-U' options.
ccflags-y += $(WLAN_CHIP_LIST)

ifeq ($(MTK_COMBO_CHIP),)
MTK_COMBO_CHIP = MT6632
endif

$(info $$MTK_PLATFORM is [${MTK_PLATFORM}])
$(info $$WLAN_CHIP_ID is [${WLAN_CHIP_ID}])
$(info $$MTK_COMBO_CHIP is [${MTK_COMBO_CHIP}])

ifneq ($(CONFIG_MTK_EMI),)
ccflags-y += -DCONFIG_WLAN_MTK_EMI=1
endif

ifneq ($(CONFIG_MEDIATEK_EMI),)
ccflags-y += -DCONFIG_WLAN_MTK_EMI=1
endif

ifeq ($(WLAN_CHIP_ID),)
WLAN_CHIP_ID=$(word 1, $(MTK_COMBO_CHIP))
endif

ifeq ($(strip $(MTK_PLATFORM)), mt6765)
    ccflags-y += -DCFG_PDMA_SLPPRT_MODE_SUPPORT
endif

ccflags-y += -DCFG_SUPPORT_DEBUG_FS=0
ccflags-y += -DWLAN_INCLUDE_PROC
ccflags-y += -DCFG_SUPPORT_AGPS_ASSIST=0
ccflags-y += -DCFG_SUPPORT_TSF_USING_BOOTTIME=1
ccflags-y += -DARP_MONITER_ENABLE=1
ccflags-y += -Werror
#ccflags-y:=$(filter-out -U$(WLAN_CHIP_ID),$(ccflags-y))
#ccflags-y += -DLINUX -D$(WLAN_CHIP_ID)
#workaround: also needed for none LINUX system
# because some of common part code is surrounded with this flag
ccflags-y += -DLINUX

ifneq ($(filter MT6632,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UMT6632,$(ccflags-y))
ccflags-y += -DMT6632
endif

ifneq ($(filter MT7668,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UMT7668,$(ccflags-y))
ccflags-y += -DMT7668
endif

ifneq ($(filter MT7663,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UMT7663,$(ccflags-y))
ccflags-y += -DMT7663
endif

ifneq ($(filter CONNAC,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UCONNAC,$(ccflags-y))
ccflags-y += -DCONNAC
endif

ifneq ($(filter SOC2_1X1,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -USOC2_1X1,$(ccflags-y))
ccflags-y += -DSOC2_1X1
ccflags-y += -DCONFIG_MTK_WIFI_VHT80
endif

ifneq ($(filter SOC2_2X2,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -USOC2_2X2,$(ccflags-y))
ccflags-y += -DSOC2_2X2
ccflags-y += -DCONFIG_MTK_WIFI_VHT80
endif

ifneq ($(findstring MT7915,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UMT7915,$(ccflags-y))
ccflags-y += -DMT7915
CONFIG_MTK_WIFI_CONNAC2X=y
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SMART_STA=n
CONFIG_NUM_OF_WFDMA_RX_RING=5
CONFIG_NUM_OF_WFDMA_TX_RING=1
endif

ifneq ($(findstring 3_0,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -USOC3_0,$(ccflags-y))
ccflags-y += -DSOC3_0
CONFIG_MTK_WIFI_CONNAC2X=y
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SMART_STA=n
CONFIG_NUM_OF_WFDMA_RX_RING=3
CONFIG_NUM_OF_WFDMA_TX_RING=0
CONFIG_MTK_WIFI_CONNINFRA_SUPPORT=y
CONFIG_MTK_WIFI_CONNAC2X_2x2=y
CONFIG_MTK_WIFI_DOWNLOAD_DYN_MEMORY_MAP=y
CFG_WIFI_WORKAROUND_HWITS00012836_WTBL_SEARCH_FAIL=1
CFG_WIFI_WORKAROUND_HWITS00010371_PMF_CIPHER_MISMATCH=1
ccflags-y += -DCFG_POWER_ON_DOWNLOAD_EMI_ROM_PATCH=1
ccflags-y += -DCFG_ROM_PATCH_NO_SEM_CTRL=1
ccflags-y += -DCONFIG_MTK_WIFI_HE80
endif

ifneq ($(findstring MT7961,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UMT7961,$(ccflags-y))
ccflags-y += -DMT7961
CONFIG_MTK_WIFI_CONNAC2X=y
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SMART_STA=n
CONFIG_NUM_OF_WFDMA_RX_RING=5
CONFIG_NUM_OF_WFDMA_TX_RING=1
endif

CONFIG_MTK_WIFI_NAN=n


ifneq ($(filter 6873, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_ENABLE_HOST_BUS_TIMEOUT=1
else
    ccflags-y += -DCFG_ENABLE_HOST_BUS_TIMEOUT=0
endif

ifneq ($(findstring 96516,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96516SA1_DOMAIN_CH
endif

ifneq ($(findstring a03,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96516SA1_DOMAIN_CH
endif

ifneq ($(findstring 96616,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96616AA1_DOMAIN_PWR
endif

ifneq ($(findstring a04,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96616AA1_DOMAIN_PWR
endif

########A045
ifneq ($(filter a04%,$(TARGET_PRODUCT)),)
ccflags-y += -DCONFIG_MTK_NEW_DOMAIN_CH
endif

########A055
ifneq ($(filter a05m%,$(TARGET_PRODUCT)),)
ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif

ifneq ($(findstring 5_0,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -USOC5_0,$(ccflags-y))
ccflags-y += -DSOC5_0
CONFIG_MTK_WIFI_CONNAC2X=y

ifneq ($(findstring tb8791tp1_64_ssdev_k419, $(CONFIG_ARCH_MTK_PROJECT)),)
$(info enable 11AX TWT for $(CONFIG_ARCH_MTK_PROJECT))
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
endif
ifneq ($(findstring tb8791tp1_64_titan_javan_tiger, $(CONFIG_ARCH_MTK_PROJECT)),)
$(info enable 11AX TWT for $(CONFIG_ARCH_MTK_PROJECT))
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
endif
CONFIG_NUM_OF_WFDMA_RX_RING=3
CONFIG_NUM_OF_WFDMA_TX_RING=0
CONFIG_MTK_WIFI_CONNINFRA_SUPPORT=y
CONFIG_MTK_WIFI_CONNAC2X_2x2=y
CONFIG_MTK_WIFI_DOWNLOAD_DYN_MEMORY_MAP=y
ccflags-y += -DCFG_POWER_ON_DOWNLOAD_EMI_ROM_PATCH=1
ccflags-y += -DCFG_ROM_PATCH_NO_SEM_CTRL=1
ifneq ($(findstring tb8791tp1_64_ssdev_k419, $(CONFIG_ARCH_MTK_PROJECT)),)
ccflags-y += -DCONFIG_MTK_WIFI_HE80
$(info enable HE80 for $(CONFIG_ARCH_MTK_PROJECT))
endif
ifneq ($(findstring tb8791tp1_64_titan_javan_tiger, $(CONFIG_ARCH_MTK_PROJECT)),)
ccflags-y += -DCONFIG_MTK_WIFI_HE80
$(info enable HE80 for $(CONFIG_ARCH_MTK_PROJECT))
endif
ifneq ($(findstring k6877ttv1_64_titan_black_tiger, $(CONFIG_ARCH_MTK_PROJECT)),)
ccflags-y += -DCONFIG_MTK_LATEST_DOMAIN_CH
else ifneq ($(findstring tb8791tp1_64_titan_javan_tiger, $(CONFIG_ARCH_MTK_PROJECT)),)
ccflags-y += -DCONFIG_MTK_LATEST_DOMAIN_CH
else
ccflags-y += -DCONFIG_MTK_NEW_DOMAIN_CH
endif
ifneq ($(findstring tb8791tp1_64_titan_javan_tiger, $(CONFIG_ARCH_MTK_PROJECT)),)
ccflags-y += -DCFG_RLM_TXPWR_INIT_FILE_HEADER=\"rlm_txpwr_init_tab8.h\"
endif
endif

ifneq ($(findstring 7_0,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -USOC7_0,$(ccflags-y))
ccflags-y += -DSOC7_0
CONFIG_MTK_WIFI_CONNAC2X=y
CONFIG_MTK_WIFI_11AX_SUPPORT=y
CONFIG_MTK_WIFI_6G_SUPPORT=y
CONFIG_MTK_WIFI_TWT_SUPPORT=y
CONFIG_NUM_OF_WFDMA_RX_RING=2
CONFIG_NUM_OF_WFDMA_TX_RING=0
CONFIG_MTK_WIFI_CONNINFRA_SUPPORT=y
CONFIG_MTK_WIFI_CONNAC2X_2x2=y
CONFIG_MTK_WIFI_DOWNLOAD_DYN_MEMORY_MAP=y
CONFIG_MTK_WIFI_POWER_THROTTLING=y
CONFIG_MTK_WIFI_PKT_OFLD_SUPPORT=y
CONFIG_MTK_WIFI_APF_SUPPORT=y

ccflags-y += -DCFG_POWER_ON_DOWNLOAD_EMI_ROM_PATCH=1
ccflags-y += -DCFG_ROM_PATCH_NO_SEM_CTRL=1
ccflags-y += -DCONFIG_MTK_WIFI_HE160
ccflags-y += -DCFG_SUPPORT_BW160
endif

ifeq ($(CONFIG_MTK_WIFI_CONNINFRA_SUPPORT), y)
ccflags-y += -DCFG_ANDORID_CONNINFRA_SUPPORT=1
else
ccflags-y += -DCFG_ANDORID_CONNINFRA_SUPPORT=0
endif

CONFIG_MTK_WIFI_PKT_OFLD_SUPPORT=y
CONFIG_MTK_WIFI_IGMP_OFLD_SUPPORT=y
CONFIG_MTK_WIFI_RA_OFLD_SUPPORT=y

ifeq ($(CONFIG_MTK_WIFI_CONNAC2X), y)
    ccflags-y += -DCFG_SUPPORT_CONNAC2X=1
    ccflags-y += -DCFG_SUPPORT_CONNAC3X=0
else
    ccflags-y += -DCFG_SUPPORT_CONNAC2X=0
endif

ifeq ($(CONFIG_MTK_WIFI_CONNAC2X_2x2), y)
    ccflags-y += -DCFG_SUPPORT_CONNAC2X_2x2=1
else
    ccflags-y += -DCFG_SUPPORT_CONNAC2X_2x2=0
endif

ifeq ($(CONFIG_MTK_WIFI_11AX_SUPPORT), y)
    ccflags-y += -DCFG_SUPPORT_802_11AX=1
else
    ccflags-y += -DCFG_SUPPORT_802_11AX=0
endif

ccflags-y += -DCFG_SUPPORT_802_11BE=0

ifeq ($(CONFIG_MTK_WIFI_11AX_SUPPORT), y)
    ifeq ($(CONFIG_MTK_WIFI_6G_SUPPORT), y)
        ccflags-y += -DCFG_SUPPORT_WIFI_6G=1
    else
        ccflags-y += -DCFG_SUPPORT_WIFI_6G=0
    endif
else
    ccflags-y += -DCFG_SUPPORT_WIFI_6G=0
endif

ifeq ($(CONFIG_MTK_WIFI_TWT_SUPPORT), y)
    ccflags-y += -DCFG_SUPPORT_TWT=1
    ifeq ($(CONFIG_MTK_WIFI_TWT_SMART_STA), y)
        ccflags-y += -DCFG_TWT_SMART_STA=1
    else
        ccflags-y += -DCFG_TWT_SMART_STA=0
    endif
else
    ccflags-y += -DCFG_SUPPORT_TWT=0
    ccflags-y += -DCFG_TWT_SMART_STA=0
endif

ifneq ($(CONFIG_NUM_OF_WFDMA_TX_RING),)
    ccflags-y += -DCONFIG_NUM_OF_WFDMA_TX_RING=$(CONFIG_NUM_OF_WFDMA_TX_RING)
endif

ifneq ($(CONFIG_NUM_OF_WFDMA_RX_RING),)
    ccflags-y += -DCONFIG_NUM_OF_WFDMA_RX_RING=$(CONFIG_NUM_OF_WFDMA_RX_RING)
endif

ifeq ($(WIFI_ENABLE_GCOV), y)
    GCOV_PROFILE := y
endif

ccflags-y += -DCFG_DRIVER_INITIAL_RUNNING_MODE=3

ifneq ($(filter 6765, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_SUPPORT_DUAL_STA=0
else ifeq ($(CONFIG_MTK_TC10_FEATURE), y)
    ccflags-y += -DCFG_SUPPORT_DUAL_STA=0
else
    ccflags-y += -DCFG_SUPPORT_DUAL_STA=1
endif

ifneq ($(filter 6779, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_FORCE_AP1NSS
endif

ifneq ($(filter 6853, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_MOUTON
else ifneq ($(filter 6768, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_TALBOT
ifneq ($(filter a13ve%, $(PROJECT_NAME)),)
    ccflags-y += -DCONFIG_MTK_NEW_DOMAIN_CH
endif
else ifneq ($(filter 6765, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_CERVENO
else ifneq ($(filter 6833, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_PALMER

ifneq ($(filter a13x%, $(PROJECT_NAME)),)
ifneq ($(findstring xx, $(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_NEW_DOMAIN_CH
endif
endif

else ifneq ($(filter 6877, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_MONTROSE
    CONFIG_MTK_WIFI_NAN=y
endif

ifneq ($(filter 8791, $(WLAN_CHIP_ID)),)
    ccflags-y += -DCFG_FS_WIFI6_MIMO
endif

ifneq ($(filter a34%, $(PROJECT_NAME)),)
    ccflags-y += -DCFG_FS_WIFI5_MIMO
endif

ifeq ($(MTK_ANDROID_WMT), y)
    ccflags-y += -DCFG_MTK_ANDROID_WMT=1
    WMT_SUPPORT := y
else ifneq ($(filter MT6632,$(MTK_COMBO_CHIP)),)
    ccflags-y += -DCFG_MTK_ANDROID_WMT=1
    WMT_SUPPORT := y
else
    ccflags-y += -DCFG_MTK_ANDROID_WMT=0
    WMT_SUPPORT := n
endif

ifeq ($(CONFIG_MTK_WIFI_CONNINFRA_SUPPORT), y)
    ccflags-y += -DCFG_SUPPORT_CONNINFRA=1
    ccflags-y += -DCFG_SUPPORT_PRE_ON_PHY_ACTION=1
    ccflags-y += -I$(TOP)/conninfra/include
    ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/power_throttling
    ccflags-y += -DCFG_ANDORID_CONNINFRA_COREDUMP_SUPPORT=1
else
    ccflags-y += -DCFG_SUPPORT_CONNINFRA=0
    ccflags-y += -DCFG_ANDORID_CONNINFRA_COREDUMP_SUPPORT=0
    ccflags-y += -DCFG_SUPPORT_PRE_ON_PHY_ACTION=0
    ifeq ($(WMT_SUPPORT), y)
        ccflags-y += -I$(TOP)/common/common_main/include
        ccflags-y += -I$(TOP)/common/common_main/linux/include
        ifeq ($(CONFIG_MTK_CONN_LTE_IDC_SUPPORT),y)
            ccflags-y += -DWMT_IDC_SUPPORT=1
        else
            ccflags-y += -DWMT_IDC_SUPPORT=0
        endif
        ccflags-y += -DMTK_WCN_WMT_STP_EXP_SYMBOL_ABSTRACT
    endif
endif

ifeq ($(CONFIG_MTK_WIFI_POWER_THROTTLING), y)
ccflags-y += -DCFG_SUPPORT_POWER_THROTTLING=1
else
ccflags-y += -DCFG_SUPPORT_POWER_THROTTLING=0
endif

ifeq ($(MTK_ANDROID_EMI), y)
    ccflags-y += -DCFG_MTK_ANDROID_EMI=1
else
    ccflags-y += -DCFG_MTK_ANDROID_EMI=0
endif

ifneq ($(WIFI_IP_SET),)
    ccflags-y += -DCFG_WIFI_IP_SET=$(WIFI_IP_SET)
else
    ccflags-y += -DCFG_WIFI_IP_SET=1
endif

ifneq ($(findstring UT_TEST_MODE,$(MTK_COMBO_CHIP)),)
ccflags-y:=$(filter-out -UUT_TEST_MODE,$(ccflags-y))
ccflags-y += -DUT_TEST_MODE
endif

CONFIG_MTK_WIFI_MCC_SUPPORT=y
ifeq ($(CONFIG_MTK_WIFI_MCC_SUPPORT), y)
    ccflags-y += -DCFG_SUPPORT_CHNL_CONFLICT_REVISE=0
else
    ccflags-y += -DCFG_SUPPORT_CHNL_CONFLICT_REVISE=1
endif

ifeq ($(CONFIG_MTK_AEE_FEATURE), y)
    ccflags-y += -DCFG_SUPPORT_AEE=1
else
    ccflags-y += -DCFG_SUPPORT_AEE=0
endif

# Disable ASSERT() for user load, enable for others
ifneq ($(TARGET_BUILD_VARIANT),user)
    ccflags-y += -DBUILD_QA_DBG=1
else
    ccflags-y += -DBUILD_QA_DBG=0
endif

ifeq ($(CONFIG_MTK_COMBO_WIFI),y)
    ccflags-y += -DCFG_WPS_DISCONNECT=1
endif

ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), sdio)
    ccflags-y += -D_HIF_SDIO=1
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), pcie)
    ccflags-y += -D_HIF_PCIE=1
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), usb)
    ccflags-y += -D_HIF_USB=1
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), axi)
    ccflags-y += -D_HIF_AXI=1
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), ut)
    # Increase frame size to 2048 because of 'cfg80211_connect_result' exceed stack size
    ccflags-y += -D_HIF_UT=1 -Wno-unused-function -Wno-unused-variable -Wframe-larger-than=2048
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), none)
	ccflags-y += -D_HIF_NONE=1
else
    $(error Unsuppoted HIF=$(CONFIG_MTK_COMBO_WIFI_HIF)!!)
endif

ifeq ($(CONFIG_MTK_WIFI_DOWNLOAD_DYN_MEMORY_MAP), y)
    ccflags-y += -DCFG_DOWNLOAD_DYN_MEMORY_MAP=1
else
    ccflags-y += -DCFG_DOWNLOAD_DYN_MEMORY_MAP=0
endif

ifneq ($(CFG_CFG80211_VERSION),)
VERSION_STR = $(subst \",,$(subst ., , $(subst -, ,$(subst v,,$(CFG_CFG80211_VERSION)))))
$(info VERSION_STR=$(VERSION_STR))
X = $(firstword $(VERSION_STR))
Y = $(word 2 ,$(VERSION_STR))
Z = $(word 3 ,$(VERSION_STR))
VERSION := $(shell echo "$$(( $X * 65536 + $Y * 256 + $Z))" )
ccflags-y += -DCFG_CFG80211_VERSION=$(VERSION)
$(info DCFG_CFG80211_VERSION=$(VERSION))
endif

ccflags-y += -DCFG_SUPPORT_PASSPOINT=1
ccflags-y += -DCFG_HS20_DEBUG=1
ccflags-y += -DCFG_ENABLE_GTK_FRAME_FILTER=1

MTK_MET_PROFILING_SUPPORT = yes
ifeq ($(MTK_MET_PROFILING_SUPPORT), yes)
    ccflags-y += -DCFG_MET_PACKET_TRACE_SUPPORT=1
else
    ccflags-y += -DCFG_MET_PACKET_TRACE_SUPPORT=0
endif

MTK_MET_TAG_SUPPORT = no
ifeq ($(MTK_MET_TAG_SUPPORT), yes)
    ccflags-y += -DMET_USER_EVENT_SUPPORT
    ccflags-y += -DCFG_MET_TAG_SUPPORT=1
else
    ccflags-y += -DCFG_MET_TAG_SUPPORT=0
endif

MTK_TC3_SUPPORT = no
ifeq ($(MTK_TC3_SUPPORT), yes)
    ccflags-y += -DCFG_TC3_FEATURE=1
    ccflags-y += -DCFG_P2P_CONNECT_ALL_BSS=1
    ccflags-y += -DCFG_P2P_DEFAULT_CLIENT_COUNT=1
    ccflags-y += -DCFG_P2P_SCAN_REPORT_ALL_BSS=1
else
    ccflags-y += -DCFG_TC3_FEATURE=0
endif

ifeq ($(CONFIG_MTK_TC10_FEATURE), y)
    ccflags-y += -DCFG_TC10_FEATURE=1
else
    ccflags-y += -DCFG_TC10_FEATURE=0
endif

ifneq ($(CONFIG_MTK_MD1_SUPPORT), )
    ccflags-y += -DCONFIG_MTK_MD_SUPPORT=1
else
    ccflags-y += -DCONFIG_MTK_MD_SUPPORT=0
endif

ifeq ($(CONFIG_MTK_TC1_FEATURE), y)
    ccflags-y += -I$(srctree)/drivers/misc/mediatek/tc1_interface
    ccflags-y += -DCFG_TC1_FEATURE=1
else
    ccflags-y += -DCFG_TC1_FEATURE=0
endif

ifeq ($(CONFIG_MTK_WIFI_NAN), y)
ccflags-y += -DCFG_SUPPORT_NAN=1
NEED_CRYPTO=y
else
ccflags-y += -DCFG_SUPPORT_NAN=0
endif

ifeq ($(MODULE_NAME),)
	MODULE_NAME := wlan_$(shell echo $(strip $(WLAN_CHIP_ID)) | tr A-Z a-z)_$(CONFIG_MTK_COMBO_WIFI_HIF)
endif

ccflags-y += -DDBG=0
ccflags-y += -I$(src)/os -I$(src)/os/$(os)/include
ccflags-y += -I$(src)/include -I$(src)/include/nic -I$(src)/include/mgmt -I$(src)/include/chips
ccflags-y += -I$(src)/include/wpa_supp
ifeq ($(CONFIG_MTK_WIFI_NAN), y)
ccflags-y += -I$(src)/include/nan
endif
ifeq ($(CFG_SUPPORT_WIFI_SYSDVT), 1)
ccflags-y += -I$(src)/include/dvt
endif
ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/performance/include/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/emi/$(MTK_PLATFORM)
ccflags-y += -I$(srctree)/drivers/misc/mediatek/emi/submodule
ccflags-y += -I$(srctree)/drivers/misc/mediatek/pmic/include/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/power_throttling/
ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/common
ccflags-y += -I$(srctree)/drivers/devfreq/
ccflags-y += -I$(srctree)/net
ccflags-y += -I$(TOP)/connfem/include/

ifneq ($(CONFIG_MTK_MDDP_SUPPORT),)
ccflags-y += -I$(srctree)/drivers/misc/mediatek/mddp/include/
ccflags-y += -DCFG_MTK_MDDP_SUPPORT=1
else
ccflags-y += -DCFG_MTK_MDDP_SUPPORT=0
endif

ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), sdio)
ccflags-y += -I$(src)/os/$(os)/hif/sdio/include
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), pcie)
ccflags-y += -I$(src)/os/$(os)/hif/common/include
ccflags-y += -I$(src)/os/$(os)/hif/pcie/include
ifneq ($(findstring 3_0,$(MTK_COMBO_CHIP)),)
ccflags-y += -I$(src)/include/chips/coda/soc3_0
endif
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), axi)
ccflags-y += -I$(src)/os/$(os)/hif/common/include
ccflags-y += -I$(src)/os/$(os)/hif/axi/include
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), usb)
ccflags-y += -I$(src)/os/$(os)/hif/usb/include
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), ut)
ccflags-y += -I$(src)/test -I$(src)/test/lib/include -I$(src)/test/testcases -I$(src)/test/lib/hif
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), none)
ccflags-y += -I$(src)/os/$(os)/hif/none/include
endif

ifneq ($(PLATFORM_FLAGS), )
    ccflags-y += $(PLATFORM_FLAGS)
endif

obj-y += $(MODULE_NAME).o

ifneq ($(filter yes,$(MTK_TC10_IN_HOUSE)),)
ccflags-y += -DMTK_TC10_IN_HOUSE
endif

ifeq ($(CONFIG_MTK_WIFI_PKT_OFLD_SUPPORT), y)
ccflags-y += -DCFG_SUPPORT_PKT_OFLD=1
ifeq ($(CONFIG_MTK_WIFI_APF_SUPPORT), y)
ccflags-y += -DCFG_SUPPORT_APF=1
else
ccflags-y += -DCFG_SUPPORT_APF=0
endif
ifeq ($(CONFIG_MTK_WIFI_IGMP_OFLD_SUPPORT), y)
ccflags-y += -DCFG_SUPPORT_IGMP_OFLD=1
else
ccflags-y += -DCFG_SUPPORT_IGMP_OFLD=0
endif
ifeq ($(CONFIG_MTK_WIFI_RA_OFLD_SUPPORT), y)
ccflags-y += -DCFG_SUPPORT_RA_OFLD=1
else
ccflags-y += -DCFG_SUPPORT_RA_OFLD=0
endif
else
ccflags-y += -DCFG_SUPPORT_PKT_OFLD=0
endif

# ---------------------------------------------------
# Directory List
# ---------------------------------------------------
COMMON_DIR  := common/
OS_DIR      := os/$(os)/
HIF_COMMON_DIR := $(OS_DIR)hif/common/
ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), sdio)
HIF_DIR	    := os/$(os)/hif/sdio/
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), pcie)
HIF_DIR     := os/$(os)/hif/pcie/
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), axi)
HIF_DIR	    := os/$(os)/hif/axi/
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), usb)
HIF_DIR	    := os/$(os)/hif/usb/
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), ut)
HIF_DIR	    := test/lib/hif/
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), none)
HIF_DIR	    := os/$(os)/hif/none/
endif
NIC_DIR     := nic/
MGMT_DIR    := mgmt/
NAN_DIR     := nan/
CHIPS       := chips/
CHIPS_CMM   := $(CHIPS)common/
WPA_DIR     := wpa_supp/

ifneq ($(WLAN_CHIP_ID),)
PLAT_DIR    := os/$(os)/plat/mt$(WLAN_CHIP_ID)/
endif
SYSDVT_DIR  := dvt/

# ---------------------------------------------------
# Objects List
# ---------------------------------------------------

COMMON_OBJS := 	$(COMMON_DIR)dump.o \
		$(COMMON_DIR)wlan_lib.o \
		$(COMMON_DIR)wlan_oid.o \
		$(COMMON_DIR)wlan_bow.o \
		$(COMMON_DIR)debug.o

NIC_OBJS := 	$(NIC_DIR)nic.o \
		$(NIC_DIR)nic_tx.o \
		$(NIC_DIR)nic_txd_v1.o \
		$(NIC_DIR)nic_rxd_v1.o \
		$(NIC_DIR)nic_rx.o \
		$(NIC_DIR)nic_pwr_mgt.o \
		$(NIC_DIR)nic_rate.o \
		$(NIC_DIR)cmd_buf.o \
		$(NIC_DIR)que_mgt.o \
		$(NIC_DIR)nic_cmd_event.o \
		$(NIC_DIR)nic_umac.o

ifeq ($(os), none)
OS_OBJS := 	$(OS_DIR)gl_dependent.o \
		$(OS_DIR)gl_init.o \
		$(OS_DIR)gl_kal.o \
		$(OS_DIR)gl_ate_agent.o \
		$(OS_DIR)gl_qa_agent.o
else
OS_OBJS := 	$(OS_DIR)gl_init.o \
		$(OS_DIR)gl_kal.o \
		$(OS_DIR)gl_bow.o \
		$(OS_DIR)gl_wext.o \
		$(OS_DIR)gl_wext_priv.o \
		$(OS_DIR)gl_ate_agent.o \
		$(OS_DIR)gl_qa_agent.o \
		$(OS_DIR)gl_hook_api.o \
		$(OS_DIR)gl_rst.o \
		$(OS_DIR)gl_cfg80211.o \
		$(OS_DIR)gl_proc.o \
		$(OS_DIR)gl_sys.o \
		$(OS_DIR)gl_vendor.o \
		$(OS_DIR)platform.o
endif

MGMT_OBJS := 	$(MGMT_DIR)ais_fsm.o \
		$(MGMT_DIR)aaa_fsm.o \
		$(MGMT_DIR)assoc.o \
		$(MGMT_DIR)auth.o \
		$(MGMT_DIR)bss.o \
		$(MGMT_DIR)cnm.o \
		$(MGMT_DIR)cnm_timer.o \
		$(MGMT_DIR)cnm_mem.o \
		$(MGMT_DIR)hem_mbox.o \
		$(MGMT_DIR)mib.o \
		$(MGMT_DIR)privacy.o \
		$(MGMT_DIR)rate.o \
		$(MGMT_DIR)rlm.o \
		$(MGMT_DIR)rlm_domain.o \
		$(MGMT_DIR)reg_rule.o \
		$(MGMT_DIR)rlm_obss.o \
		$(MGMT_DIR)rlm_protection.o \
		$(MGMT_DIR)rrm.o \
		$(MGMT_DIR)rsn.o \
		$(MGMT_DIR)saa_fsm.o \
		$(MGMT_DIR)scan.o \
		$(MGMT_DIR)scan_fsm.o \
		$(MGMT_DIR)scan_cache.o \
		$(MGMT_DIR)swcr.o \
		$(MGMT_DIR)roaming_fsm.o \
		$(MGMT_DIR)tkip_mic.o \
		$(MGMT_DIR)hs20.o \
		$(MGMT_DIR)tdls.o \
		$(MGMT_DIR)wnm.o \
		$(MGMT_DIR)qosmap.o \
		$(MGMT_DIR)ap_selection.o \
		$(MGMT_DIR)wmm.o \
		$(MGMT_DIR)mddp.o \
		$(MGMT_DIR)thrm.o \
		$(MGMT_DIR)mscs.o \
		$(MGMT_DIR)ie_sort.o \

ifeq ($(NEED_CRYPTO), y)
ccflags-y += -DCFG_SUPPORT_CRYPTO=1
CRYPTO_OBJS :=  $(WPA_DIR)FourWayHandShake.o\
        $(WPA_DIR)src/utils/common.o\
        $(WPA_DIR)src/crypto/sha1.o\
        $(WPA_DIR)src/crypto/sha1-internal.o\
        $(WPA_DIR)src/crypto/sha1-prf.o\
        $(WPA_DIR)src/crypto/aes-wrap.o\
        $(WPA_DIR)src/crypto/aes-internal.o\
        $(WPA_DIR)src/crypto/aes-unwrap.o\
        $(WPA_DIR)src/crypto/aes-internal-enc.o\
        $(WPA_DIR)src/crypto/aes-internal-dec.o\
        $(WPA_DIR)src/crypto/aes-siv.o\
        $(WPA_DIR)src/crypto/aes-ctr.o\
        $(WPA_DIR)src/crypto/aes-omac1.o\
        $(WPA_DIR)src/crypto/sha256.o\
        $(WPA_DIR)src/crypto/sha256-prf.o\
        $(WPA_DIR)src/crypto/sha256-internal.o\
        $(WPA_DIR)src/crypto/pbkdf2-sha256.o\
        $(WPA_DIR)src/crypto/sha384-internal.o\
        $(WPA_DIR)src/crypto/sha512-internal.o\
        $(WPA_DIR)src/crypto/sha384-prf.o\
        $(WPA_DIR)src/crypto/sha384.o \
        $(WPA_DIR)src/crypto/sha256-kdf.o \
        $(WPA_DIR)src/crypto/sha384-kdf.o
endif

ifneq ($(os), none)
MGMT_OBJS +=	$(MGMT_DIR)wlan_ring.o \
		$(OS_DIR)gl_sa_log.o
endif

# ---------------------------------------------------
# Chips Objects List
# ---------------------------------------------------
MGMT_OBJS += $(MGMT_DIR)stats.o


CHIPS_OBJS += $(CHIPS_CMM)cmm_asic_connac.o
CHIPS_OBJS +=  $(CHIPS_CMM)dbg_connac.o
ifeq ($(CONFIG_MTK_WIFI_CONNAC2X), y)
CHIPS_OBJS +=  $(CHIPS_CMM)dbg_connac2x.o
endif

ifeq ($(CONFIG_MTK_WIFI_CONNAC2X), y)
CHIPS_OBJS += $(CHIPS_CMM)cmm_asic_connac2x.o
CHIPS_OBJS += $(CHIPS_CMM)pre_cal.o
NIC_OBJS += $(NIC_DIR)nic_ext_cmd_event.o \
			$(NIC_DIR)nic_txd_v2.o \
			$(NIC_DIR)nic_rxd_v2.o
endif
CHIPS_OBJS += $(CHIPS_CMM)fw_dl.o

ifneq ($(filter MT6632,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)mt6632/mt6632.o
endif
ifneq ($(filter MT7668,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)mt7668/mt7668.o
endif
ifneq ($(filter MT7663,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)mt7663/mt7663.o
endif
ifneq ($(filter CONNAC,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)connac/connac.o
endif
ifneq ($(filter SOC2_1X1,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)soc2_1x1/soc2_1x1.o
endif
ifneq ($(filter SOC2_2X2,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)soc2_2x2/soc2_2x2.o
endif
ifneq ($(findstring MT7915,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)mt7915/mt7915.o
CHIPS_OBJS +=  $(CHIPS)mt7915/dbg_mt7915.o
endif
ifneq ($(findstring 3_0,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)soc3_0/soc3_0.o
CHIPS_OBJS += $(CHIPS)soc3_0/dbg_soc3_0.o
CHIPS_OBJS += $(CHIPS)soc3_0/hal_dmashdl_soc3_0.o
endif
ifneq ($(findstring MT7961,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)mt7961/mt7961.o
CHIPS_OBJS += $(CHIPS)mt7961/dbg_mt7961.o
CHIPS_OBJS += $(CHIPS)mt7961/hal_dmashdl_mt7961.o
endif
ifneq ($(findstring 5_0,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)soc5_0/soc5_0.o
CHIPS_OBJS += $(CHIPS)soc5_0/dbg_soc5_0.o
CHIPS_OBJS += $(CHIPS)soc5_0/hal_dmashdl_soc5_0.o
endif
ifneq ($(findstring 7_0,$(MTK_COMBO_CHIP)),)
CHIPS_OBJS += $(CHIPS)soc7_0/soc7_0.o
CHIPS_OBJS += $(CHIPS)soc7_0/dbg_soc7_0.o
CHIPS_OBJS += $(CHIPS)soc7_0/hal_dmashdl_soc7_0.o
endif

# ---------------------------------------------------
# P2P Objects List
# ---------------------------------------------------

COMMON_OBJS += $(COMMON_DIR)wlan_p2p.o

NIC_OBJS += $(NIC_DIR)p2p_nic.o

ifneq ($(os), none)
OS_OBJS += $(OS_DIR)gl_p2p.o \
           $(OS_DIR)gl_p2p_cfg80211.o \
           $(OS_DIR)gl_p2p_init.o \
           $(OS_DIR)gl_p2p_kal.o
endif

MGMT_OBJS += $(MGMT_DIR)p2p_dev_fsm.o\
            $(MGMT_DIR)p2p_dev_state.o\
            $(MGMT_DIR)p2p_role_fsm.o\
            $(MGMT_DIR)p2p_role_state.o\
            $(MGMT_DIR)p2p_func.o\
            $(MGMT_DIR)p2p_scan.o\
            $(MGMT_DIR)p2p_ie.o\
            $(MGMT_DIR)p2p_rlm.o\
            $(MGMT_DIR)p2p_assoc.o\
            $(MGMT_DIR)p2p_bss.o\
            $(MGMT_DIR)p2p_rlm_obss.o\
            $(MGMT_DIR)p2p_fsm.o

MGMT_OBJS += $(MGMT_DIR)wapi.o

# ---------------------------------------------------
# NAN Objects List
# ---------------------------------------------------
ifeq ($(CONFIG_MTK_WIFI_NAN), y)
OS_OBJS  += $(OS_DIR)gl_nan.o \
            $(OS_DIR)gl_vendor_nan.o \
            $(OS_DIR)gl_vendor_ndp.o
NAN_OBJS := $(NAN_DIR)nan_dev.o \
            $(NAN_DIR)nanDiscovery.o\
            $(NAN_DIR)nanScheduler.o\
            $(NAN_DIR)nanReg.o\
            $(NAN_DIR)nan_data_engine.o\
            $(NAN_DIR)nan_data_engine_util.o\
            $(NAN_DIR)nan_ranging.o\
            $(NAN_DIR)nan_txm.o

NAN_SEC_OBJS := $(NAN_DIR)nan_sec.o\
                $(WPA_DIR)src/ap/wpa_auth.o\
                $(WPA_DIR)src/common/wpa_common.o\
                $(WPA_DIR)src/rsn_supp/wpa.o\
                $(WPA_DIR)wpa_supplicant/wpas_glue.o\
                $(WPA_DIR)wpa_supplicant/wpa_supplicant.o\
                $(WPA_DIR)src/ap/wpa_auth_glue.o
endif

# ---------------------------------------------------
# HE Objects List
# ---------------------------------------------------

COMMON_OBJS += $(COMMON_DIR)wlan_he.o

ifeq ($(CONFIG_MTK_WIFI_11AX_SUPPORT), y)
MGMT_OBJS += $(MGMT_DIR)he_ie.o \
             $(MGMT_DIR)he_rlm.o
endif

ifeq ($(CONFIG_MTK_WIFI_11BE_SUPPORT), y)
MGMT_OBJS += $(MGMT_DIR)eht_rlm.o
endif

ifeq ($(CONFIG_MTK_WIFI_TWT_SUPPORT), y)
MGMT_OBJS += $(MGMT_DIR)twt_req_fsm.o \
             $(MGMT_DIR)twt.o \
             $(MGMT_DIR)twt_planner.o
endif

ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), sdio)
HIF_OBJS :=  $(HIF_DIR)arm.o \
             $(HIF_DIR)sdio.o \
             $(HIF_DIR)hal_api.o \
             $(HIF_DIR)sdio_test_driver_core.o \
             $(HIF_DIR)sdio_test_driver_ops.o
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), pcie)
HIF_OBJS :=  $(HIF_COMMON_DIR)hal_pdma.o \
             $(HIF_COMMON_DIR)kal_pdma.o \
             $(HIF_COMMON_DIR)dbg_pdma.o \
             $(HIF_DIR)pcie.o
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), axi)
HIF_OBJS :=  $(HIF_COMMON_DIR)hal_pdma.o \
             $(HIF_COMMON_DIR)kal_pdma.o \
             $(HIF_COMMON_DIR)dbg_pdma.o \
             $(HIF_COMMON_DIR)sw_wfdma.o \
             $(HIF_DIR)axi.o
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), usb)
HIF_OBJS :=  $(HIF_DIR)usb.o \
             $(HIF_DIR)hal_api.o
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), ut)
HIF_OBJS :=  $(HIF_DIR)ut.o \
             $(HIF_DIR)hal_api.o
else ifeq ($(CONFIG_MTK_COMBO_WIFI_HIF), none)
HIF_OBJS :=  $(HIF_DIR)none.o
endif
# ---------------------------------------------------
# Platform Objects List
# ---------------------------------------------------
ifneq ($(PLAT_DIR),)

PLAT_PRIV_C = $(src)/$(PLAT_DIR)plat_priv.c

# search path (out of kernel tree)
IS_EXIST_PLAT_PRIV_C := $(wildcard $(PLAT_PRIV_C))
# search path (build-in kernel tree)
IS_EXIST_PLAT_PRIV_C += $(wildcard $(srctree)/$(PLAT_PRIV_C))

ifneq ($(strip $(IS_EXIST_PLAT_PRIV_C)),)
PLAT_OBJS := $(PLAT_DIR)plat_priv.o
$(MODULE_NAME)-objs  += $(PLAT_OBJS)
endif
endif

# ---------------------------------------------------
# System Dvt Objects List
# ---------------------------------------------------
ifeq ($(CFG_SUPPORT_WIFI_SYSDVT), 1)
SYSDVT_OBJS += $(SYSDVT_DIR)dvt_common.o

ifeq ($(CFG_SUPPORT_DMASHDL_SYSDVT), 1)
SYSDVT_OBJS += $(SYSDVT_DIR)dvt_dmashdl.o
endif
endif

# ---------------------------------------------------
# Service git List
# ---------------------------------------------------

MTK_WLAN_SERVICE=yes
SERVICE_DIR  := wlan_service/
$(info SERVICE_DIR is [{$(SERVICE_DIR)}])

ifeq ($(MTK_WLAN_SERVICE), yes)
ccflags-y += -DCONFIG_WLAN_SERVICE=1
ccflags-y += -DCONFIG_TEST_ENGINE_OFFLOAD=1
ccflags-y += -I$(src)/$(SERVICE_DIR)include
ccflags-y += -I$(src)/$(SERVICE_DIR)service/include
ccflags-y += -I$(src)/$(SERVICE_DIR)glue/osal/include
ccflags-y += -I$(src)/$(SERVICE_DIR)glue/hal/include
SERVICE_OBJS := $(SERVICE_DIR)agent/agent.o \
                $(SERVICE_DIR)service/service_test.o \
                $(SERVICE_DIR)service/test_engine.o \
                $(SERVICE_DIR)glue/osal/gen4m/sys_adaption_gen4m.o \
                $(SERVICE_DIR)glue/osal/gen4m/net_adaption_gen4m.o \
                $(SERVICE_DIR)glue/hal/gen4m/operation_gen4m.o
$(MODULE_NAME)-objs  += $(SERVICE_OBJS)
$(info $$MTK_WLAN_SERVICE is [{$(SERVICE_OBJS)}])
else
ccflags-y += -DCONFIG_WLAN_SERVICE=0
ccflags-y += -DCONFIG_TEST_ENGINE_OFFLOAD=0
endif

$(MODULE_NAME)-objs  += $(COMMON_OBJS)
$(MODULE_NAME)-objs  += $(NIC_OBJS)
$(MODULE_NAME)-objs  += $(OS_OBJS)
$(MODULE_NAME)-objs  += $(HIF_OBJS)
$(MODULE_NAME)-objs  += $(MGMT_OBJS)
$(MODULE_NAME)-objs  += $(CHIPS_OBJS)
$(MODULE_NAME)-objs  += $(SYSDVT_OBJS)
$(MODULE_NAME)-objs  += $(CRYPTO_OBJS)
$(MODULE_NAME)-objs  += $(NAN_OBJS)
$(MODULE_NAME)-objs  += $(NAN_SEC_OBJS)

ifneq ($(findstring UT_TEST_MODE,$(MTK_COMBO_CHIP)),)
include $(src)/test/ut.make
endif

ifneq ($(findstring 96801,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_BOARD_HAS_W1_OPTION_H
endif
ifneq ($(findstring 96806,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_BOARD_HAS_W1_OPTION_H
endif

ifneq ($(findstring a22,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_BOARD_HAS_W1_OPTION_H
endif
ifneq ($(findstring 96902,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96902AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmsq,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96902AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmcs,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96902AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmtfn,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96902AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmue,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96902AA1_DOMAIN_PWR
endif
ifneq ($(findstring 96901AA1,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring 96901WA1,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmzh,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmxx,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmeea,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring a14xmtur,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96901AA1_DOMAIN_PWR
endif
ifneq ($(findstring 96818AA1,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring 96818BA1,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring a05mxx,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring a05mins,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring a05mtur,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring a05mser,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring a05mub,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_MTK_S96818AA1_DOMAIN_PWR
endif
ifneq ($(findstring f42,$(TARGET_PRODUCT)),)
    ccflags-y += -DCONFIG_BOARD_HAS_W1_OPTION_H
endif

## ^^^ ignore if not necessary ^^^ ##
