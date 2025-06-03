#!/bin/bash

# ————————————————————————————————————————————————
# 반드시 cFS 디렉터리에서 실행해야 합니다.
# 로그가 쌓일 최상위 디렉터리 (cFS 기준 상대 경로)
LOG_ROOT="../../../../CAFuzz/StateAware/MsgFlowLogging/async_send_recv/non-snapshot/logs/cFS-stdout"

# 로그 최상위 디렉터리가 없으면 생성
if [ ! -d "$LOG_ROOT" ]; then
    mkdir -p "$LOG_ROOT"
fi

# 1. 세션 시작 시점의 타임스탬프 (예: 2025-03-23_194439)
SESSION_TS=$(date "+%Y-%m-%d_%H%M%S")
# 2. 세션 폴더명: stdout_YYYY-MM-DD_HHMMSS_session
SESSION_DIR="${LOG_ROOT}/stdout_${SESSION_TS}_session"
mkdir -p "$SESSION_DIR"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] 새로운 세션 폴더 생성: $(basename "$SESSION_DIR")"

# 무한 루프: core-cpu1 프로세스가 종료될 때마다 재시작하면서 새로운 로그 파일 생성
while true; do
    # 3. 각 반복마다 생성할 로그 파일용 타임스탬프
    LOOP_TS=$(date "+%Y-%m-%d_%H%M%S")
    # 로그 파일 경로 (예: stdout_2025-03-23_194441.log)
    LOG_FILE="${SESSION_DIR}/stdout_${LOOP_TS}.log"

    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Msg Log Generation process 시작 (로그: $(basename "$LOG_FILE"))..."

    # 4. core-cpu1 실행 → stdout/stderr를 화면에 출력하고, 동시에 해당 세션 폴더에 로그 파일 기록
    sudo ./core-cpu1 2>&1 | tee -a "$LOG_FILE"

    # 5. 프로세스 종료 시 메시지 출력
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Msg Log Generation process 종료. 5초 후 재시작..."

    # 6. 재시작 전 딜레이
    sleep 1
done
