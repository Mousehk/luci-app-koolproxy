include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-koolproxy
PKG_VERSION:=3.8.6
PKG_RELEASE:=1

PKG_MAINTAINER:=panda-mute <wxuzju@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

RSTRIP:=true

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-koolproxy
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for koolproxy
	DEPENDS:=+openssl-util +ipset +dnsmasq-full +@BUSYBOX_CONFIG_DIFF +iptables-mod-nat-extra +wget
	MAINTAINER:=panda-mute
endef

define Package/luci-app-koolproxy/description
	This package contains LuCI configuration pages for koolproxy.
endef

define Build/Compile
endef

define Package/luci-app-koolproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-koolproxy ) && rm -f /etc/uci-defaults/luci-koolproxy
	rm -f /tmp/luci-indexcache
fi
exit 0
endef

define Package/luci-app-koolproxy/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/adblocklist
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/lib/upgrade/keep.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/koolproxy
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/koolproxy
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/share/koolproxy
	$(INSTALL_DIR) $(1)/usr/share/koolproxy/data
	$(INSTALL_DIR) $(1)/usr/share/koolproxy/data/rules/

	$(INSTALL_BIN) ./etc/uci-defaults/luci-koolproxy $(1)/etc/uci-defaults/luci-koolproxy
	$(INSTALL_BIN) ./etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DATA) ./etc/config/* $(1)/etc/config/
	$(INSTALL_DATA) ./etc/adblocklist/* $(1)/etc/adblocklist/
	$(INSTALL_DATA) ./lib/upgrade/keep.d/koolproxy $(1)/lib/upgrade/keep.d/
	$(INSTALL_DATA) ./usr/lib/lua/luci/model/cbi/koolproxy/global.lua $(1)/usr/lib/lua/luci/model/cbi/koolproxy/global.lua
	$(INSTALL_DATA) ./usr/lib/lua/luci/model/cbi/koolproxy/rss_rule.lua $(1)/usr/lib/lua/luci/model/cbi/koolproxy/rss_rule.lua
	$(INSTALL_DATA) ./usr/lib/lua/luci/controller/koolproxy.lua $(1)/usr/lib/lua/luci/controller/koolproxy.lua
	$(INSTALL_DATA) ./usr/lib/lua/luci/view/koolproxy/* $(1)/usr/lib/lua/luci/view/koolproxy/
	$(INSTALL_DATA) ./usr/lib/lua/luci/i18n/koolproxy.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/koolproxy.zh-cn.lmo
	$(INSTALL_BIN) ./usr/sbin/* $(1)/usr/sbin/
	$(INSTALL_BIN) ./usr/share/koolproxy/data/gen_ca.sh $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./usr/share/koolproxy/data/openssl.cnf $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./usr/share/koolproxy/data/user.txt $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./usr/share/koolproxy/data/source.list $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./usr/share/koolproxy/data/rules/* $(1)/usr/share/koolproxy/data/rules/
	$(INSTALL_BIN) ./usr/share/koolproxy/camanagement $(1)/usr/share/koolproxy/camanagement
	$(INSTALL_BIN) ./usr/share/koolproxy/kpupdate $(1)/usr/share/koolproxy/kpupdate
	$(INSTALL_DATA) ./usr/share/koolproxy/koolproxy_ipset.conf $(1)/usr/share/koolproxy/koolproxy_ipset.conf
	$(INSTALL_DATA) ./usr/share/koolproxy/dnsmasq.adblock $(1)/usr/share/koolproxy/dnsmasq.adblock
ifeq ($(ARCH),mipsel)
	$(INSTALL_BIN) ./bin/mipsel $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),mips)
	$(INSTALL_BIN) ./bin/mips $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),i386)
	$(INSTALL_BIN) ./bin/i386 $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),x86_64)
	$(INSTALL_BIN) ./bin/x86_64 $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./bin/arm $(1)/usr/share/koolproxy/koolproxy
endif
endef

$(eval $(call BuildPackage,luci-app-koolproxy))
