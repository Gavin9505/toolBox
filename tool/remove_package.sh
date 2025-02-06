#!/bin/bash
function FroceRemove {
    # 提示用戶輸入包名稱
    echo "請輸入要刪除的包名稱（例如 ros-noetic）："
    read base_package

    # 查找與指定包名稱相關的所有包
    echo "正在查找與 $base_package 相關的所有包..."

    # 列出所有與指定包名稱相關的已安裝包
    packages_to_remove=$(dpkg --get-selections | grep "$base_package" | awk '{print $1}')

    # 如果沒有找到匹配的包，則退出
    if [ -z "$packages_to_remove" ]; then
	echo "未找到與 $base_package 相關的包。"
	exit 1
    fi

    # 顯示將要刪除的包
    echo "以下是將要刪除的包："
    echo "$packages_to_remove"

    # 提示用戶確認刪除
    echo "是否繼續刪除這些包？ (y/n)"
    read confirmation

    # 根據用戶確認執行刪除操作
    if [[ "$confirmation" == "y" || "$confirmation" == "Y" ]]; then
	# 遍歷每個包名稱並刪除
	echo "正在刪除選擇的包..."
	for package in $packages_to_remove; do
	    echo "正在刪除包: $package"
	    sudo dpkg -r --force-all "$package"
	done
	echo "所有相關包已刪除完成。"
    else
	echo "取消刪除操作。"
    fi
}
