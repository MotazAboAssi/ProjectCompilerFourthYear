import gen.TemplateLiterals;
import org.antlr.v4.runtime.*;
import java.util.*;

/**
 * Test runner for the generated TemplateLiterals lexer.
 * Requires TemplateLiterals.g4 to be generated with ANTLR 4.13.2.
 */
public class TemplateLexerTest {

    private static final class TestCase {
        final String group;
        final String name;
        final String input;

        TestCase(String group, String name, String input) {
            this.group = group;
            this.name = name;
            this.input = input;
        }
    }

    private static final List<TestCase> TESTS = Arrays.asList(
        // Basic templates
        t("Basic", "empty template", "``"),
        t("Basic", "plain text", "`Hello World`"),
        t("Basic", "Arabic", "`مرحبا بالعالم`"),
        t("Basic", "multiline", "`Hello\nWorld`"),
        t("Basic", "quotes in template text", "`He said \"Hello\" and it's fine`"),
        t("Basic", "dollar alone", "`Price: $100`"),
        t("Basic", "two dollars before interpolation", "`$$${value}`"),
        t("Basic", "escaped interpolation opener", "`\\${value}`"),
        t("Basic", "backslash then interpolation", "`\\\\${value}`"),
        t("Basic", "escaped backtick", "`Hello \\` World`"),
        t("Basic", "unicode and emoji", "`😀 🌍 中文 العربية`"),

        // Escape sequences
        t("Escapes", "newline escape", "`Hello\\nWorld`"),
        t("Escapes", "tab escape", "`Hello\\tWorld`"),
        t("Escapes", "backslash escape", "`C:\\\\Users\\\\Test`"),
        t("Escapes", "line continuation", "`Line one\\\nLine two`"),
        t("Escapes", "trailing backslash (boundary)", "`Hello\\"),

        // Interpolations and operators
        t("Interpolation", "identifier", "`${name}`"),
        t("Interpolation", "integer", "`${123}`"),
        t("Interpolation", "boolean", "`${true}`"),
        t("Interpolation", "null", "`${null}`"),
        t("Interpolation", "addition", "`${a + b}`"),
        t("Interpolation", "conditional", "`${a ? b : c}`"),
        t("Interpolation", "nullish coalescing", "`${a ?? b}`"),
        t("Interpolation", "optional property", "`${a?.b}`"),
        t("Interpolation", "spread", "`${...items}`"),
        t("Interpolation", "assignment", "`${a += 10}`"),
        t("Interpolation", "prefix increment", "`${++a}`"),
        t("Interpolation", "postfix increment", "`${a++}`"),

        // Nested templates / braces / objects / arrays
        t("Nesting", "nested template", "`${`Inner ${name}`}`"),
        t("Nesting", "three nested templates", "`A ${`B ${`C ${value}`}`}`"),
        t("Nesting", "object literal", "`${({a: 1, b: 2})}`"),
        t("Nesting", "nested object", "`${({a: {b: {c: 3}}})}`"),
        t("Nesting", "array", "`${([1, 2, 3])}`"),
        t("Nesting", "nested array and object", "`${([1, {b: [2, {c: 3}]}])}`"),
        t("Nesting", "arrow returning object", "`${(() => ({a: 10}))()}`"),
        t("Nesting", "function with nested block", "`${(() => { if (true) { return {a: 1}; } })()}`"),
        t("Nesting", "object method", "`${({method() { return 10; }})}`"),
        t("Nesting", "computed property", "`${({[name]: value})}`"),

        // Numbers
        t("Numbers", "decimal integer", "`${123}`"),
        t("Numbers", "underscored integer", "`${1_000_000}`"),
        t("Numbers", "decimal fraction", "`${12.5}`"),
        t("Numbers", "leading-dot fraction", "`${.5}`"),
        t("Numbers", "trailing-dot fraction", "`${1.}`"),
        t("Numbers", "exponent", "`${1e10}`"),
        t("Numbers", "signed exponent", "`${1.5E-10}`"),
        t("Numbers", "hex", "`${0xFF}`"),
        t("Numbers", "hex bigint", "`${0xFFn}`"),
        t("Numbers", "binary", "`${0b1010}`"),
        t("Numbers", "binary bigint", "`${0b1010n}`"),
        t("Numbers", "octal", "`${0o755}`"),
        t("Numbers", "decimal bigint", "`${123n}`"),

        // Strings and comments
        t("Strings", "double quoted", "`${\"Hello\"}`"),
        t("Strings", "single quoted", "`${'Hello'}`"),
        t("Strings", "brace inside string", "`${\"}\"}`"),
        t("Strings", "comment marker inside string", "`${\"/* not a comment */\"}`"),
        t("Comments", "single line", "`${// comment\n10}`"),
        t("Comments", "multiline", "`${/* comment */ 10}`"),
        t("Comments", "brace inside multiline comment", "`${/* { } */ value}`"),
        t("Comments", "comment between operands", "`${10 /* comment */ + 20}`"),

        // Regex and division: heuristic stress cases, not a full JS parser
        t("RegexDivision", "regex literal", "`${/abc/g}`"),
        t("RegexDivision", "regex character class", "`${/[a-z]+/i}`"),
        t("RegexDivision", "regex escaped slash", "`${/https?:\\/\\//}`"),
        t("RegexDivision", "regex containing brace", "`${/}/}`"),
        t("RegexDivision", "division", "`${100 / 5}`"),
        t("RegexDivision", "repeated division", "`${a / b / c}`"),
        t("RegexDivision", "regex after unary not", "`${!/abc/.test(value)}`"),
        t("RegexDivision", "regex after return keyword", "`${returnValue / 2}`"),
        t("RegexDivision", "regex vs division after parenthesis", "`${(a) / b}`"),

        // Unicode identifiers
        t("Identifiers", "ASCII", "`${myVariable_123}`"),
        t("Identifiers", "dollar identifier", "`${$element}`"),
        t("Identifiers", "Arabic identifier", "`${العربية}`"),
        t("Identifiers", "CJK identifier", "`${变量}`"),
        t("Identifiers", "Greek identifier", "`${αβγ}`"),
        t("Identifiers", "unicode escape", "`${\\u0041}`"),
        t("Identifiers", "code point escape", "`${\\u{41}}`"),

        // EOF / incomplete input: these are deliberately incomplete test inputs
        t("Incomplete", "unterminated template", "`Hello"),
        t("Incomplete", "unterminated interpolation", "`${name"),
        t("Incomplete", "unterminated object interpolation", "`${{a: 1}"),
        t("Incomplete", "unterminated double string", "`${\"hello"),
        t("Incomplete", "unterminated single string", "`${'hello"),
        t("Incomplete", "unterminated block comment", "`${/* comment"),
        t("Incomplete", "nested template reaches EOF", "`Outer ${`Inner"),
        t("Incomplete", "nested interpolation reaches EOF", "`Outer ${`Inner ${x}"),

        // Malformed / boundary inputs: a lexer may tokenize these without proving JS syntax validity
        t("Malformed", "empty interpolation", "`${}`"),
        t("Malformed", "unclosed object", "`${{`"),
        t("Malformed", "extra closing brace", "`${}}`"),
        t("Malformed", "mismatched paren", "`${(}`"),
        t("Malformed", "missing right operand", "`${a +}`"),
        t("Malformed", "bad hex", "`${0x}`"),
        t("Malformed", "bad binary", "`${0b2}`"),
        t("Malformed", "bad exponent", "`${1e+}`"),
        t("Malformed", "double decimal point", "`${1.2.3}`"),
        t("Malformed", "leading zero", "`${01}`"),

        // Stress inputs
        t("Stress", "deep nested templates",
            "`A ${`B ${`C ${`D ${`E ${value}`}`}`}`}`"),
        t("Stress", "deep braces",
            "`${{a:{b:{c:{d:{e:{f:{g:{h:{i:10}}}}}}}}}}`"),
        t("Stress", "long array",
            "`${[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]}`"),
        t("Stress", "combined expression",
            "`Result: ${(() => { const data = {users: [{name: \"Ali\", age: 20}, {name: \"Sara\", age: 25}]}; return data.users.filter(user => user.age > 20).map(user => `${user.name}: ${user.age}`).join(\", \"); })()}`"),
            // INSANE LEVEL: Multi-line DSL with multiple interpolations & whitespace
            t("Stress", "insane DSL template body",
                    "`\n  SET gold ${startingGold}\n  ADD gold ${bonus}\n  ADD gold 25\n  LOG gold\n`"),

            // INSANE LEVEL (Ultra-Stress): Self-executing IIFE containing the full DSL parser + tagged template
            t("Stress", "insane multiline DSL engine in IIFE",
                    "`${((strings, ...values) => {\n" +
                            "    const state = {};\n" +
                            "    const script = strings.reduce(\n" +
                            "        (acc, str, i) =>\n" +
                            "            acc + str +\n" +
                            "            (values[i] !== undefined\n" +
                            "                ? JSON.stringify(values[i])\n" +
                            "                : \"\"),\n" +
                            "        \"\"\n" +
                            "    );\n" +
                            "\n" +
                            "    script.trim().split(\"\\n\").forEach(line => {\n" +
                            "        const parts = line.trim().split(\" \");\n" +
                            "        const cmd = parts[0];\n" +
                            "        const key = parts[1];\n" +
                            "        const val = parts[2];\n" +
                            "\n" +
                            "        if (cmd === \"SET\") {\n" +
                            "            state[key] = Number(val);\n" +
                            "        }\n" +
                            "\n" +
                            "        if (cmd === \"ADD\") {\n" +
                            "            state[key] = (state[key] || 0) + Number(val);\n" +
                            "        }\n" +
                            "    });\n" +
                            "\n" +
                            "    return state.gold;\n" +
                            "})`SET gold ${100}\n" +
                            "ADD gold ${50}`}`")    );

    private static TestCase t(String group, String name, String input) {
        return new TestCase(group, name, input);
    }

    private static final class CountingErrorListener extends BaseErrorListener {
        int count = 0;

        @Override
        public void syntaxError(
            Recognizer<?, ?> recognizer,
            Object offendingSymbol,
            int line,
            int charPositionInLine,
            String msg,
            RecognitionException e
        ) {
            count++;
            System.out.printf(
                "  LEXER ERROR at %d:%d: %s%n",
                line, charPositionInLine, msg
            );
        }
    }

    public static void main(String[] args) {
        String filter = args.length == 0 ? "" : args[0].toLowerCase(Locale.ROOT);
        int passedWithoutLexerErrors = 0;
        int testsRun = 0;

        for (int i = 0; i < TESTS.size(); i++) {
            TestCase test = TESTS.get(i);

            if (!filter.isEmpty()
                && !test.group.toLowerCase(Locale.ROOT).contains(filter)
                && !test.name.toLowerCase(Locale.ROOT).contains(filter)) {
                continue;
            }

            testsRun++;
            CountingErrorListener errors = new CountingErrorListener();

            System.out.println("\n==================================================");
            System.out.printf("TEST %03d | %s | %s%n", i + 1, test.group, test.name);
            System.out.println("INPUT: " + printable(test.input));

            TemplateLiterals lexer =
                new TemplateLiterals(CharStreams.fromString(test.input));

            lexer.removeErrorListeners();
            lexer.addErrorListener(errors);

            boolean sawEnd = false;
            try {
                while (true) {
                    Token token = lexer.nextToken();
                    int type = token.getType();

                    String tokenName;
                    if (type == Token.EOF) {
                        tokenName = "EOF";
                        sawEnd = true;
                    } else {
                        tokenName = lexer.getVocabulary().getSymbolicName(type);
                        if (tokenName == null) {
                            tokenName = lexer.getVocabulary().getDisplayName(type);
                        }
                    }

                    System.out.printf(
                        "  %-34s text=%s line=%d column=%d%n",
                        tokenName,
                        printable(token.getText()),
                        token.getLine(),
                        token.getCharPositionInLine()
                    );

                    if (type == Token.EOF) {
                        break;
                    }
                }
            } catch (Exception ex) {
                System.out.println("  RUNTIME EXCEPTION: " + ex);
            }

            if (errors.count == 0 && sawEnd) {
                passedWithoutLexerErrors++;
                System.out.println("  RESULT: completed without ANTLR lexer errors");
            } else {
                System.out.println("  RESULT: inspect errors / runtime behavior");
            }
        }

        System.out.println("\n================ SUMMARY ================");
        System.out.println("Tests selected: " + testsRun);
        System.out.println("Completed without ANTLR lexer errors: " + passedWithoutLexerErrors);
        System.out.println("Note: completion does NOT mean the JavaScript input is syntactically valid.");
        System.out.println("Inspect token names for UNTERMINATED_* and malformed-input cases.");
    }

    private static String printable(String s) {
        if (s == null) return "<null>";
        return "\"" + s
            .replace("\\", "\\\\")
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t")
            .replace("\"", "\\\"") + "\"";
    }
}
