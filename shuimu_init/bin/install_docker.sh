install -m 0755 -d /etc/apt/keyrings
cp files/docker.asc /etc/apt/keyrings/
cp files/docker.gpg /etc/apt/keyrings/
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu   jammy stable" > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y docker-ce=5:27.5.0-1~ubuntu.22.04~jammy docker-compose
