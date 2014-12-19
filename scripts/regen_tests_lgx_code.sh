DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
luajit "$DIR/../proj.cocoside/lgk/lgxcodegen/lgxcodegen.lua" "$DIR/../proj.cocoside/generated_lgx" -r "$DIR/../proj.cocoside/tests"