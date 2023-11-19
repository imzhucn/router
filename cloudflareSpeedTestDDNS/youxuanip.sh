MAPPING=$(curl -s https://d7uri8nf7uskq.cloudfront.net/tools/list-cloudfront-ips | \
    jq '.CLOUDFRONT_GLOBAL_IP_LIST | INDEX(.) | with_entries(.key |= (split("/") | .[0])  )')
RESULT=$(curl -s -X POST "http://ip-api.com/batch?lang=zh-CN&fields=61439" \
    --header "Content-Type: application/json" --data "$(echo ${MAPPING} | jq 'keys | .[:100]')")
CIRDS=$(
    echo "[$RESULT]" | jq --argjson all "${MAPPING}" \
    'flatten | map(select(.countryCode != "CN")) | map(.query) | .[] |$all[.]'
)
echo "${CIRDS//\"/}" > cf_ddns/youxuanip.txt
