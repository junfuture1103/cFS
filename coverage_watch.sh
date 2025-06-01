#!/bin/bash

# 타겟 경로 및 백업 디렉토리 설정
BUILD_DIR="/home/jun20/jun/kaist_research/cFS/build"
LCOV_DIR="$BUILD_DIR/lcov"
BACKUP_BASE="/home/jun20/jun/kaist_research/coverage_backups"

# 백업 디렉토리 없으면 생성
mkdir -p "$BACKUP_BASE"

while true; do
    echo "[INFO] Running make lcov at $(date)"
    
    # 커버리지 생성
    make lcov

    # 타임스탬프 생성 (형식: YYYYMMDD_HHMMSS)
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    DEST="$BACKUP_BASE/lcov_$TIMESTAMP"

    # 리포트 백업
    cp -r "$LCOV_DIR" "$DEST"

    echo "[INFO] Backup completed: $DEST"

    # 30초 대기
    sleep 60
done

