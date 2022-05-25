let g:vimspector_adapters ={ "adapter" : "vscode-cpptools"}
let g:vimspector_configurations = {
\  "cpp": {
\    "adapter": "vscode-cpptools",
\    "configuration": {
\      "name": "cpp",
\      "type": "cppdbg",
\      "request": "launch",
\      "program": "${fileDirname}/../demo",
\      "args": ["./demo"],
\      "cwd": "${workspaceRoot}/..",
\      "environment": [],
\      "externalConsole": v:false,
\      "stopAtEntry": v:true,
\      "MIMode": "gdb",
\      "logging": {
\        "engineLogging": v:true
\      }
\    }
\  },
\  "python": {
\    "adapter": "debugpy",
\    "configuration": {
\      "request": "launch",
\      "program": "${workspaceRoot}/../demo.py",
\      "args":["./demo"],
\      "stopOnEntry": v:true,
\      "cwd": "${workspaceRoot}/.."
\    }
\  }
\}
 
let g:quickCompileCommand = ""      "Compile command
let g:quickRunCommand = ""          "Run command
