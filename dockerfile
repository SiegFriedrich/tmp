# 使用带有 IIS 的 Windows Server Core 基础镜像
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

# 启用 IIS 角色
RUN powershell -Command Add-WindowsFeature Web-Server

# 安装 .NET Core Hosting Bundle
RUN powershell -Command \
    Invoke-WebRequest -OutFile dotnet-hosting.exe \
    https://download.visualstudio.microsoft.com/download/pr/8db2db8f-4871-429a-9c9e-4a9e7110605c/701c06f1c9e1d08ad8b3c7d8404685f0/dotnet-hosting-5.0.9-win.exe \
    && .\dotnet-hosting.exe /quiet /norestart \
    && Remove-Item -Force dotnet-hosting.exe

# 设置工作目录
WORKDIR /inetpub/wwwroot

# 复制发布的应用程序文件到工作目录
COPY ./publish/ .
