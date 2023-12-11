# 使用带有 IIS 的 Windows Server Core 基础镜像
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

# 启用 IIS 角色
RUN powershell -Command Add-WindowsFeature Web-Server

# 设置工作目录
WORKDIR /app

# 复制 .NET Hosting Bundle 安装程序到容器
COPY dotnet-hosting-6.0.24-win.exe /app/dotnet-hosting.exe

# 安装 .NET 6.0 Hosting Bundle
RUN .\dotnet-hosting.exe /quiet /norestart \
    && Remove-Item -Force dotnet-hosting.exe

# 将工作目录更改为 IIS 默认网站目录
WORKDIR /inetpub/wwwroot

# 复制发布的应用程序文件到工作目录
COPY ./publish/ .
