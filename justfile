# デフォルト: レシピ一覧を表示
default:
    @just --list

# ソリューション全体をビルド
build:
    dotnet build

# Lox を実行 (例: just run script.lox)
run *args:
    dotnet run --project src/Lox -- {{args}}

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
