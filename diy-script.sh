#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 添加必要插件
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/luci-app-openclash
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
sed -i "s/DISTRIB_REVISION=.*/DISTRIB_REVISION='R${date_version} by Haiibo'/g" package/lean/default-settings/files/zzz-default-settings

# 更新和安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a
