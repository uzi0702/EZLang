# デフォルト: レシピ一覧を表示
default:
    @just --list

# ソリューション全体をビルド
build:
    dotnet build

# EZlang を実行 (例: just run script.ez)
run *args:
    dotnet run --project src/EZlang -- {{args}}

# テストを実行 (テストプロジェクト追加後に有効)
test:
    dotnet test

# ビルド成果物を削除
clean:
    dotnet clean
    find . -type d \( -name bin -o -name obj \) -exec rm -rf {} +

# リリースビルド
release:
    dotnet build -c Release
