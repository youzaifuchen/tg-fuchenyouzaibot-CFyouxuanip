#!/bin/bash
export LANG=en_US.UTF-8

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

echo "------------------------------------------------------"
echo "悠哉TG联系方式 ：@fuchenyouzaibot"
echo "悠哉TG联系方式 ：@youzaifuchenbot"
echo "苍井空提示 ：悠哉永久免费分享"
echo "------------------------------------------------------"
echo "悠哉提示请在非代理的本地网络环境下运行"
echo "------------------------------------------------------"
echo "26.03.08更新：目前已收录${#cdn_domains[@]}个CF-CDN域名（不定期更新域名列表）"
echo "------------------------------------------------------"

sleep 1

echo "苍井空提示每个域名Ping 3次，取平均值排序……"
echo "悠哉提示注意：Ping值高低仅供参考，与速度无关"

sleep 1

ping_results=()

for domain in "${cdn_domains[@]}"; do
    echo -n "正在测试 $domain 的ping值…… "
    ping_result=$(ping -c 3 -q "$domain" 2>/dev/null | awk -F'/' 'END {print $5}')

    if [ -n "$ping_result" ]; then
        echo "$ping_result ms"
        ping_results+=("$ping_result:$domain")
    else
        echo "悠哉提示该域名ping失败"
    fi
done

# 排序
sorted_results=$(printf "%s\n" "${ping_results[@]}" | sort -t ':' -k1n)

# 输出到文件
output_file="$HOME/CDNym.txt"
echo "$sorted_results" | while IFS=":" read -r ping_value domain; do
    printf "%s ms：%s\n" "$ping_value" "$domain"
done > "$output_file"

echo ""
echo "悠哉提示排序结果已保存到主目录文件：$output_file"
echo "------------------------"
cat "$output_file"
echo ""
echo "苍井空提示：如果你的网络支持IPV6，可使用懒人专用不死自选IP：2606:4700:: 填到客户端地址即可"
echo "------------------------"
