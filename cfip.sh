#!/bin/bash
export LANG=en_US.UTF-8
os_type=$(uname)
os_arch=$(uname -m)
if [ "$os_type" == "Darwin" ]; then
if [ "$os_arch" == "x86_64" ] || [ "$os_arch" == "i386" ]; then
cpu="amd64a"
elif [ "$os_arch" == "arm64" ]; then
cpu="arm64a"
fi
else
case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
 	armv7l )
        cpu=arm
	;;
	* )
	echo "苍井空提示当前架构为$(uname -m)，暂不支持"
	exit
	;;
esac
fi


speedtestrul(){
echo "悠哉提起是否使用其他测速地址？（可直接输入其他测速地址 【 注意，不要带http(s):// 】 ，回车使用默认测速地址）"
read -p "请输入: " menu
if [ -z $menu ]; then
URL="speed.cloudflare.com/__down?bytes=100000000"
else
URL="$menu"
fi
}


gfip(){
if [ ! -f cfcdnip ]; then
curl -L -o cfcdnip -# --retry 2 https://gh-proxy.com/https://raw.githubusercontent.com/fuchenyouzai/tg-fuchenyouzaibot-CFyouxuanip/refs/heads/main/cpu4/$cpu
chmod +x cfcdnip
fi
echo "1、悠哉优选CF官方IPV4"
echo "2、悠哉优选CF官方IPV6 (本地网络须支持IPV6)"
read -p "苍井空提示请选择：" point
if [ "$point" = "1" ]; then
curl -s -O https://gh-proxy.com/https://gh-proxy.com/https://raw.githubusercontent.com/fuchenyouzai/tg-fuchenyouzaibot-CFyouxuanip/refs/heads/main/cpu3/ip.txt
elif [ "$point" = "2" ]; then
curl -s -o ip.txt https://gh-proxy.com/https://gh-proxy.com/https://raw.githubusercontent.com/fuchenyouzai/tg-fuchenyouzaibot-CFyouxuanip/refs/heads/main/cpu3/ipv6.txt
else
echo "苍井空提示输入有误，请重新选择" && gfip
fi
echo "虽然官方IP的13个端口通用，但请选择一个最经常使用的端口作为测试依据"
echo "开启tls的端口：443、8443、2053、2083、2087、2096"
echo "关闭tls的端口：80、8080、8880、2052、2082、2086、2095"
read -p "请选择以上13个端口之一：" point
if ! [[ "$point" =~ ^(2052|2082|2086|2095|80|8880|8080|2053|2083|2087|2096|8443|443)$ ]]; then
echo "输入的端口为$opint，输入错误" && cfpoint
fi
if [ "$cpu" = arm64 ] || [ "$cpu" = arm ]; then
echo "苍井空提示是否测速？（选择 1 测速，回车默认不测速）"
read -p "请选择: " menu
if [ -z $menu ]; then
./cfcdnip -tp $point -dd -tl 250
elif [ "$menu" == "1" ];then
speedtestrul
[[ $point =~ 2053|2083|2087|2096|8443|443 ]] && htp=https || htp=http
./cfcdnip -tp $point -url $htp://$URL -sl 2 -tl 250 -dn 5
else 
exit
fi
elif [ "$cpu" = 386 ]; then
echo "苍井空提示是否测速？（选择 1 测速，回车默认不测速）"
read -p "请选择: " menu
if [ -z $menu ]; then
./cfcdnip -tp $point -dd -tl 250
elif [ "$menu" == "1" ];then
speedtestrul
[[ $point =~ 2053|2083|2087|2096|8443|443 ]] && htp=https || htp=http
./cfcdnip -tp $point -url $htp://$URL -sl 2 -tl 250 -dn 5
else 
exit
fi
else
echo "悠哉提示是否测速？（选择 1 测速，回车默认不测速）"
read -p "请选择: " menu
if [ -z $menu ]; then
./cfcdnip -tp $point -dd -tl 250
elif [ "$menu" == "1" ];then
speedtestrul
[[ $point =~ 2053|2083|2087|2096|8443|443 ]] && htp=https || htp=http
./cfcdnip -tp $point -url $htp://$URL -sl 2 -tl 250 -dn 5
else 
exit
fi
fi
}

ipcdn1(){
echo
echo "稍等1分钟，对优选反代IP进行地区识别，并做排名"
rm -rf cdnIP.csv b.csv a.csv
awk -F ',' 'NR>1 && NR<=101 {print $1}' result.csv > a.csv
while IFS= read -r ip_address; do
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
response=$(curl -s --user-agent "${UA_Browser}" "https://api.ip.sb/geoip/$ip_address" -k | awk -F "country_code" '{print $2}' | awk -F'":"|","|"' '{print $2}')
if [ $? -eq 0 ]; then
echo "IP地址 $ip_address 的地区是: $response" | tee -a b.csv
else
echo "无法获取IP地址 $ip_address 的地区信息" | tee -a b.csv
fi
sleep 1
done < "a.csv"
grep 'SG' b.csv | head -n 3 >> cdnIP.csv
grep 'HK' b.csv | head -n 3 >> cdnIP.csv
grep 'JP' b.csv | head -n 3 >> cdnIP.csv
grep 'KR' b.csv | head -n 3 >> cdnIP.csv
grep 'TW' b.csv | head -n 3 >> cdnIP.csv
grep 'US' b.csv | head -n 3 >> cdnIP.csv
grep 'GB' b.csv | head -n 3 >> cdnIP.csv
grep 'DE' b.csv | head -n 3 >> cdnIP.csv
grep 'NL' b.csv | head -n 3 >> cdnIP.csv
grep 'FR' b.csv | head -n 3 >> cdnIP.csv
echo
echo "悠哉提示根据每个地区，排名前三的优选IP如下："
cat cdnIP.csv
}

ipcdn2(){
rm -rf cdnIP.csv
{
  grep 'HKG' ip.csv | head -n 3
  echo
  grep 'NRT' ip.csv | head -n 3
  echo
  grep 'KIX' ip.csv | head -n 3
  echo
  grep 'SIN' ip.csv | head -n 3
  echo
  grep 'ICN' ip.csv | head -n 3
  echo
  grep 'FRA' ip.csv | head -n 3
  echo
  grep 'LHR' ip.csv | head -n 3
  echo
  grep 'SJC' ip.csv | head -n 3
  echo
} >> cdnIP.csv
echo
echo "悠哉提示根据每个地区，排名前三的优选IP如下："
cat cdnIP.csv
}

rmrf(){
rm -rf ip.txt ipv6.txt cfcdnip result.csv cdnIP.csv a.csv b.csv ip.csv
}

echo "------------------------------------------------------"
echo "悠哉TG联系方式  ：@fuchenyouzaibot"
echo "悠哉TG联系方式 ：@youzaifuchenbot"
echo "苍井空提示 ：悠哉永久免费分享"
echo "------------------------------------------------------"
echo "CF优选官方IP V2026.03.08"
echo "------------------------------------------------------"
echo
echo "1. 悠哉优选CF官方IP"
echo "0. 退出"
read -p "苍井空提示请选择: " menu
if [ "$menu" == "1" ];then
rmrf && gfip
else 
exit
fi
