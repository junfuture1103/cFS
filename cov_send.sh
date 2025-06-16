#!/bin/bash
# udp_listener.sh

# 수신할 UDP 포트와 검사할 키워드 설정
PORT=9999
KEYWORD="RUN"
PASSWORD="1234"

echo "▶ Listening on UDP port ${PORT}..."

while true; do
    nc -u -l -p "${PORT}" | while IFS= read -r LINE; do
        # 모든 메시지를 기본 출력
        echo "Received: ${LINE}"

        # 메시지에 KEYWORD가 포함되어 있는지 검사
        if [[ "${LINE}" == *"${KEYWORD}"* ]]; then
            echo "⚠️ Detected keyword '${KEYWORD}' in message!"
            echo "$PASSWORD" | sudo -S ./share_cov_dir_setting.sh
            ./coverage_logger.sh
	fi
    done
done

