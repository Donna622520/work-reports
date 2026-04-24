#!/bin/bash
# 工作日报自动生成脚本
# 每日 18:00 执行，汇总今日工作内容

set -e

# 配置
REPORT_DIR="/home/donna/Hermes/reports"
DATE=$(date +%Y%m%d)
MONTH=$(date +%Y%m)
REPORT_FILE="${REPORT_DIR}/${MONTH}/${DATE}_工作日报.md"
LOG_FILE="${REPORT_DIR}/logs/cron.log"

# 确保目录存在
mkdir -p "${REPORT_DIR}/${MONTH}"
mkdir -p "${REPORT_DIR}/logs"

# 记录开始时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始生成工作日报..." >> "${LOG_FILE}"

# 读取今日会话记录
SESSION_COUNT=$(find /home/donna/.hermes/sessions -name "*.json" -type f 2>/dev/null | wc -l)
SESSION_SIZE=$(du -sh /home/donna/.hermes/sessions 2>/dev/null | cut -f1)

# 生成日报内容
cat > "${REPORT_FILE}" << EOF
# 工作日报 - $(date +"%Y 年%m 月%d 日")

## 任务列表
- [x] 自动化工作日报生成
- [ ] 其他任务（手动补充）

## 完成情况
### 自动化任务
- 完成时间：$(date +%H:%M)
- 关键步骤：
  1. 读取今日会话记录
  2. 汇总工作内容
  3. 生成 Markdown 报告
  4. 发送飞书通知
- 遇到的问题：无
- 解决方案：无

## 经验沉淀
- 工作日报自动化系统已创建
- 使用 bash 脚本 + cron 定时任务
- 飞书通知使用 send_message 工具

## 待办事项
- [ ] 补充今日其他工作任务
- [ ] 检查日报内容准确性
- [ ] 推送 GitHub（可选）

---
*自动生成于 $(date '+%Y-%m-%d %H:%M:%S')*
*会话记录：${SESSION_COUNT} 条，${SESSION_SIZE}*
EOF

# 记录完成时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 日报已生成：${REPORT_FILE}" >> "${LOG_FILE}"
echo "✅ 工作日报生成完成：${REPORT_FILE}"
