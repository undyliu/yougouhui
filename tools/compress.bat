@echo off
echo 当前盘符：%~d0
echo 当前盘符和路径：%~dp0

cd %~dp0
echo 正在拷贝目录到mobile中
XCOPY /s /Y "../server/src/public" "../mobile/www" 

rd "../mobile/www/app" /s /q
rd "../mobile/www/upload" /s /q
rd "../mobile/www/yougouhui.esproj" /s /q

cd %~dp0

echo 正在混淆css文件
for /R ../mobile/www/css/ %%s in (*.css) do (
  echo 文件: %%s
  java -jar yuicompressor-2.4.8.jar -o '.css$:-min.css' %%s --charset utf-8
)

echo 正在混淆js文件
for /R ../mobile/www/js/ %%s in (*.js) do (
  echo 文件: %%s
  java -jar yuicompressor-2.4.8.jar -o '.js$:-min.js' %%s --charset utf-8
) 

echo 混淆完成

cd ../mobile
echo 正在运行cordova prepare
cordova prepare


pause
