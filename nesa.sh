#!/bin/bash

# 欢迎信息
echo "欢迎使用 Nesa 矿工节点安装脚本"
echo "关注我的推特获取更多更新: https://x.com/BtcK241918"

# 菜单函数
show_menu() {
    echo "请选择一个操作:"
    echo "1) 安装必要依赖并安装 Nesa 矿工节点"
    echo "2) 卸载 Nesa 矿工节点"
    echo "3) 退出"
}

# 安装必要依赖并安装 Nesa 矿工节点的函数
install_nesa() {
    echo "正在安装必要的依赖..."
    sudo apt update && sudo apt install curl jq -y
    
    # 安装 Python 和 pip
    if ! command -v python3 &> /dev/null; then
        echo "未检测到 Python3，正在安装..."
        sudo apt install python3 python3-pip -y
    fi
    
    # 安装 ecdsa 模块
    echo "检查并安装 ecdsa 模块..."
    if ! python3 -c "import ecdsa" &> /dev/null; then
        echo "未安装 ecdsa，正在安装..."
        pip3 install ecdsa
        echo "ecdsa 模块安装完成！"
    else
        echo "ecdsa 模块已安装，跳过安装步骤。"
    fi

    # 安装 Nesa 矿工节点
    echo "正在安装 Nesa 矿工节点..."
    bash <(curl -s https://raw.githubusercontent.com/nesaorg/bootstrap/master/bootstrap.sh)
    echo "Nesa 矿工节点安装完成！"
}

# 卸载 Nesa 矿工节点的函数
uninstall_nesa() {
    echo "正在卸载 Nesa 矿工节点..."
    # 在这里添加卸载命令
    echo "Nesa 矿工节点卸载完成！"
}

# 主循环
while true; do
    show_menu
    read -p "请输入选项: " choice
    case $choice in
        1)
            install_nesa
            ;;
        2)
            uninstall_nesa
            ;;
        3)
            echo "退出脚本。"
            exit 0
            ;;
        *)
            echo "无效的选项，请重新选择。"
            ;;
    esac
done
