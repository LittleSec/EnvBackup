::https://zhuanlan.zhihu.com/p/75250739
::将该bat脚本放到图片所在文件夹
::jpeg: 只修改文件后缀为jpeg的文件
::IMG_QQphoto: 重命名的规则，按需自定义
@echo off
set a=1
setlocal EnableDelayedExpansion
for %%n in (*.jpeg) do (
set /A a+=1
ren "%%n" "IMG_QQphoto!a!.jpeg"
)