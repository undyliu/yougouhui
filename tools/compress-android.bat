@echo off
echo 当前盘符和路径：%~dp0

cd %~dp0

echo 正在混淆css文件
for /R ../mobile/platforms/android/assets/www/ %%s in (*.css) do (
  echo 文件: %%s
  java -jar yuicompressor-2.4.8.jar -o '.css$:-min.css' %%s --charset utf-8
)

echo 正在混淆js文件
for /R ../mobile/platforms/android/assets/www/ %%s in (*.js) do (
  echo 文件: %%s
  java -jar yuicompressor-2.4.8.jar -o '.js$:-min.js' %%s --charset utf-8
) 

echo 混淆完成

pause
