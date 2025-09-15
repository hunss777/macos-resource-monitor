#!/bin/bash

# 맥북 리소스 사용률 요약 스크립트 (10줄)

echo "=== 맥북 리소스 사용률 요약 ==="
echo ""

# 1. CPU 사용률
echo "1. CPU 사용률:"
top -l 1 | grep "CPU usage" | awk '{print $3, $5, $7}'

# 2. 메모리 사용률
echo "2. 메모리 사용률:"
vm_stat | grep -E "(free|active|inactive|wired)" | head -4

# 3. 디스크 사용률
echo "3. 디스크 사용률:"
df -h / | tail -1 | awk '{print "사용: " $3 " / " $2 " (" $5 ")"}'

# 4. 네트워크 연결 수
echo "4. 활성 네트워크 연결:"
netstat -an | grep ESTABLISHED | wc -l | awk '{print $1 " 개"}'

# 5. 실행 중인 프로세스 수
echo "5. 실행 중인 프로세스:"
ps aux | wc -l | awk '{print $1-1 " 개"}'

# 6. 로드 평균
echo "6. 시스템 로드 평균:"
uptime | awk -F'load averages:' '{print $2}'

# 7. 배터리 상태 (노트북인 경우)
echo "7. 배터리 상태:"
pmset -g batt | grep -E "(InternalBattery|Battery)" | head -1

# 8. 온도 (가능한 경우)
echo "8. CPU 온도:"
sudo powermetrics --samplers smc -n 1 | grep -i "cpu die temperature" | head -1 || echo "온도 정보 없음"

# 9. 메모리 압박 상태
echo "9. 메모리 압박:"
vm_stat | grep "Pages compressed" | awk '{print "압축된 페이지: " $3}'

# 10. 시스템 업타임
echo "10. 시스템 업타임:"
uptime | awk '{print $3, $4}' | sed 's/,//'

echo ""
echo "=== 요약 완료 ==="
