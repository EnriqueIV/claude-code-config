#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
RATE_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
CTX_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'; DIM='\033[2m'

# Context bar color
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

# Rate limit bar color
if [ "$RATE_PCT" -ge 90 ]; then RATE_COLOR="$RED"
elif [ "$RATE_PCT" -ge 70 ]; then RATE_COLOR="$YELLOW"
else RATE_COLOR="$GREEN"; fi

# Context bar (line 2)
FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

# Rate limit bar (line 1)
RATE_FILLED=$((RATE_PCT / 10)); RATE_EMPTY=$((10 - RATE_FILLED))
printf -v RFILL "%${RATE_FILLED}s"; printf -v RPAD "%${RATE_EMPTY}s"
RATE_BAR="${RFILL// /█}${RPAD// /░}"

# Tokens: convert to k
TOKENS_K=$(echo "$INPUT_TOKENS $CTX_SIZE" | awk '{printf "%dk/%dk", $1/1000, $2/1000}')

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

BRANCH=""
git rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git branch --show-current 2>/dev/null)"

echo -e "${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}$BRANCH | ${RATE_COLOR}${RATE_BAR}${RESET} ${RATE_PCT}% rate | ${DIM}${TOKENS_K} tokens${RESET}"
COST_FMT=$(printf '$%.2f' "$COST")
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% ctx | ${YELLOW}${COST_FMT}${RESET} | ⏱️ ${MINS}m ${SECS}s"
