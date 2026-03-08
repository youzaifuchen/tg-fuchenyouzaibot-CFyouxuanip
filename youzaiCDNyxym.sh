#!/usr/bin/env bash
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
echo "已收录CF-CDN域名：${#cdn_domains[@]} 个"
echo "------------------------------------------------------"

sleep 2

echo "开始测试，每个域名 Ping 3 次并取平均值..."
echo ""

ping_results=()

for domain in "${cdn_domains[@]}"; do
  echo -n "正在测试 $domain ... "

  result=$(ping -c 3 -q "$domain" 2>/dev/null | awk -F'/' 'END {print $5}')

  if [ -n "$result" ]; then
    echo "$result ms"
    ping_results+=("$result:$domain")
  else
    echo "Ping失败"
  fi
done

echo ""
echo "开始排序..."
echo ""

sorted=$(printf "%s\n" "${ping_results[@]}" | sort -t ":" -k1n)

echo "$sorted" | while IFS=":" read -r ping domain
do
  printf "%s ms  %s\n" "$ping" "$domain"
done > CDNym.txt

echo "-----------------------------------"
echo "排序完成，结果已保存到 CDNym.txt"
echo "-----------------------------------"

cat CDNym.txt

echo ""
echo "提示：如果网络支持IPv6，可使用 CF 不死IP：2606:4700::"
