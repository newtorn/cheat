LOG_DIR=./log

mkdir -p $LOG_DIR

echo "start cheat server"
nohup ./cheat serve > $LOG_DIR/cheat.log 2>&1 &

echo "start cheat docs server"
nohup ./cheat-docs > $LOG_DIR/cheat-docs.log 2>&1 &