import requests
from datetime import datetime, timedelta

def delete_repository(repo_name):
    """
    删除指定名称的仓库
    Args:
        repo_name (str): 要删除的仓库名称
    Returns:
        bool: 删除是否成功
    """
    delete_url = f'https://harbor-sg.jiuduotech.com/api/v2.0/projects/jsy-tmp/repositories/{repo_name}'
    headers = {
        'Authorization': 'Basic xxxxxxxxxxxxxx'  # 替换为你的实际token
    }
    try:
        response = requests.delete(delete_url, headers=headers)
        response.raise_for_status()
        print(f"成功删除仓库: {repo_name}")
        return True
    except requests.exceptions.RequestException as e:
        print(f"删除仓库 {repo_name} 失败: {e}")
        return False

#delete_repository("pod5684184588075988508553shhyt6ic3suhbdeb5c1k4")

#====================================
url = 'https://harbor-sg.jiuduotech.com/api/v2.0/projects/jsy-tmp/repositories?page=1&page_size=100'
headers = {
    'Authorization': 'Bearer YOUR_TOKEN_HERE'  # 替换为你的实际token
}

# 计算四天前的日期
four_days_ago = datetime.now() - timedelta(days=3)
four_days_ago = four_days_ago.replace(hour=0, minute=0, second=0, microsecond=0)  # 设置为那天开始

REPO_COUNT = 0
try:
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    data = response.json()
    
    # 假设data是一个列表，检查每个条目的creation_time和name
    for item in data:
        creation_time_str = item.get('creation_time')
        name = item.get('name', '')
        if creation_time_str and name.startswith('jsy-tmp/pod'):
            # 解析带毫秒的时间，例如 "2025-06-03T05:51:10.410Z"
            creation_time = datetime.strptime(creation_time_str, '%Y-%m-%dT%H:%M:%S.%fZ')
            # 比较日期（忽略时间）
            if creation_time.date() < four_days_ago.date():
                print(item)
                # 在打印后调用删除方法
                name = name.replace('jsy-tmp/', '', 1) 
                delete_repository(name)

                REPO_COUNT += 1
    print(f"已成功删除4天前的镜像：{REPO_COUNT} 个")
except requests.exceptions.RequestException as e:
    print(f"请求失败: {e}")
except ValueError as e:
    print(f"日期解析错误: {e}")
