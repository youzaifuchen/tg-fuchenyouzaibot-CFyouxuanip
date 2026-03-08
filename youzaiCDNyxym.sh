#!/data/data/com.termux/files/usr/bin/bash
export LANG=en_US.UTF-8

# 悠哉专属CF-CDN Ping测速脚本 v2 (Termux Unix版)
# 日期：26.03.09

cdn_domains=(
"time.cloudflare.com"
"shopify.com"
"time.is"
"icook.hk"
"icook.tw"
"ip.sb"
"japan.com"
"malaysia.com"
"russia.com"
"singapore.com"
"skk.moe"
"www.visa.com"
"www.visa.com.sg"
"www.visa.com.hk"
"www.visa.com.tw"
"www.visa.co.jp"
"www.visakorea.com"
"www.gco.gov.qa"
"www.gov.se"
"www.gov.ua"
"www.digitalocean.com"
"www.csgo.com"
"www.shopify.com"
"www.whoer.net"
"www.whatismyip.com"
"www.ipget.net"
"www.hugedomains.com"
"www.udacity.com"
"www.4chan.org"
"www.okcupid.com"
"www.glassdoor.com"
"www.udemy.com"
"www.baipiao.eu.org"
"cdn.anycast.eu.org"
"edgetunnel.anycast.eu.org"
"alejandracaiccedo.com"
"log.bpminecraft.com"
"www.boba88slot.com"
"gur.gov.ua"
"www.zsu.gov.ua"
"www.iakeys.com"
"edtunnel-dgp.pages.dev"
"fbi.gov"
"download.yunzhongzhuan.com"
"whatismyipaddress.com"
"www.ipaddress.my"
"www.pcmag.com"
"www.ipchicken.com"
"www.iplocation.net"
"iplocation.io"
"www.who.int"
"www.wto.org"
)

# 彩色输出
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${YELLOW}------------------------------------------------------${RESET}"
echo -e "${GREEN}悠哉TG联系方式 ：@fuchenyouzaibot${RESET}"
echo -e "${GREEN}悠哉TG联系方式 ：@youzaifuchenbot${RESET}"
echo -e "${YELLOW}------------------------------------------------------${RESET}"
echo -e "${GREEN}悠哉提示请在非代理的本地网络环境下运行${RESET}"
echo -e "${YELLOW}------------------------------------------------------${RESET}"
echo -e "${GREEN}26.03.09更新：目前已收录${#cdn_domains[@]}个CF-CDN域名${RESET}"
echo -e "${YELLOW}------------------------------------------------------${RESET}"

sleep 1

echo -e "${GREEN}苍井空提示每个域名Ping 3次，取平均值排序……${RESET}"
echo -e "${GREEN}悠哉提示注意：Ping值高低仅供参考，与速度无关${RESET}"

sleep 1

ping_results=()

for domain in "${cdn_domains[@]}"; do
    echo -ne "正在测试 $domain …… "
    
    # 尝试IPv4
    ping_value=$(ping -c 3 -q "$domain" 2>/dev/null | awk -F'/' 'END {print $5}')
    
    # 如果失败，尝试IPv6
    if [ -z "$ping_value" ]; then
        ping_value=$(ping6 -c 3 -q "$domain" 2>/dev/null | awk -F'/' 'END {print $5}')
    fi
    
    if [ -n "$ping_value" ]; then
        echo -e "${GREEN}$ping_value ms${RESET}"
        ping_results+=("$ping_value:$domain")
    else
        echo -e "${RED}ping失败${RESET}"
    fi
done

# 排序
sorted_results=$(printf "%s\n" "${ping_results[@]}" | sort -t ':' -k1n)

# 输出到文件
output_file="$HOME/CDNym.txt"
echo "$sorted_results" | while IFS=":" read -r ping_value domain; do
    printf "%s ms：%s\n" "$ping_value" "$domain"
done | tee "$output_file"

echo -e "${YELLOW}\n悠哉提示排序结果已保存到主目录文件：${output_file}${RESET}"
echo -e "${GREEN}选择延迟低的域名替换客户端地址即可${RESET}"
echo -e "${YELLOW}------------------------${RESET}"
echo -e "${GREEN}如果你的网络支持IPv6，可使用懒人专用IP：2606:4700:: 填到客户端地址即可${RESET}"
echo -e "${YELLOW}------------------------${RESET}
