# EZlang コーディング規約

## 命名規則

| 対象 | 規約 | 例 |
|---|---|---|
| ローカル変数・引数 | camelCase | `string sourceCode`, `int lineNumber` |
| private フィールド | `_` + camelCase | `private int _current;` |
| public プロパティ | PascalCase | `public Token Token { get; }` |
| メソッド | PascalCase | `ScanTokens()` |
| クラス | PascalCase | `Scanner` |
| インターフェース | `I` + PascalCase | `IVisitor` |
| 定数 (`const`) | PascalCase | `const int MaxDepth = 64;` |
| 名前空間 | PascalCase | `EZlang` |
| ファイル名 | クラス名と一致させる | `Scanner.cs` |

- Java との最大の違い: **メソッド名は先頭大文字**（`scanTokens()` → `ScanTokens()`）
- private フィールドの `_` 接頭辞により `this.current = current` のような曖昧さ回避が不要になる

## Java → C# 対応表（jlox 移植用）

| Java (jlox) | C# (EZlang) |
|---|---|
| `System.exit(64)` | `Environment.Exit(64)` |
| `static void main(String[] args)` | `static void Main(string[] args)`（先頭大文字必須） |
| `Files.readAllBytes(Paths.get(path))` | `File.ReadAllText(path)` |
| `BufferedReader` + `readLine()` (REPL) | `Console.ReadLine()`（EOF で `null` は同じ） |
| `e.printStackTrace()` | `Console.Error.WriteLine(e)`（`ToString()` がスタックトレース込み） |
| `e.getMessage()` | `e.Message` |
| `e.getCause()` | `e.InnerException` |
| `throws IOException`（検査例外） | 不要（削除する） |
| try-with-resources `try (var r = ...)` | `using var r = ...;` |
| `String` | `string` |

## エラー処理の方針（Crafting Interpreters 準拠）

- **構文エラー**: 例外を投げず、エラー報告メソッドで表示して `hadError` フラグを立てる。
  パーサ内部の同期（panic mode recovery）にのみ `ParseError` 例外を使う
- **実行時エラー**: `RuntimeError : Exception` を投げ、インタプリタ最上位で catch して報告
- **終了コード**: 使い方エラー = 64 / 構文エラー = 65 / 実行時エラー = 70

```csharp
class RuntimeError : Exception
{
    public Token Token { get; }
    public RuntimeError(Token token, string message) : base(message)
    {
        Token = token;
    }
}
```
