# 插件类
1. LeetCode for VS code
    + [搜索：LeetCode - ShengChen](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-leetcode)
    + 参考：https://zhuanlan.zhihu.com/p/56226189
2. Bracket Pair Colorizer 2
    + [搜索: Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)
    + 参考：https://zhuanlan.zhihu.com/p/54052970
    + 长期未更新，占用内存大，暂弃用
3. Microsoft
    + C/C++
    + Python
    + Visual Studio IntelliCode
    + Visual Studio Code Remote - WSL
    + Chinese (Simplified) Language Pack for Visual Studio Code
    + Remote - SSH
    + Remote - SSH: Editing Configuration Files
4. vscode-icons
5. [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
6. [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
7. [Peacock](https://marketplace.visualstudio.com/items?itemName=johnpapa.vscode-peacock)
    + 可以为每一个 VS Code 窗口配上不同的颜色
8. about Markdown
    + [GFM Preview](https://marketplace.visualstudio.com/items?itemName=tomoki1207.vscode-gfm-preview)
    + [Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)
    + [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
9. [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
    + Run in Terminal: 文件 -> 首选项 -> 设置 -> Run Code configuration -> [√] Run In Terminal
    + 自定义运行逻辑: settings.json: code-runner.executorMap
        - $workspaceRoot
        - $dir
        - $dirWithoutTrailingSlash
        - $fullFileName
        - $fileName
        - $fileNameWithoutExt 
    + 参考: https://zhuanlan.zhihu.com/p/54861567
10. [Todo Tree](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree)

# Err
1. The terminal process failed to launch: Starting directory (cwd) "xxx" does not exist.
    + 路径有非法字符(如含中文)，要么改路径，要么修改配置项:`"terminal.integrated.splitCwd"`不为`"inherited"`即可
