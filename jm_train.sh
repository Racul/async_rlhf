#!/bin/bash

SESSION_NAME="online_dpo"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# tmux 세션이 이미 있으면 attach, 없으면 새로 생성
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION_NAME
fi

# 명령어를 tmux 세션에 입력
tmux send-keys -t $SESSION_NAME "cd $PROJECT_DIR" C-m
tmux send-keys -t $SESSION_NAME "source .venv/bin/activate" C-m
tmux send-keys -t $SESSION_NAME "python online_dpo.py --config configs/onlinedpo_pythia410m_tldr.yml --wandb_run_id test" C-m

echo "Started online_dpo.py in tmux session: $SESSION_NAME"
echo "접속하려면: tmux attach -t $SESSION_NAME"
